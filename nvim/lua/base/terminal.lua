return {
    {
        "folke/which-key.nvim",
        lazy = false,
        opts = {
            defaults = {
                ['<F12>'] = { name = 'Terminal' },
            },
        },
        config = function (_, opts)
            require('which-key').register(opts.defaults)
        end
    },
    {
        'akinsho/nvim-toggleterm.lua',
        keys = {
            { "<F12>", "<cmd>ToggleTerm<cr>", "Open Terminal" },
        },
        branch = 'main',
        dependencies = {
            'folke/which-key.nvim',
        },
        opts = {
            hide_numbers = true,
            shade_terminals = false,
            close_on_exit = true,
            float_opts = {
                border = 'curved',
                width = math.floor(0.7 * vim.fn.winwidth(0)),
                height = math.floor(0.8 * vim.fn.winheight(0)),
                winblend = 4,
            }
        },
        config = function(_, opts)
            require('toggleterm').setup(opts)
        end
    },
}
