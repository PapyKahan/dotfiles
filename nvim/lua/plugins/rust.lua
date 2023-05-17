return {
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
}
