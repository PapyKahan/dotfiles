return {
    "olimorris/codecompanion.nvim",
    event = "BufEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            --strategies = {
            --    chat = "ollama",
            --    inline = "ollama",
            --    --tool = "ollama"
            --},
            strategies = {
                chat = {
                    adapter = "openai",
                },
                inline = {
                    adapter = "openai",
                },
            },
            adapters = {
                opts = {
                    allow_insecure = true, -- Use if required
                    proxy = "http://U118120:M4xd8uom!@dirproxy.mobi.ch:80"
                },
                ollama = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        -- some comments
                        env = {
                            url = "https://codestral.mistral.ai/",
                            api_key = "CODESTRAL_API_KEY",
                            --api_key = vim.env['CODESTRAL_API_KEY'],
                            chat_url = "/v1/chat/completions",
                        },
                        headers = {
                            ["Content-Type"] = "application/json",
                            ["Authorization"] = "Bearer ${api_key}",
                        },
                        parameters = {
                            sync = true,
                        },
                        schema = {
                            model = {
                                default = "codestral"
                            },
                        },

                    })
                end,
            },
        })
    end,
}
