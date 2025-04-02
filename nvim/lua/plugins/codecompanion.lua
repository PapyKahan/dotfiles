return {
    "olimorris/codecompanion.nvim",
    event = "BufEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            opts = {
                log_level = "TRACE", -- TRACE|DEBUG|ERROR|INFO
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
            adapters = {
               mistral = function()
                    return require("codecompanion.adapters").extend("mistral", {
                        env = {
                            url = "https://codestral.mistral.ai",
                            api_key = vim.env["MISTRAL_API_KEY"],
                            chat_url = "/v1/chat/completions"
                        },
                        --handlers = {
                        --    form_parameters = function(self, params, messages)
                        --        -- codestral doesn't support these in the body
                        --        params.stream_options = nil
                        --        params.options = nil

                        --        return params
                        --    end,
                        --},
                        schema = {
                            model = {
                                default = "codestral-latest",
                            },
                            --temperature = {
                            --    default = 0.2,
                            --    mapping = "parameters", -- not supported in default parameters.options
                            --},
                        },
                    })
                end,
                opts = {
                    --allow_insecure = true,
                    --proxy = vim.env["HTTPS_PROXY"] or nil,
                },
            },
        })
    end,
}
