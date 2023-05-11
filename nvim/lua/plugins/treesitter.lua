return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = {'BufReadPost', 'BufNewFile'},
        dependencies = {
            {
                'windwp/nvim-ts-autotag',
                config = function() require('nvim-ts-autotag').setup() end,
            },
            {
                'windwp/nvim-autopairs',
                config = function() require('nvim-autopairs').setup() end,
            },
        },
        config = function() require 'plugins.configs.treesitter' end,
    },
}
