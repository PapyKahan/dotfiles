return {
    "olimorris/codecompanion.nvim",
    keys = {
        { "<leader>c", group = "CodeCompanion", desc = "CodeCompanion" },
        {
            "<leader>ch",
            "<cmd>CodeCompanionChat Toggle<cr>",
            desc = "CodeCompanion - Toggle chat",
        },
        {
            "<leader>ca",
            "<cmd>CodeCompanionActions<cr>",
            desc = "CodeCompanion - Show actions",
        },
    },
    event = "BufEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "j-hui/fidget.nvim",
        {
            "MeanderingProgrammer/render-markdown.nvim",
            ft = { "markdown", "codecompanion" }
        },
    },
    init = function()
      --require("plugins.codecompanion.lualine"):init()
      require("plugins.codecompanion.fidget-spinner"):init()
    end,
    config = function()
        require("codecompanion").setup({
            opts = {
                --log_level = "TRACE", -- TRACE|DEBUG|ERROR|INFO
                language = "french",
            },
            strategies = {
                chat = {
                    adapter = "mistral",
                },
                inline = {
                    adapter = "mistral",
                },
                cmd = {
                    adapter = "mistral",
                }
            },
            display = {
                chat = {
                    window = {
                        layout = "vertical", -- float|vertical|horizontal|buffer
                        position = "right",  -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
                        border = "single",
                        --height = 0.8,
                        width = 0.30,
                        relative = "editor",
                        full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
                        --opts = {
                        --    breakindent = true,
                        --    cursorcolumn = false,
                        --    cursorline = false,
                        --    foldcolumn = "0",
                        --    linebreak = true,
                        --    list = false,
                        --    numberwidth = 1,
                        --    signcolumn = "no",
                        --    spell = false,
                        --    wrap = true,
                        --},
                    },
                },
            },
            adapters = {
                mistral = function()
                    return require("codecompanion.adapters").extend("mistral", {

                        env = {
                            url = "https://codestral.mistral.ai",
                        },
                        schema = {
                            model = {
                                default = "codestral-latest",
                            },
                        },
                    })
                end,
            },
        })
    end,
}
