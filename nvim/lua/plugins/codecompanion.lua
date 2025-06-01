return {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- UI and file selection
        "nvim-telescope/telescope.nvim", -- file_selector provider
        "nvim-tree/nvim-web-devicons",   -- icons support

        -- Integration dependencies
        "zbirenbaum/copilot.lua",
        "ravitemer/mcphub.nvim",

        -- Extentions
        "ravitemer/codecompanion-history.nvim",

        -- better diff
        {
            "echasnovski/mini.diff",
            config = function()
                local diff = require("mini.diff")
                diff.setup({
                    -- Disabled by default
                    source = diff.gen_source.git(),
                })
            end,
        }
    },
    keys = {
        -- Open chat buffer
        { "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "Open CodeCompanion Chat" },
        -- Open action palette
        { "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "Open CodeCompanion Action Palette" },
        -- Open history
        { "<leader>ch", "<cmd>CodeCompanionHistory<cr>", desc = "Open CodeCompanion History" },
    },
    opts = {
        strategies = {
            chat = {
                adapter = "copilot",
            },
            inline = {
                adapter = "copilot",
            },
            cmd = {
                adapter = "copilot",
            },
        },
        adapters = {
            copilot = function()
                return require("codecompanion.adapters").extend("copilot", {
                    name = "copilot",
                    schema = {
                        model = {
                            default = "claude-sonnet-4",
                        },
                    }
                })
            end,
        },
        display = {
            chat = {
                window = {
                    layout = "vertical", -- float|vertical|horizontal|buffer
                    position = "right",  -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
                    border = "single",
                    height = 0.8,
                    width = 0.30,
                    relative = "editor",
                    full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
                    opts = {
                        breakindent = true,
                        cursorcolumn = false,
                        cursorline = false,
                        foldcolumn = "0",
                        linebreak = true,
                        list = false,
                        numberwidth = 1,
                        signcolumn = "no",
                        spell = false,
                        wrap = true,
                    },
                },
            },
            diff = {
                enabled = true,
                provider = "mini_diff",
            },
            -- Options to customize the UI of the chat buffer
            action_palette = {
                width = 95,
                height = 10,
                prompt = "Prompt ",                     -- Prompt used for interactive LLM calls
                provider = "default",                   -- Can be "default", "telescope", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
                opts = {
                    show_default_actions = true,        -- Show the default actions in the action palette?
                    show_default_prompt_library = true, -- Show the default prompt library in the action palette?
                },
            },
        },
        extensions = {
            history = {
                enabled = true,
                opts = {
                    -- Keymap to open history from chat buffer (default: gh)
                    keymap = "gh",
                    -- Keymap to save the current chat manually (when auto_save is disabled)
                    save_chat_keymap = "sc",
                    -- Save all chats by default (disable to save only manually using 'sc')
                    auto_save = true,
                    -- Number of days after which chats are automatically deleted (0 to disable)
                    expiration_days = 30,
                    -- Picker interface ("telescope" or "snacks" or "default")
                    picker = "telescope",
                    -- Automatically generate titles for new chats
                    auto_generate_title = true,
                    ---On exiting and entering neovim, loads the last chat on opening chat
                    continue_last_chat = true,
                    ---When chat is cleared with `gx` delete the chat from history
                    delete_on_clearing_chat = true,
                    ---Directory path to save the chats
                    dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                    ---Enable detailed logging for history extension
                    enable_logging = false,
                }
            },
            mcphub = {
                callback = "mcphub.extensions.codecompanion",
                opts = {
                    show_result_in_chat = true, -- Show mcp tool results in chat
                    make_vars = true,           -- Convert resources to #variables
                    make_slash_commands = true, -- Add prompts as /slash commands
                }
            }
        }
    },
}
