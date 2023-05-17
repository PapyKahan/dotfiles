return {
    -- Documentation generator
    {
        "danymat/neogen",
        event = {'BufReadPost', 'BufNewFile'},
        dependencies = {
            "folke/which-key.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function() require 'plugins.configs.neogen' end
    }
}
