local build_command = vim.loop.os_uname().sysname:find("Windows")
    and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make"

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    enabled = true,
    build = build_command,
    opts = {
        provider = 'copilot-gpt-4.1',
        mode = "agentic",
        behaviour = {
            auto_suggestions = false,
            auto_approve_tool_permissions = false,
            enable_cursor_planning_mode = true,
            auto_apply_diff_after_generation = true,
            jump_result_buffer_on_finish = true,
            support_paste_from_clipboard = true,
        },
        mappings = {
            confirm = {
                focus_window = "<C-w>f",
                code = "c",
                resp = "r",
                input = "i",
            },
        },
        windows = {
            input = {
                prefix = "> ",
                height = 15, -- Height of the input window in vertical layout
            },
        },
        providers = {
            ['mistral'] = {
                __inherited_from = "openai",
                endpoint = "https://codestral.mistral.ai/v1/",
                model = "codestral-latest",
                api_key_name = "MISTRAL_API_KEY",
                max_tokens = 8192,
            },
            ['copilot-gpt-4.1'] = {
                __inherited_from = "copilot",
                model = "gpt-4.1",
            },
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
