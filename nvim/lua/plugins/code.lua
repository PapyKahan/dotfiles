return {
    -- Json schemastore
    {
        "b0o/schemastore.nvim",
        ft = { "json", "jsonc", "json5", "yaml" },
    },

    -- Note: CMake
    {
        'Shatur/neovim-cmake',
        ft = 'cmake',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Rust
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = function() require 'plugins.configs.rust-tools' end
    },

    {
        'saecki/crates.nvim',
        ft = "toml",
        tag = 'v0.3.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('crates').setup() end,
    },

    -- Documentation generator
    {
        "danymat/neogen",
        event = {'BufReadPost', 'BufNewFile'},
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "folke/which-key.nvim",
        },
        config = function() require 'plugins.configs.neogen' end
    }
}
