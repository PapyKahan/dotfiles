return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            defaults = {
                { "<leader>tt", group = "+Task" },
            },
        },
    },
    {
        "stevearc/overseer.nvim",
        keys = {
            { "<leader>ttR", "<cmd>OverseerRunCmd<cr>",       desc = "Run Command" },
            { "<leader>tta", "<cmd>OverseerTaskAction<cr>",   desc = "Task Action" },
            { "<leader>ttb", "<cmd>OverseerBuild<cr>",        desc = "Build" },
            { "<leader>ttc", "<cmd>OverseerClose<cr>",        desc = "Close" },
            { "<leader>ttd", "<cmd>OverseerDeleteBundle<cr>", desc = "Delete Bundle" },
            { "<leader>ttl", "<cmd>OverseerLoadBundle<cr>",   desc = "Load Bundle" },
            { "<leader>tto", "<cmd>OverseerOpen<cr>",         desc = "Open" },
            { "<leader>ttq", "<cmd>OverseerQuickAction<cr>",  desc = "Quick Action" },
            { "<leader>ttr", "<cmd>OverseerRun<cr>",          desc = "Run" },
            { "<leader>tts", "<cmd>OverseerSaveBundle<cr>",   desc = "Save Bundle" },
            { "<leader>ttt", "<cmd>OverseerToggle<cr>",       desc = "Toggle" },
        },
        opts = {},
    }
}
