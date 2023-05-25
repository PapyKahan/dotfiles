return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            defaults = {
                ['<leader>c'] = { name = '+Crates' },
            },
        },
        config = function(_, opts)
            require("which-key").register(opts.defaults)
        end
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = {
            'nvim-dap',
            'which-key.nvim',
        },
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


            local rust_tools = require('rust-tools')
            rust_tools.setup({
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
                    }
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
        },
        keys = {
            { "<leader>ct", function() require('crates').toggle() end,                  desc = "Toggle" },
            { "<leader>cr", function() require('crates').reload() end,                  desc = "Reload" },
            --
            -- nnoremap <silent> <leader>cv :lua require('crates').show_versions_popup()<cr>
            { "<leader>cv", function() require('crates').show_versions_popup() end,     desc = "Show versions" },
            -- nnoremap <silent> <leader>cf :lua require('crates').show_features_popup()<cr>
            { "<leader>cf", function() require('crates').show_features_popup() end,     desc = "Show features" },
            -- nnoremap <silent> <leader>cd :lua require('crates').show_dependencies_popup()<cr>
            { "<leader>cd", function() require('crates').show_dependencies_popup() end, desc = "Show dependencies" },
            --
            -- nnoremap <silent> <leader>cu :lua require('crates').update_crate()<cr>
            { "<leader>cu", function() require('crates').update_crate() end,            desc = "Update crate" },
            -- vnoremap <silent> <leader>cu :lua require('crates').update_crates()<cr>
            { "<leader>cu", function() require('crates').update_crate() end,            desc = "Update crates" },
            -- nnoremap <silent> <leader>ca :lua require('crates').update_all_crates()<cr>
            { "<leader>ca", function() require('crates').update_all_crates() end,       desc = "Update all crates" },
            -- nnoremap <silent> <leader>cU :lua require('crates').upgrade_crate()<cr>
            { "<leader>cU", function() require('crates').upgrade_crate() end,           desc = "Upgrade crate" },
            -- vnoremap <silent> <leader>cU :lua require('crates').upgrade_crates()<cr>
            { "<leader>cU", function() require('crates').upgrade_crates() end,          desc = "Upgrade crates" },
            -- nnoremap <silent> <leader>cA :lua require('crates').upgrade_all_crates()<cr>
            { "<leader>cA", function() require('crates').upgrade_all_crates() end,      desc = "Upgrade all crates" },

            -- nnoremap <silent> <leader>cH :lua require('crates').open_homepage()<cr>
            { "<leader>cH", function() require('crates').open_homepage() end,           desc = "Open homepage" },
            -- nnoremap <silent> <leader>cR :lua require('crates').open_repository()<cr>
            { "<leader>cR", function() require('crates').open_repository() end,         desc = "Open repository" },
            -- nnoremap <silent> <leader>cD :lua require('crates').open_documentation()<cr>
            { "<leader>cD", function() require('crates').open_documentation() end,      desc = "Open documentation" },
            -- nnoremap <silent> <leader>cC :lua require('crates').open_crates_io()<cr>
            { "<leader>cC", function() require('crates').open_crates_io() end,          desc = "Open Crates.io" },
        }
    },
}
