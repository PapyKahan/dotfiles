local build_command = vim.loop.os_uname().sysname:find("Windows")
    and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make"

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = build_command,
    opts = {
        provider = 'gpt-4.1',
        mode = "legacy",
        behaviour = {
            auto_suggestions = false,
            enable_cursor_planning_mode = false,
            auto_apply_diff_after_generation = true,
            jump_result_buffer_on_finish = true,
            support_paste_from_clipboard = true,
        },
        vendors = {
            ['mistral'] = {
                __inherited_from = "openai",
                endpoint = "https://codestral.mistral.ai/v1/",
                model = "codestral-latest",
                api_key_name = "MISTRAL_API_KEY",
                max_tokens = 32768,
            },
            ["claude-3.5-sonnet"] = {
                __inherited_from = "copilot",
                display_name = "copilot/claude-3.5-sonnet",
                model = "claude-3.5-sonnet",
                max_completion_tokens = 32768
            },
            ["claude-3.7-sonnet"] = {
                __inherited_from = "copilot",
                display_name = "copilot/claude-3.7-sonnet",
                model = "claude-3.7-sonnet",
                max_completion_tokens = 32768
            },
            ["claude-3.7-sonnet-thought"] = {
                __inherited_from = "copilot",
                model = "claude-3.7-sonnet-thought",
                display_name = "copilot/claude-3.7-sonnet-thought",
                max_completion_tokens = 32768
            },
            ["gemini-2.0-flash"] = {
                __inherited_from = "copilot",
                display_name = "copilot/gemini-2.0-flash",
                model = "gemini-2.0-flash",
                max_completion_tokens = 32768
            },
            ["gemini-2.5-pro"] = {
                __inherited_from = "copilot",
                display_name = "copilot/gemini-2.5-pro",
                model = "gemini-2.5-pro",
                max_completion_tokens = 32768
            },
            ["gpt-4.1"] = {
                __inherited_from = "copilot",
                display_name = "copilot/gpt-4.1",
                model = "gpt-4.1",
                max_completion_tokens = 32768
            },
            ["gpt-4o"] = {
                __inherited_from = "copilot",
                display_name = "copilot/gpt-4o",
                model = "gpt-4-turbo",
                max_completion_tokens = 32768
            },
            ["o3-mini"] = {
                __inherited_from = "copilot",
                display_name = "copilot/o3-mini",
                model = "o3-mini",
                max_completion_tokens = 32768
            },
            ["o4-mini"] = {
                __inherited_from = "copilot",
                display_name = "copilot/o4-mini",
                model = "o4-mini",
                max_completion_tokens = 32768
            }
        },

        disabled_tools = {
            "list_files", "search_files", "read_file",
            "create_file", "rename_file", "delete_file",
            "create_dir", "rename_dir", "delete_dir",
            "bash",
        },

        system_prompt = function()
            local hub = require("mcphub").get_hub_instance()
            return hub:get_active_servers_prompt()
        end,

        custom_tools = function()
            return {
                require("mcphub.extensions.avante").mcp_tool(),
            }
        end,
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-tree/nvim-web-devicons",
        "zbirenbaum/copilot.lua",
        "ravitemer/mcphub.nvim",
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
                    use_absolute_path = true,
                },
            },
        },
    },
}
