local gitui = nil
function _gitui_toggle()
end

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
            if vim.fn.executable "gitui" == 1 then
                gitui = require('toggleterm.terminal').Terminal:new {
                    cmd = 'gitui',
                    hidden = true,
                    direction = 'float',
                    float_opts = {
                        border = 'curved',
                        width = math.floor(0.8 * vim.fn.winwidth(0)),
                        height = math.floor(0.9 * vim.fn.winheight(0)),
                        winblend = 4,
                    }
                }
            end
        end,
    },
}
