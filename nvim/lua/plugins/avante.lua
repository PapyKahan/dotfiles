local build_command = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
local this_os = vim.loop.os_uname().sysname;
if this_os:find "Windows" then
    build_command = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
else
    build_command = "make"
end

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        -- add any opts here
        -- for example
        --provider = 'mistral',
        ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        provider = 'copilot',
        auto_suggestions_provider = 'copilot',
        cursor_applying_provider = 'copilot',
        --auto_approve = true,
        behaviour = {
            --- ... existing behaviours
            enable_cursor_planning_mode = true, -- enable cursor planning mode!
            auto_suggestions = true,
            enable_claude_text_editor_tool_mode = true,
        },
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-5-sonnet-20241022",
        },
        copilot = {
            --model = "claude-3.7-sonnet-thought",
            model = "claude-3.7-sonnet",
            --temperature = 0,
            --max_tokens = 8192,
        },
        vendors = {
            mistral = {
                __inherited_from = "openai",
                --endpoint = "https://api.mistral.ai/v1/",
                endpoint = "https://codestral.mistral.ai/v1/",
                model = "codestral-latest",
                api_key_name = "MISTRAL_API_KEY",
                max_tokens = 8192
            },
        },
        disabled_tools = {
            "list_files",
            "search_files",
            "read_file",
            "create_file",
            "rename_file",
            "delete_file",
            "create_dir",
            "rename_dir",
            "delete_dir",
            "bash",
        },
        -- other config
        -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
        system_prompt = function()
            local hub = require("mcphub").get_hub_instance()
            return hub:get_active_servers_prompt()
        end,
        -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
        custom_tools = function()
            return {
                require("mcphub.extensions.avante").mcp_tool(),
            }
        end,
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = build_command,
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
        "ravitemer/mcphub.nvim",
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
