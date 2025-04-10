-- Simplified OS detection for build command
local build_command = vim.loop.os_uname().sysname:find("Windows")
    and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make"

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    build = build_command,

    opts = {
        ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        -- Main provider configuration
        provider = 'copilot',
        auto_suggestions_provider = 'copilot',
        cursor_applying_provider = 'copilot',
        auto_approve = false, -- Ensure changes require manual approval

        -- Core behavior settings
        behaviour = {
            enable_cursor_planning_mode = false,
            auto_suggestions = false,
            enable_claude_text_editor_tool_mode = false,
            auto_apply_diff_after_generation = false, -- Never automatically apply diffs
            require_manual_confirmation_for_edits = true, -- Always require manual confirmation
        },

        -- Model-specific configurations
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-5-sonnet-20241022",
        },

        copilot = {
            model = "claude-3.7-sonnet",
        },

        -- Additional vendor configurations
        vendors = {
            mistral = {
                __inherited_from = "openai",
                endpoint = "https://codestral.mistral.ai/v1/",
                model = "codestral-latest",
                api_key_name = "MISTRAL_API_KEY",
                max_tokens = 8192
            },
        },

        -- Security: Disable potentially dangerous file operations
        disabled_tools = {
            "list_files", "search_files", "read_file",
            "create_file", "rename_file", "delete_file",
            "create_dir", "rename_dir", "delete_dir",
            "bash",
        },

        -- MCPHub Integration
        -- Dynamic prompt generation from active MCP servers
        system_prompt = function()
            local hub = require("mcphub").get_hub_instance()
            return hub:get_active_servers_prompt()
        end,

        -- Lazy-loaded MCP tool integration
        custom_tools = function()
            return {
                require("mcphub.extensions.avante").mcp_tool(),
            }
        end,
    },

    dependencies = {
        -- Core dependencies
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",

        -- UI and file selection
        "nvim-telescope/telescope.nvim", -- file_selector provider
        "hrsh7th/nvim-cmp",              -- autocompletion for commands and mentions
        "nvim-tree/nvim-web-devicons",   -- icons support

        -- Integration dependencies
        "zbirenbaum/copilot.lua",
        "ravitemer/mcphub.nvim",

        -- Image handling
        {
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    use_absolute_path = true, -- required for Windows users
                },
            },
        },

        -- Markdown rendering
        {
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
