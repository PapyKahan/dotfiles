return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "diff", "markdown" })
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = { "InsertEnter", "CmdlineEnter" }, -- Load on command line too
        init = function()
            if vim.env['HTTPS_PROXY'] then
                vim.g.copilot_proxy = vim.env['HTTPS_PROXY']
                vim.g.copilot_proxy_strict_ssl = false
            end
            vim.g.copilot_no_tab_map = true
        end,
        config = function()
            local copilot = require("copilot")
            copilot.setup({
                --copilot_model = "claude-3.7-sonnet-thought",
                panel = { enabled = false, },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 50, -- Lower for better responsiveness
                    keymap = {
                        accept = "<M-i>",
                        accept_word = "<M-w>", -- Enable word acceptance
                        accept_line = "<M-l>", -- Enable line acceptance
                        next = "<M-j>",
                        prev = "<M-k>",
                        dismiss = "<C-e>", -- Changed to match cmp dismiss key
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
            })
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>cc", "<cmd>:CopilotChatToggle<cr>",  desc = "Toggle Copilot Chat" },
            { "<leader>cs", "<cmd>:CopilotChatStop<cr>",    desc = "Stop Copilot Chat" },
            { "<leader>cr", "<cmd>:CopilotChatReset<cr>",   desc = "Reset Copilot Chat" },
            { "<leader>ca", "<cmd>:CopilotChatAgents<cr>",  desc = "Select Copilot Chat Agent" },
            { "<leader>cm", "<cmd>:CopilotChatModels<cr>",  desc = "Select Copilot Chat Model" },
            { "<leader>cp", "<cmd>:CopilotChatPrompts<cr>", desc = "Select Copilot Chat Prompt" },
        },
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "zbirenbaum/copilot.lua",
            "nvim-lua/plenary.nvim",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = { file_types = { "markdown", "copilot-chat" } }
            },
        },
        opts = {
            show_diff = {
                full_diff = true
            },
            highlight_headers = false,
            --separator = '---',
            error_header = '> [!ERROR] Error',
            --providers = {
            --    mistral = {
            --        prepare_input = require('CopilotChat.config.providers').copilot.prepare_input,
            --        prepare_output = require('CopilotChat.config.providers').copilot.prepare_output,

            --        get_headers = function()
            --            local api_key = assert(os.getenv('MISTRAL_API_KEY'), 'MISTRAL_API_KEY env not set')
            --            return {
            --                Authorization = 'Bearer ' .. api_key,
            --                ['Content-Type'] = 'application/json',
            --            }
            --        end,

            --        get_models = function(headers)
            --            local response, err = require('CopilotChat.utils').curl_get('https://api.mistral.ai/v1/models', {
            --                headers = headers,
            --                json_response = true,
            --            })

            --            if err then
            --                error(err)
            --            end

            --            return vim.iter(response.body.data)
            --                :filter(function(model)
            --                    return model.capabilities.completion_chat
            --                end)
            --                :map(function(model)
            --                    return {
            --                        id = model.id,
            --                        name = model.name,
            --                    }
            --                end)
            --                :totable()
            --        end,

            --        embed = function(inputs, headers)
            --            local response, err = require('CopilotChat.utils').curl_post(
            --            'https://codestral.mistral.ai/v1/embeddings', {
            --                headers = headers,
            --                json_request = true,
            --                json_response = true,
            --                body = {
            --                    model = 'mistral-embed',
            --                    input = inputs,
            --                },
            --            })

            --            if err then
            --                error(err)
            --            end

            --            return response.body.data
            --        end,

            --        get_url = function()
            --            return 'https://codestral.mistral.ai/v1/chat/completions'
            --        end,
            --    },
            --},
            contexts = {
                vectorspace = {
                    description =
                    'Semantic search through workspace using vector embeddings. Find relevant code with natural language queries. Supports input (query)',
                    input = function(callback)
                        vim.ui.input({
                            prompt = 'Enter search query> ',
                        }, callback)
                    end,
                    resolve = function(input, source, prompt)
                        if not input or input == '' then
                            input = prompt
                        end
                        local embeddings = require('CopilotChat.utils').curl_post('http://localhost:8000/query', {
                            json_request = true,
                            json_response = true,
                            body = {
                                dir = source.cwd(),
                                text = input,
                                max = 50
                            }
                        }).body

                        require('CopilotChat.utils').schedule_main()
                        return vim.iter(embeddings)
                            :map(function(embedding)
                                embedding.filetype = require('CopilotChat.utils').filetype(embedding.filename)
                                return embedding
                            end)
                            :filter(function(embedding)
                                return embedding.filetype
                            end)
                            :totable()
                    end,
                },
            },
        },
    },
}
