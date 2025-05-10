return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "json", "jsonc", "json5" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "b0o/schemastore.nvim" },
        },
        opts = function(_, opts)
            vim.lsp.config('jsonls', {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true }
                    }
                }
            })
        end,
    },
}
