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
}
