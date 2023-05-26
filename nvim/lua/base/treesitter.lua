return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            {
                'windwp/nvim-ts-autotag',
                config = function() require('nvim-ts-autotag').setup() end,
            },
            {
                'windwp/nvim-autopairs',
                config = function() require('nvim-autopairs').setup() end,
            },
        },
        opts = {
            autotag = { enable = true },
            highlight = { enable = true, additional_vim_regex_highlighting = { "org", "markdown" } },
            indent = { enable = true },
            context_commentstring = { enable = true },
            ensure_installed = {
                "bash",
                "cmake",
                "comment",
                "dockerfile",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "http",
                "ini",
                "make",
                "markdown",
                "markdown_inline",
                "regex",
                "rst",
                "sql",
                "terraform",
                "toml",
                "vim",
                "vimdoc",
                "yaml"
            },
        },
        config = function(_, opts)
            require 'nvim-treesitter.configs'.setup(opts)
        end,
    },
}
