return {
    -- Note : LSP
    {
        'neovim/nvim-lspconfig',
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            'mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'Hoffs/omnisharp-extended-lsp.nvim',
        },
    },
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        config = function() require 'plugins.configs.mason' end,
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
