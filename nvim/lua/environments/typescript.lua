return {
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
        "mfussenegger/nvim-dap",
        ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        opts = {
            setup = {
                vscode_js_debug = function()
                    local adapter_path = require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                    adapter_path = adapter_path .. "/js-debug/src/dapDebugServer.js"
                    for _, adapter in ipairs { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" } do
                        require("dap").adapters[adapter] = {
                            type = "server",
                            host = "localhost",
                            port = "${port}",
                            executable = {
                                command = "node",
                                args = {
                                    adapter_path,
                                    "${port}",
                                },
                            },
                        }
                    end

                    for _, language in ipairs { "typescript", "javascript" } do
                        require("dap").configurations[language] = {
                            {
                                type = "pwa-node",
                                request = "launch",
                                name = "Launch file",
                                program = "${file}",
                                cwd = "${workspaceFolder}",
                            },
                            {
                                type = "pwa-node",
                                request = "attach",
                                name = "Attach",
                                processId = require("dap.utils").pick_process,
                                cwd = "${workspaceFolder}",
                            },
                            {
                                type = "pwa-node",
                                request = "launch",
                                name = "Debug Jest Tests",
                                -- trace = true, -- include debugger info
                                runtimeExecutable = "node",
                                runtimeArgs = {
                                    "./node_modules/jest/bin/jest.js",
                                    "--runInBand",
                                },
                                rootPath = "${workspaceFolder}",
                                cwd = "${workspaceFolder}",
                                console = "integratedTerminal",
                                internalConsoleOptions = "neverOpen",
                            },
                            {
                                type = "pwa-chrome",
                                name = "Attach - Remote Debugging",
                                request = "attach",
                                program = "${file}",
                                cwd = vim.fn.getcwd(),
                                sourceMaps = true,
                                protocol = "inspector",
                                port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
                                webRoot = "${workspaceFolder}",
                            },
                            {
                                type = "pwa-chrome",
                                name = "Launch Chrome",
                                request = "launch",
                                url = "http://localhost:5173", -- This is for Vite. Change it to the framework you use
                                webRoot = "${workspaceFolder}",
                                userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
                            },
                        }
                    end

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
                                port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
                                webRoot = "${workspaceFolder}",
                            },
                            {
                                type = "pwa-chrome",
                                name = "Launch Chrome",
                                request = "launch",
                                url = "http://localhost:5173", -- This is for Vite. Change it to the framework you use
                                webRoot = "${workspaceFolder}",
                                userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
                            },
                        }
                    end
                end

            }
        },
    }
}
