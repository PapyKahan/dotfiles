local gitui = nil

return {
    {
        'akinsho/nvim-toggleterm.lua',
        keys = {
            group = 'Terminal',
            desc = 'Terminal',
            { '<leader>z', group = 'Terminal', desc = "Terminal", remap = false },
            { "<leader>zt", "<cmd>ToggleTerm<cr>", desc = "Open Terminal" },
            {
                "<leader>zg",
                function()
                    if gitui then
                        gitui:toggle()
                    end
                end,
                desc = "Open GitUI"
            }

        },
        branch = 'main',
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
