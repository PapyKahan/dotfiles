local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

    -- Color and visual plugins
    use 'sainnhe/gruvbox-material'
    use 'vim-scripts/cream-showinvisibles'

    -- Airline and bufferline plugins
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
    }

    -- Note: File browser
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'},
    }

    -- Note: Symbol outline
    use 'simrat39/symbols-outline.nvim'

    -- Note: Fuzzy finder
    use 'nvim-telescope/telescope.nvim'

    -- Git
    use 'airblade/vim-gitgutter'

    -- Note: Autocomplete
    use {
        'neoclide/coc.nvim',
        branch = 'release',
    }

    -- Note: Tree-Sitter syntax optimizations
    use {
        'nvim-treesitter/nvim-treesitter',
        cmd = 'TSUpdate',
    }

    -- Note: Debugger
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python' -- need python dependency : pip install debugpy

    -- Note: CMake
    use {
        'Shatur/neovim-cmake',
        requires = {'nvim-lua/plenary.nvim'},
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
end)
