local gitui = nil

return {
    {
        "folke/which-key.nvim",
        lazy = false,
        opts = {
            defaults = {
                ['<leader>c'] = { name = 'Terminal' },
            },
        },
        config = function(_, opts)
            require('which-key').register(opts.defaults)
        end
    },
    {
        'akinsho/nvim-toggleterm.lua',
        keys = {
            { "<leader>ct", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Open Terminal" },
            {
                "<leader>cg",
                function()
                    if gitui then
                        gitui:toggle()
                    end
                end,
                mode = { "n", "t" },
                desc = "Open GitUI"
            }

        },
        branch = 'main',
        dependencies = {
            'folke/which-key.nvim',
        },
        config = function()
            require('toggleterm').setup({})
            if vim.fn.executable "gitui" == 1 then
                gitui = require('toggleterm.terminal').Terminal:new {
                    cmd = 'gitui',
                    hidden = true,
                    direction = 'float',
                    float_opts = {
                        border = 'curved',
                        winblend = 4,
                    }
                }
            end
        end,
    },
}
