return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        init = function()
            if vim.env['AUTH_PROXY'] then
                vim.g.copilot_proxy = vim.env['AUTH_PROXY']
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
                    debounce = 75,
                    keymap = {
                        accept = "<M-i>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-j>",
                        prev = "<M-k>",
                        dismiss = "<M-l>",
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
