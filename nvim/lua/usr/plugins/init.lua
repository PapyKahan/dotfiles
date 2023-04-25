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
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight]])
        end,
    },

    -- Airline and bufferline plugins
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('usr.plugins.configs.lualine') end
    },
    {
        'akinsho/bufferline.nvim',
        version = "v3.*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function() require 'usr.plugins.configs.bufferline' end
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
        config = function() require 'usr.plugins.configs.nvimtree' end,
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
        config = function() require 'usr.plugins.configs.telescope' end
    },

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        lazy = true,
        event = "BufRead",
        config = function() require 'usr.plugins.configs.gitsigns' end
    },

    -- Note : LSP
    {
        'williamboman/mason.nvim',
        event = "VeryLazy",
        config = function() require 'usr.plugins.configs.mason' end,
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'Hoffs/omnisharp-extended-lsp.nvim'
        }
    },

    -- Lsp Progress bar
    {
        'j-hui/fidget.nvim',
        config = function() require 'usr.plugins.configs.fidget' end
    },

    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function() require 'usr.plugins.configs.trouble' end,
    },

    {
        'stevearc/dressing.nvim',
        event = "VeryLazy",
        dependencies = 'MunifTanjim/nui.nvim',
        config = function() require('usr.plugins.configs.dressing') end
    },

    -- Json schemastore
    {
        "b0o/schemastore.nvim",
        ft = { "json", "jsonc", "json5", "yaml" },
    },

    -- Neovim lua development
    {
        "folke/neodev.nvim",
        ft = "lua",
    },

    -- Note: Terminal
    {
        'akinsho/nvim-toggleterm.lua',
        event = "VeryLazy",
        branch = 'main',
        dependencies = {
            -- Depends on which-key
            'folke/which-key.nvim',
        },
        config = function() require('usr.plugins.configs.toggleterm') end
    },

    -- Note: Autocomplete
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
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
        config = function() require 'usr.plugins.configs.cmp' end
    },


    -- Key mapping helper
    {
        "folke/which-key.nvim",
        config = function() require 'which-key'.setup() end
    },

    -- Note: Tree-Sitter syntax optimizations
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
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
        config = function() require 'usr.plugins.configs.treesitter' end,
    },


    -- Note: Debugger
    {
        'mfussenegger/nvim-dap',
        event = "VeryLazy",
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'mfussenegger/nvim-dap-python',
            'mxsdev/nvim-dap-vscode-js',
        },
        config = function() require 'usr.plugins.configs.dap' end,
    },

    -- Note: CMake
    {
        'Shatur/neovim-cmake',
        ft = 'cmake',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Rust
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = function() require 'usr.plugins.configs.rust-tools' end
    },
    {
        'saecki/crates.nvim',
        ft = "toml",
        tag = 'v0.3.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('crates').setup() end,
    },

    -- Note: Outlining
    {
        "simrat39/symbols-outline.nvim",
        event = "VeryLazy",
        config = function() require("symbols-outline").setup() end
    },

    -- Github Copilot
    {
        "PapyKahan/copilot.vim",
        event = "VeryLazy",
        config = function() require 'usr.plugins.configs.copilot' end
    },

    -- Github Copilot
    --use {
    --    "zbirenbaum/copilot.lua",
    --    event = "VimEnter",
    --    config = [[require'usr.plugins.configs.copilot']]
    --}
    --use {
    --    "zbirenbaum/copilot-cmp",
    --    after = { "copilot.lua" },
    --    config = function ()
    --        require("copilot_cmp").setup()
    --    end
    --}

    --use 'Exafunction/codeium.vim'

    -- Documentation generator
    {
        "danymat/neogen",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "folke/which-key.nvim",
        },
        config = function() require 'usr.plugins.configs.neogen' end
    }
})
