return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "c", "cpp" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = function()
            vim.lsp.config('clangd', {
                capabilities  = {
                    textDocument = {
                        completion = {
                        editsNearCursor = true,
                        },
                    },
                    offsetEncoding = 'utf-8',
                },
            })
        end,
    },
}
