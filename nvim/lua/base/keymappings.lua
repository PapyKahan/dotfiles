return {
    {
        "folke/which-key.nvim",
        config = function(_, opts)
            local whichkey = require 'which-key'
            whichkey.setup(opts)
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
                silent = true,
                noremap = false
            })
        end
    },
}
