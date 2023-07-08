return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "rust" })
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = {
            'williamboman/mason.nvim',
            'mfussenegger/nvim-dap',
            'neovim/nvim-lspconfig',
        },
        cond = function()
            local loaded, registry = pcall(require, 'mason-registry')
            if loaded then
                return registry.is_installed('rust-analyzer')
            end
            return false
        end,
        config = function()
            local registry = require 'mason-registry'
            local codelldb = registry.get_package('codelldb')
            local dap_config = {}
            if codelldb then
                local install_path = codelldb:get_install_path()
                local extension_path = install_path .. '/extension/'
                local codelldb_path = extension_path .. 'adapter/codelldb'
                local liblldb_path = extension_path .. 'lldb/lib/liblldb'

                local this_os = vim.loop.os_uname().sysname;
                -- The path in windows is different
                if this_os:find "Windows" then
                    codelldb_path = extension_path .. "adapter\\codelldb.exe"
                    liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
                else
                    -- The liblldb extension is .so for linux and .dylib for macOS
                    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
                end
                dap_config = {
                    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
                }
            end
            require('rust-tools').setup({
                tools = {
                    inlay_hints = {
                        -- automatically set inlay hints (type hints)
                        -- default: true
                        auto = true,
                    }

                },
                server = {
                    settings = {
                        ["rust-analyzer"] = {
                            enable = true,
                            cargo = {
                                autoReload = true,
                            },
                        }
                    },
                },
                dap = dap_config
            })

            require('dap.ext.vscode').load_launchjs(nil, { rt_lldb = { 'rust' } })
        end
    },
    {
        'saecki/crates.nvim',
        event = 'BufRead Cargo.toml',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            popup = {
                style = "minimal",
                border = "rounded",
            },
            on_attach = function(bufnr)
                require('which-key').register({
                    c = {
                        name = "Crates",
                        t = { function() require('crates').toggle() end, "Toggle" },
                        r = { function() require('crates').reload() end, "Reload" },
                        v = { function() require('crates').show_versions_popup() end, "Show versions" },
                        f = { function() require('crates').show_features_popup() end, "Show features" },
                        d = { function() require('crates').show_dependencies_popup() end, "Show dependencies" },
                        --u = { function() require('crates').update_crate() end, "Update crate" },
                        u = { function() require('crates').update_crate() end, "Update crates" },
                        a = { function() require('crates').update_all_crates() end, "Update all crates" },
                        --U = { function() require('crates').upgrade_crate() end, "Upgrade crate" },
                        U = { function() require('crates').upgrade_crates() end, "Upgrade crates" },
                        A = { function() require('crates').upgrade_all_crates() end, "Upgrade all crates" },
                        H = { function() require('crates').open_homepage() end, "Open homepage" },
                        R = { function() require('crates').open_repository() end, "Open repository" },
                        D = { function() require('crates').open_documentation() end, "Open documentation" },
                        C = { function() require('crates').open_crates_io() end, "Open Crates.io" },
                    }
                }, {
                    noremap = true,
                    silent = true,
                    buffer = bufnr,
                    prefix = '<leader>'
                })
            end,
        }
    },
}
