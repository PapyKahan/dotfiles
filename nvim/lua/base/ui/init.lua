return {
    -- Airline and bufferline plugins
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('base.ui.lualine') end
    },
    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        version = "v3.*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function() require 'base.ui.bufferline' end
    },

    -- Note: File browser
    {
        'kyazdani42/nvim-tree.lua',
        cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
        keys = {
            { '<leader>x', "<cmd>NvimTreeToggle<CR>", "Open Nvim-Tree" },
        },
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'folke/which-key.nvim',

        },
        config = function() require 'base.ui.nvimtree' end,
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
        config = function() require 'base.ui.telescope' end
    },

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        lazy = true,
        event = "BufRead",
        config = function() require 'base.ui.gitsigns' end
    },

    {
        'stevearc/dressing.nvim',
        event = "VeryLazy",
        dependencies = 'MunifTanjim/nui.nvim',
        config = function() require('base.ui.dressing') end
    },
}
