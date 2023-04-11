local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local loaded, lazy = pcall(require, 'lazy')
if not loaded then
    return
end

vim.g.mapleader = " "

lazy.setup({
    -- Color and visual plugins
    'sainnhe/gruvbox-material',
    "EdenEast/nightfox.nvim",
    {
        "catppuccin/nvim",
        name = "catppuccin"
    },
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    'ray-x/aurora',

    -- Airline and bufferline plugins
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function() require('usr.config.lualine') end
    },
    {
	    'akinsho/bufferline.nvim',
	    version = "v3.*",
	    dependencies = 'nvim-tree/nvim-web-devicons',
        config = function() require 'usr.config.bufferline' end
    },

    -- Note: File browser
    { 
        'kyazdani42/nvim-tree.lua',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function() require 'usr.config.nvimtree' end
    },

    -- Note: Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
            {'BurntSushi/ripgrep'},
            {'sharkdp/fd'},
        },
        config = function() require 'usr.config.telescope' end
    },

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        event = "BufRead",
        config = function() require 'usr.config.gitsigns' end
    },

    -- Note : LSP
    {
        'williamboman/mason.nvim',
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = function() require 'usr.config.mason' end,
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'Hoffs/omnisharp-extended-lsp.nvim'
        }
    },

    {
        'j-hui/fidget.nvim',
        config = function() require 'usr.config.fidget' end
    },

    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function() require'usr.config.trouble' end,
    },

    "b0o/schemastore.nvim",
    {
        'stevearc/dressing.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        config = function() require('usr.config.dressing') end
    },

    "folke/neodev.nvim",

    -- Note: Terminal
    {
        'akinsho/nvim-toggleterm.lua',
        branch = 'main',
        config = function() require('usr.config.toggleterm') end
    },

    -- Note: Autocomplete
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'petertriho/cmp-git',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip'
        },
        config = function() require'usr.config.cmp' end
    },


    -- Key mapping helper
    {
        "folke/which-key.nvim",
        config = function() require'which-key'.setup() end
    },

    -- Note: Tree-Sitter syntax optimizations
    {
        'nvim-treesitter/nvim-treesitter',
        cmd = 'TSUpdate',
        config = function() require'usr.config.treesitter' end
    },

    -- Pairs
    {
        'windwp/nvim-autopairs',
        config = function() require'nvim-autopairs'.setup() end,
    },

    'windwp/nvim-ts-autotag',

    -- Note: Debugger
    {
        'mfussenegger/nvim-dap',
        config = function() require 'usr.config.dap' end
    },
    {
        'mfussenegger/nvim-dap-python',
        dependencies = { 'mfussenegger/nvim-dap' }
    }, -- need python dependency : pip install debugpy

    {
        'mxsdev/nvim-dap-vscode-js',
        dependencies = { 'mfussenegger/nvim-dap' },
    },

    {
        'rcarriga/nvim-dap-ui',
        requires = { 'mfussenegger/nvim-dap' }
    },

    -- Note: CMake
    {
        'Shatur/neovim-cmake',
        dependencies = {'nvim-lua/plenary.nvim'}
    },

    -- Note: Outlining
    {
        "simrat39/symbols-outline.nvim",
        config = function() require("symbols-outline").setup() end
    },

    -- Robot framework
    'suzuki11109/robot.vim',

    -- Github Copilot
    {
        "PapyKahan/copilot.vim",
        config = function() require'usr.config.copilot' end
    },

    -- Rust
    {
        "simrat39/rust-tools.nvim",
        config = function() require'usr.config.rust-tools' end
    },

    -- Github Copilot
    --use {
    --    "zbirenbaum/copilot.lua",
    --    event = "VimEnter",
    --    config = [[require'usr.config.copilot']]
    --}
    --use {
    --    "zbirenbaum/copilot-cmp",
    --    after = { "copilot.lua" },
    --    config = function ()
    --        require("copilot_cmp").setup()
    --    end
    --}

    --use 'Exafunction/codeium.vim'
})
