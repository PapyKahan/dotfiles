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

return packer.startup({function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    -- Color and visual plugins
    use 'sainnhe/gruvbox-material'

    -- Airline and bufferline plugins
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = [[require 'config.lualine']]
    }

    -- Note: File browser
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = [[require 'config.nvimtree']]
    }

    -- Note: Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
            {'BurntSushi/ripgrep'},
            {'sharkdp/fd'},
        },
        config = [[require 'config.telescope']]
    }

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        event = "BufRead",
        config = [[require 'config.gitsigns']]
    }

    -- Note : LSP
    use {
        'williamboman/nvim-lsp-installer',
        config = [[require 'config.lsp-installer']]
    }
    use {
        'neovim/nvim-lspconfig',
        config = [[require 'config.lsp-config']]
    }
    use {
        'j-hui/fidget.nvim',
        config = [[require 'config.fidget']]
    }

    -- Note: Autocomplete
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'petertriho/cmp-git',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip'
        },
        config = [[require'config.cmp']]
    }

    -- Pairs
    use {
        'windwp/nvim-autopairs',
        config = function() require'nvim-autopairs'.setup() end
    }

    -- Key mapping helper
    use {
        "folke/which-key.nvim",
        config = function() require'which-key'.setup() end
    }

    -- Note: Tree-Sitter syntax optimizations
    use {
        'nvim-treesitter/nvim-treesitter',
        cmd = 'TSUpdate'
    }

    -- Note: Debugger
    use {
        'mfussenegger/nvim-dap',
        config = [[require 'config.dap']]
    }

    use 'mfussenegger/nvim-dap-python' -- need python dependency : pip install debugpy

    -- Note: CMake
    use {
        'Shatur/neovim-cmake',
        requires = {'nvim-lua/plenary.nvim'}
    }

    if packer_bootstrap then
        packer.sync()
    end
end})
