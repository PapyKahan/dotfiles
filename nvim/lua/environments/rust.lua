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
                            --enable = true,
                            imports = {
                                granularity = {
                                    group = "module",
                                },
                                prefix = "self",
                            },
                            cargo = {
                                autoReload = true,
                            },
                            procMacro = {
                                enable = true
                            },
                            diagnostics = {
                                enable = true,
                                disabled = { "unresolved-proc-macro" },
                                --enableExperimental = true,
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
        event = { 'BufRead Cargo.toml' },
        dependencies = 'nvim-lua/plenary.nvim',
        keys = {
            { "<leader>r",  group = "Rust",                                             desc = "Rust", ft = "Cargo.toml" },
            { "<leader>rt", function() require('crates').toggle() end,                  desc = "Toggle" },
            { "<leader>rr", function() require('crates').reload() end,                  desc = "Reload" },
            { "<leader>rv", function() require('crates').show_versions_popup() end,     desc = "Show versions" },
            { "<leader>rf", function() require('crates').show_features_popup() end,     desc = "Show features" },
            { "<leader>rd", function() require('crates').show_dependencies_popup() end, desc = "Show dependencies" },
            { "<leader>ru", function() require('crates').update_crate() end,            desc = "Update crates" },
            { "<leader>ra", function() require('crates').update_all_crates() end,       desc = "Update all crates" },
            { "<leader>rU", function() require('crates').upgrade_crates() end,          desc = "Upgrade crates" },
            { "<leader>rA", function() require('crates').upgrade_all_crates() end,      desc = "Upgrade all crates" },
            { "<leader>rH", function() require('crates').open_homepage() end,           desc = "Open homepage" },
            { "<leader>rR", function() require('crates').open_repository() end,         desc = "Open repository" },
            { "<leader>rD", function() require('crates').open_documentation() end,      desc = "Open documentation" },
            { "<leader>rC", function() require('crates').open_crates_io() end,          desc = "Open Crates.io" },
        },
        opts = {
            popup = {
                style = "minimal",
                border = "rounded",
            },
        }
    },
}
