return {
    {
        "vim-test/vim-test",
        opts = {
            setup = {},
        },
        config = function(plugin, opts)
            vim.g["test#strategy"] = "neovim"
            vim.g["test#neovim#term_position"] = "belowright"
            vim.g["test#neovim#preserve_screen"] = 1

            -- Set up vim-test
            for k, _ in pairs(opts.setup) do
                opts.setup[k](plugin, opts)
            end
        end,
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-vim-test",
            "vim-test/vim-test",
            "stevearc/overseer.nvim",
        },
        keys = {
            { "<leader>t",  group = "Tests",                                                                     desc = "Tests" },
            { "<leader>td", "<cmd>w|lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", desc = "Debug File" },
            { "<leader>tL", "<cmd>w|lua require('neotest').run.run_last({strategy = 'dap'})<cr>",                desc = "Debug Last" },
            { "<leader>ta", "<cmd>w|lua require('neotest').run.attach()<cr>",                                    desc = "Attach" },
            { "<leader>tf", "<cmd>w|lua require('neotest').run.run(vim.fn.expand('%'))<cr>",                     desc = "File" },
            { "<leader>tF", "<cmd>w|lua require('neotest').run.run(vim.loop.cwd())<cr>",                         desc = "All Files" },
            { "<leader>tl", "<cmd>w|lua require('neotest').run.run_last()<cr>",                                  desc = "Last" },
            { "<leader>tn", "<cmd>w|lua require('neotest').run.run()<cr>",                                       desc = "Nearest" },
            { "<leader>tN", "<cmd>w|lua require('neotest').run.run({strategy = 'dap'})<cr>",                     desc = "Debug Nearest" },
            { "<leader>to", "<cmd>w|lua require('neotest').output.open({ enter = true })<cr>",                   desc = "Output" },
            { "<leader>ts", "<cmd>w|lua require('neotest').run.stop()<cr>",                                      desc = "Stop" },
            { "<leader>tS", "<cmd>w|lua require('neotest').summary.toggle()<cr>",                                desc = "Summary" },
        },
        opts = function()
            return {
                adapters = {
                    require "neotest-vim-test" {
                        ignore_file_types = { "python", "vim", "lua" },
                    },
                },
                status = { virtual_text = true },
                output = { open_on_run = true },
                -- overseer.nvim
                consumers = {
                    overseer = require "neotest.consumers.overseer",
                },
                overseer = {
                    enabled = true,
                    force_default = true,
                },
            }
        end,
        config = function(_, opts)
            local neotest_ns = vim.api.nvim_create_namespace "neotest"
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+",
                            "")
                        return message
                    end,
                },
            }, neotest_ns)
            require("neotest").setup(opts)
        end,
    },
}
