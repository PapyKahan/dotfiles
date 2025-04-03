return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        -- add any opts here
        -- for example
        --provider = 'mistral',
        --auto_suggestions_provider = 'mistral',
        --cursor_applying_provider = 'mistral',
        ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        provider = 'mistral',
        auto_suggestions_provider = 'copilot',
        cursor_applying_provider = 'mistral',
        behaviour = {
            --- ... existing behaviours
            enable_cursor_planning_mode = true, -- enable cursor planning mode!
            auto_suggestions = true,
        },
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-5-sonnet-20241022",
        },
        vendors = {
            mistral = {
                --endpoint = "https://api.mistral.ai/v1/",
                endpoint = "https://codestral.mistral.ai/v1/",
                model = "codestral-latest",
                api_key_name = "MISTRAL_API_KEY",
                __inherited_from = "openai",
            },
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- for windows
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        --"echasnovski/mini.pick",         -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
        --"ibhagwan/fzf-lua",              -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
        --{
        --    "ravitemer/mcphub.nvim",
        --    dependencies = {
        --        "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
        --    },
        --    -- comment the following line to ensure hub will be ready at the earliest
        --    cmd = "MCPHub",                          -- lazy load by default
        --    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
        --    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
        --    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
        --    config = function()
        --        require("mcphub").setup()
        --    end,
        --}
    },
}
