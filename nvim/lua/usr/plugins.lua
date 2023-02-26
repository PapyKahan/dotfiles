local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local loaded, packer = pcall(require, 'packer')
if not loaded then
    return
end

packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end
    }
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "plugins.lua" },
    callback = function()
        vim.cmd("runtime lua/usr/plugins.lua")
        packer.sync()
    end,
})

return packer.startup({function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    -- Color and visual plugins
    use 'sainnhe/gruvbox-material'
    use {
        'sonph/onehalf',
        rtp = "vim"
    }
    use "EdenEast/nightfox.nvim"
    use{
        "catppuccin/nvim",
        as = "catppuccin"
    }
    use 'rafamadriz/neon'
    use 'folke/tokyonight.nvim'
    use 'ray-x/aurora'

    -- Airline and bufferline plugins
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = [[require 'usr.config.lualine']]
    }
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = [[require 'usr.config.bufferline']]
    }

    -- Note: File browser
    use { 'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}, config = [[require 'usr.config.nvimtree']] }

    -- Note: Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
            {'BurntSushi/ripgrep'},
            {'sharkdp/fd'},
        },
        config = [[require 'usr.config.telescope']]
    }

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        event = "BufRead",
        config = [[require 'usr.config.gitsigns']]
    }

    -- Note : LSP
    use {
        {
            "williamboman/mason.nvim",
            config = [[require 'usr.config.mason']]
        },
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    }
    use {
        'j-hui/fidget.nvim',
        config = [[require 'usr.config.fidget']]
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = [[require'usr.config.trouble']],
    }
    use "b0o/schemastore.nvim"
    use "Hoffs/omnisharp-extended-lsp.nvim"
    use {
        'stevearc/dressing.nvim',
        requires = 'MunifTanjim/nui.nvim',
        config = [[require('usr.config.dressing')]]
    }
    use {
        "folke/lua-dev.nvim",
        module = "lua-dev",
    }

    -- Note: Terminal
    use {
        'akinsho/nvim-toggleterm.lua',
        branch = 'main',
        config = [[require('usr.config.toggleterm')]]
    }

    -- Note: Autocomplete
    use {
        'hrsh7th/nvim-cmp',
        requires = {
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
        config = [[require'usr.config.cmp']]
    }


    -- Key mapping helper
    use {
        "folke/which-key.nvim",
        config = function() require'which-key'.setup() end
    }

    -- Note: Tree-Sitter syntax optimizations
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        config = [[require'usr.config.treesitter']]
    }

    -- Pairs
    use {
        'windwp/nvim-autopairs',
        config = function() require'nvim-autopairs'.setup() end,
        after='nvim-treesitter'
    }
    use {
        'windwp/nvim-ts-autotag',
        after='nvim-treesitter'
    }

    -- Note: Debugger
    use {
        'mfussenegger/nvim-dap',
        config = [[require 'usr.config.dap']]
    }
    use { 'mfussenegger/nvim-dap-python', requires= { 'mfussenegger/nvim-dap' } } -- need python dependency : pip install debugpy
    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }

    -- Note: CMake
    use {
        'Shatur/neovim-cmake',
        requires = {'nvim-lua/plenary.nvim'}
    }

    -- Note: Outlining
    use({
        "simrat39/symbols-outline.nvim",
        config = [[require("symbols-outline").setup()]]
    })

    -- Robot framework
    use 'suzuki11109/robot.vim'

    -- Github Copilot
    use {
        "github/copilot.vim",
        config = [[require'usr.config.copilot']]
    }
    
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
   

    if packer_bootstrap then
        packer.sync()
    end
end})
