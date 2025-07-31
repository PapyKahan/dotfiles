return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = "VeryLazy",
        enabled = false,
        version = false,
        dependencies = {
            "zbirenbaum/copilot.lua",
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "ravitemer/mcphub.nvim",
            "nvim-lua/plenary.nvim",
            "echasnovski/mini.diff",
        },
        keys = {
            { "<leader>cc", "<cmd>CopilotChatToggle<cr>",  desc = "Copilot Chat" },
            { "<leader>cm", "<cmd>CopilotChatModels<cr>",  desc = "Copilot Chat Models" },
            { "<leader>cp", "<cmd>CopilotChatPrompts<cr>", desc = "Copilot Chat Prompts" },
        },
        opts = {
            model = 'claude-sonnet-4',
            -- See Configuration section for options
            mappings = {
                reset = {
                    normal = '<C-l>',
                    insert = '<C-l>',
                },
            },
            -- default window options
            window = {
                layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace', or a function that returns the layout
                width = 0.3,         -- fractional width of parent, or absolute width in columns when > 1
            },
        },
    },
}
