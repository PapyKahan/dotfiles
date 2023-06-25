return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            defaults = {
                ['<leader>h'] = { name = 'Hop' },
            },
        },
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
        config = function (_, opts)
            require('which-key').register(opts.defaults)
        end
    },
    {
        'phaazon/hop.nvim',
        cmd = { 'HopWord', 'HopLine', 'HopChar1', 'HopChar2', 'HopPattern', 'HopAnywhere' },
        keys = {
            { '<leader>hw' , function () require('hop').hint_words() end, desc = 'Hop to word' },
            { '<leader>ha' , function () require('hop').hint_anywhere() end, desc = 'Hop anywhere' },
        },
        config = function ()
            require('hop').setup()
        end
    }
}
