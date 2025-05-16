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
                    if not require("mason-registry").is_installed("js-debug-adapter") then
                        return
                    end
                    local adapter_path = vim.fn.exepath("js-debug-adapter")
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
                                internalConsoleOptions = "neverOpen",
                                console = 'integratedTerminal',
                                skipFiles = {'<node_internals>/**/*.js'},
                            },
                            {
                                type = "pwa-node",
                                request = "attach",
                                name = "Attach",
                                processId = require("dap.utils").pick_process,
                                cwd = "${workspaceFolder}",
                                internalConsoleOptions = "neverOpen",
                                console = 'integratedTerminal',
                                skipFiles = {'<node_internals>/**/*.js'},
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
                                internalConsoleOptions = "neverOpen",
                                console = 'integratedTerminal',
                                skipFiles = {'<node_internals>/**/*.js'},
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
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-jest",
            "marilari88/neotest-vitest",
            "thenbe/neotest-playwright",
        },
        opts = function(_, opts)
            vim.list_extend(opts.adapters, {
                require "neotest-jest" ({
                    jestCommand = "pnpm test --",
                    jestConfigFile = function()
                        local file = vim.fn.expand('%:p')
                        if string.find(file, '[/|\\]packages[/|\\]') then
                            return string.match(file , '(.-[/|\\][^/|^\\]+[/|\\])src') .. "jest.config.ts"
                        end
                        return vim.fn.getcwd() .. "/jest.config.ts"
                    end,
                    env = { CI = true },
                    cwd = function()
                        local file = vim.fn.expand('%:p')
                        if string.find(file, '[/|\\]packages[/|\\]') then
                            return string.match(file, '(.-[/|\\][^/|^\\]+[/|\\])src')
                        end
                        return vim.fn.getcwd()
                    end
                }),
                --require "neotest-vitest",
                --require("neotest-playwright").adapter {
                --    options = {
                --        persist_project_selection = true,
                --        enable_dynamic_test_discovery = true,
                --    },
                --},
            })
        end,
    },
}
