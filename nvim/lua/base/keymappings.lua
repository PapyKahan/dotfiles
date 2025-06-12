return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "<M-h>", "<C-w>h", desc = "Move to left window", mode = "n", silent = true, remap = true },
            { "<M-j>", "<C-w>j", desc = "Move to downward window", mode = "n", silent = true, remap = true },
            { "<M-k>", "<C-w>k", desc = "Move to upward window", mode = "n", silent = true, remap = true },
            { "<M-l>", "<C-w>l", desc = "Move to right window", mode = "n", silent = true, remap = true },

            { "<M-Up>", "<cmd>resize -2<cr>", desc = "Horizontaly decrease windows size", mode = "n", silent = true, remap = true },
            { "<M-Down>", "<cmd>resize +2<cr>", desc = "Horizontaly increase windows size", mode = "n", silent = true, remap = true },
            { "<M-Left>", "<cmd>vertical resize -2<cr>", desc = "Verticaly decrease windows size", mode = "n", silent = true, remap = true },
            { "<M-Right>", "<cmd>vertical resize +2<cr>", desc = "Verticaly increase windows size", mode = "n", silent = true, remap = true },

            { "<S-h>", "<cmd>bp<cr>", desc = "Select previous buffer", mode = "n", silent = true, remap = true },
            { "<S-l>", "<cmd>bn<cr>", desc = "Select next buffer", mode = "n", silent = true, remap = true },
            { "<leader>h", "<cmd>set list listchars=tab:\\ ,trail:-,space:.,nbsp:+,eol:$<cr>", desc = "Show/Hide special chars", mode = "n", silent = true, remap = true },
            {
                "<leader>h",
                function()
                    vim.opt.list = not vim.opt.list:get()
                end,
                desc = "Show/Hide special chars",
                mode = "n",
                silent = true,
                remap = true
            },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Flash Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    }
}
