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
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>",      desc = "Decrement selection", mode = "x" },
        },
        opts = {
            --autotag = { enable = true },
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
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
        config = function(_, opts)
            require 'nvim-treesitter.configs'.setup(opts)
            require 'nvim-treesitter.install'.compilers = { "clang" }
        end,
    },
}
