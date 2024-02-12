local function get_git_diff(staged)
    local cmd = staged and "git diff --staged" or "git diff"
    local handle = io.popen(cmd)
    if not handle then
        return ""
    end

    local result = handle:read("*a")
    handle:close()
    return result
end

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
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        opts = {
            show_help = "yes",         -- Show help text for CopilotChatInPlace, default: yes
            debug = true,              -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
            disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
            prompts = {
                -- Code related prompts
                Explain = "Please explain how the following code works.",
                Review = "Please review the following code and provide suggestions for improvement.",
                Tests = "Please explain how the selected code works, then generate unit tests for it.",
                Refactor = "Please refactor the following code to improve its clarity and readability.",
                FixCode = "Please fix the following code to make it work as intended.",
                BetterNamings = "Please provide better names for the following variables and functions.",
                Documentation = "Please provide documentation for the following code.",
                SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
                SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
                -- Text related prompts
                Summarize = "Please summarize the following text.",
                Spelling = "Please correct any grammar and spelling errors in the following text.",
                Wording = "Please improve the grammar and wording of the following text.",
                Concise = "Please rewrite the following text to make it more concise.",
            },
            -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
        },
        event = "VeryLazy",
        keys = {
            -- Code related commands
            { "<leader>cce", "<cmd>CopilotChatExplain<cr>",        desc = "CopilotChat - Explain code" },
            { "<leader>cct", "<cmd>CopilotChatTests<cr>",          desc = "CopilotChat - Generate tests" },
            { "<leader>ccr", "<cmd>CopilotChatReview<cr>",         desc = "CopilotChat - Review code" },
            { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>",       desc = "CopilotChat - Refactor code" },
            { "<leader>ccf", "<cmd>CopilotChatFixCode<cr>",        desc = "CopilotChat - Fix code" },
            { "<leader>ccb", "<cmd>CopilotChatBetterNamings<cr>",  desc = "CopilotChat - Better Name" },
            { "<leader>ccd", "<cmd>CopilotChatDocumentation<cr>",  desc = "CopilotChat - Add documentation for code" },
            { "<leader>cca", "<cmd>CopilotChatSwaggerApiDocs<cr>", desc = "CopilotChat - Add Swagger API documentation" },
            {
                "<leader>ccA",
                "<cmd>CopilotChatSwaggerJsDocs<cr>",
                desc = "CopilotChat - Add Swagger API with Js Documentation",
            },
            -- Text related commands
            { "<leader>ccs", "<cmd>CopilotChatSummarize<cr>", desc = "CopilotChat - Summarize text" },
            { "<leader>ccS", "<cmd>CopilotChatSpelling<cr>",  desc = "CopilotChat - Correct spelling" },
            { "<leader>ccw", "<cmd>CopilotChatWording<cr>",   desc = "CopilotChat - Improve wording" },
            { "<leader>ccc", "<cmd>CopilotChatConcise<cr>",   desc = "CopilotChat - Make text concise" },
            -- Chat with Copilot in visual mode
            {
                "<leader>ccv",
                ":CopilotChatVisual",
                mode = "x",
                desc = "CopilotChat - Open in vertical split",
            },
            {
                "<leader>ccx",
                ":CopilotChatInPlace<cr>",
                mode = "x",
                desc = "CopilotChat - Run in-place code",
            },
            -- Custom input for CopilotChat
            {
                "<leader>cci",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        vim.cmd("CopilotChat " .. input)
                    end
                end,
                desc = "CopilotChat - Ask input",
            },
            -- Generate commit message base on the git diff
            {
                "<leader>ccm",
                function()
                    local diff = get_git_diff()
                    if diff ~= "" then
                        vim.fn.setreg('"', diff)
                        vim.cmd("CopilotChat Write commit message for the change with commitizen convention.")
                    end
                end,
                desc = "CopilotChat - Generate commit message for all changes",
            },
            {
                "<leader>ccM",
                function()
                    local diff = get_git_diff(true)
                    if diff ~= "" then
                        vim.fn.setreg('"', diff)
                        vim.cmd("CopilotChat Write commit message for the change with commitizen convention.")
                    end
                end,
                desc = "CopilotChat - Generate commit message for staged changes",
            },
            -- Debug
            { "<leader>ccD", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
        },
    },
}
