return {
    {
        "mxsdev/nvim-dap-vscode-js",
        ft = { "javascript", "typescript" },
        dependencies = { "nvim-dap" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "css", "html", "javascript", "jsdoc", "scss", "tsx", "typescript" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                tsserver = {
                    javascript = {
                        referencesCodeLens = {
                            enabled = true,
                            showOnAllFunctions = true,
                        },
                    },
                    typescript = {
                        suggest = {
                            completeFunctionCalls = true
                        },
                        referencesCodeLens = {
                            enabled = true,
                            showOnAllFunctions = true,
                        },
                    }
                },
            },
        },
    },
    {
        --nvim-dap-vscode-js
        "mxsdev/nvim-dap-vscode-js",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = { "javascript", "typescript" },
        config = function()
            local debuger_cmd = "js-debug-adapter"
            -- if we are on windows, we need to add the .cmd extension
            if vim.fn.has("win32") == 1 or vim.fn.has("win64") or vim.fn.has("win32unix") then
                debuger_cmd = debuger_cmd .. ".cmd"
            end
            require("dap-vscode-js").setup({
                node_path = "node",                                                                          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
                -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
                debugger_cmd = { debuger_cmd },                                                              -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
                adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
                -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
                -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
                -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
            })

            for _, language in ipairs({ "javascriptreact", "typescriptreact" }) do
                require("dap").configurations[language] = {
                    {
                        type = "pwa-chrome",
                        name = "Attach - Remote Debugging",
                        request = "attach",
                        program = "${file}",
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                        protocol = "inspector",
                        port = 9222,
                        webRoot = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-chrome",
                        name = "Launch Chrome",
                        request = "launch",
                        url = "http://localhost:3000",
                    },
                }
            end
        end,
    }
}
