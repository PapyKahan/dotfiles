return {
    {
        "folke/which-key.nvim",
        lazy = false,
        opts = {
            defaults = {
                ['<leader>f'] = { name = 'Find' },
            },
        },
        config = function (_, opts)
            require('which-key').register(opts.defaults)
        end
    },
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
    --{
    --    'kyazdani42/nvim-tree.lua',
    --    cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
    --    keys = {
    --        { '<leader>x', "<cmd>NvimTreeToggle<CR>", desc = "Open Nvim-Tree" },
    --    },
    --    dependencies = {
    --        'nvim-tree/nvim-web-devicons',
    --        'folke/which-key.nvim',

    --    },
    --    config = function() require 'base.ui.nvimtree' end,
    --},
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        keys = {
            { '<leader>x', "<cmd>Neotree toggle<CR>", desc = "Open Nvim-Tree" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },

    -- Note: Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        cmd = { 'Telescope' },
        keys = {
            { "<leader>p",  ":Telescope<cr>", desc = "Open Telescope" },
            { "<leader>ff", ":Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", ":Telescope live_grep<cr>", desc = "Grep files" },
            { "<leader>fb", ":Telescope buffers<cr>", desc = "Find buffers" },
            { "<leader>fh", ":Telescope help_tags<cr>", desc = "Find help tags"}
        },
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
        event = "BufRead",
        config = function() require 'base.ui.gitsigns' end
    },

    {
        'stevearc/dressing.nvim',
        event = "VeryLazy",
        dependencies = 'MunifTanjim/nui.nvim',
        config = function() require('dressing').setup() end
    },
}
