return {
    {
        "catppuccin/nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                -- Your configuration here
            })
            vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 999, -- slightly lower priority than catppuccin
        config = function()
            require("tokyonight").setup({
                -- Your configuration here
            })
            --vim.cmd.colorscheme "tokyonight"
        end,
    }
}
