return {
    -- Airline and bufferline plugins
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('plugins.configs.lualine') end
    },
    {
        'akinsho/bufferline.nvim',
        version = "v3.*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function() require 'plugins.configs.bufferline' end
    },

    -- Note: File browser
    {
        'kyazdani42/nvim-tree.lua',
        event = "VeryLazy",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            -- depends on which-key
            'folke/which-key.nvim',

        },
        config = function() require 'plugins.configs.nvimtree' end,
    },

    -- Note: Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            'sharkdp/fd',
            'folke/which-key.nvim',
        },
        config = function() require 'plugins.configs.telescope' end
    },

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        lazy = true,
        event = "BufRead",
        config = function() require 'plugins.configs.gitsigns' end
    },

    {
        'stevearc/dressing.nvim',
        event = "VeryLazy",
        dependencies = 'MunifTanjim/nui.nvim',
        config = function() require('plugins.configs.dressing') end
    },
}
