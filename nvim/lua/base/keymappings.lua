return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = { },
        init = function()
            local whichkey = require 'which-key'
            whichkey.register({
                ["<C-h>"] = { "<C-w>h", 'Move to left window' },
                ["<C-j>"] = { "<C-w>j", "Move to downward window" },
                ["<C-k>"] = { "<C-w>k", "Move to upward window" },
                ["<C-l>"] = { "<C-w>l", "Move to right window" },

                ["<C-Up>"] = { "<cmd>resize -2<cr>", "Horizontaly decrease windows size" },
                ["<C-Down>"] = { "<cmd>resize +2<cr>", "Horizontaly increase windows size" },
                ["<C-Left>"] = { "<cmd>vertical resize -2<cr>", "Verticaly decrease windows size" },
                ["<C-Right>"] = { "<cmd>vertical resize +2<cr>", "Verticaly increase windows size" },

                ["<S-l>"] = { "<cmd>bn<cr>", "Select next buffer" },
                ["<S-h>"] = { "<cmd>bp<cr>", "Select previous buffer" },
            }, {
                mode = "n",
                silent = true,
                noremap = false
            })
        end,
        config = function(_, opts)
            require('which-key').register(opts.defaults)
        end
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
