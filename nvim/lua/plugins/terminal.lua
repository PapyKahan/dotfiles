return {
    -- Note: Terminal
    {
        'akinsho/nvim-toggleterm.lua',
        event = "VeryLazy",
        branch = 'main',
        dependencies = {
            -- Depends on which-key
            'folke/which-key.nvim',
        },
        config = function() require('plugins.configs.toggleterm') end
    },
}
