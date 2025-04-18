return {
    -- Colorscheme
    {
        "olimorris/onedarkpro.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- Ensure it loads first
        config = function()
            require("onedarkpro").setup({})
            vim.cmd.colorscheme "onedark"
        end,

    },
    {
        "catppuccin/nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        name = "catppuccin",
        config = function()
            --require("catppuccin").laod()
            --vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        config = function()
            --require("tokyonight").load()
            --vim.cmd.colorscheme "tokyonight"
        end,
    }
}
