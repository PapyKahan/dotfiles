return {
    -- Note : LSP
    {
        'williamboman/mason.nvim',
        config = function() require 'plugins.configs.mason' end,
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'Hoffs/omnisharp-extended-lsp.nvim',
        }
    },

    -- Lsp Progress bar
    {
        'j-hui/fidget.nvim',
        config = function() require 'plugins.configs.fidget' end
    },

    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function() require 'plugins.configs.trouble' end,
    },

    -- Note: Outlining
    {
        "simrat39/symbols-outline.nvim",
        event = "VeryLazy",
        config = function() require("symbols-outline").setup() end
    },
}
