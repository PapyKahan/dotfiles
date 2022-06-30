local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path, false, {})) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require'packer'

return packer.startup({function()
    local use = packer.use

    use 'wbthomason/packer.nvim'

    use 'lewis6991/impatient.nvim'

    -- Color and visual plugins
    use 'sainnhe/gruvbox-material'
    use 'vim-scripts/cream-showinvisibles'

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

    -- Note: Symbol outline
    use 'simrat39/symbols-outline.nvim'

    -- Note: Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = [[require 'config.telescope']]
    }

    -- Git
    use 'airblade/vim-gitgutter'

    -- Note: Autocomplete
    use {
        'neoclide/coc.nvim',
        branch = 'release',
        config = [[require 'config.coc']]
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
end,
display = {
    open_fn = function()
        return require('packer.util').float({ border = 'single' })
    end
}})
