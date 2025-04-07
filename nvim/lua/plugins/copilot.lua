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
            separator = '---',
            error_header = '> [!ERROR] Error',
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
