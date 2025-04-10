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
}
