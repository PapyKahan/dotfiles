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
            error_header = '> [!ERROR] Error'
        },
    },
}
