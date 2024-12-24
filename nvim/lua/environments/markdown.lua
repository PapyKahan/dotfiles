return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ft = { "markdown", "codecompanion" },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                remark_ls = {},
            },
        },
    },
}
