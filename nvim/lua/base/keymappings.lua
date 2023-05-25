return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local whichkey = require 'which-key'
            whichkey.setup {}
            whichkey.register({
                name = "Moves",
                ["<C-h>"] = { "<C-w>h", desc = 'Move to left window' },
                ["<C-j>"] = { "<C-w>j", desc = "Move to downward window" },
                ["<C-k>"] = { "<C-w>k", desc = "Move to upward window" },
                ["<C-l>"] = { "<C-w>l", desc = "Move to right window" },

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
        end
    }
}
