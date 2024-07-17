return {
    {
        "folke/which-key.nvim",
        lazy = false,
        opts = {
            defaults = {
                { "<leader>l",  group = "Code" },
                { "<leader>lg", group = "Goto/Get/Find" }
            },
        },
        config = function(_, opts)
            require('which-key').register(opts.defaults)
        end
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'folke/noice.nvim',
            'williamboman/mason-lspconfig.nvim',

        },
        opts = {
            servers = {}
        },
        config = function(_, opts)
            require 'base.lsp.diagnostic'.setup()
            require 'base.lsp.config'.setup(_, opts)
        end
    },
    {
        'nvimdev/lspsaga.nvim',
        event = "LspAttach",
        keys = {
            { "K",           "<cmd>Lspsaga hover_doc<cr>",                  desc = "Show documentation" },
            { "<leader>la",  "<cmd>Lspsaga code_action<cr>",                desc = "Actions" },
            { "<leader>le",  "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "Show diagnostics" },
            { "<leader>li",  function() vim.lsp.buf.implementation() end,   desc = "Got to implementation" },
            { "<leader>lo",  "<cmd>Lspsaga outline<cr>",                    desc = "Show symbols outline" },
            { "<leader>lf",  function() vim.lsp.buf.format() end,           desc = "Format" },
            { "<leader>lq",  "<cmd>Lspsaga show_line_diagnostics<cr>",      desc = "Show line diagnostics" },
            { "<leader>lr",  "<cmd>Lspsaga rename<cr>",                     desc = "Rename" },
            { "<leader>lS",  function() vim.lsp.buf.signature_help() end,   desc = "Get signature" },
            { "<leader>lgd", "<cmd>Lspsaga goto_definition<cr>",            desc = "Go to definition" },
            { "<leader>lgt", "<cmd>Lspsaga goto_type_definition<cr>",       desc = "Go to type definition" },
            { "<leader>lgr", "<cmd>Lspsaga finder<cr>",                     desc = "Find references" },
        },
        opts = {
            ui = {
                border = 'rounded',
            },
            finder = {
                layout = 'float',
            },
            outline = {
                detail = true,
                layout = 'float',
                max_height = 0.8,
            },
            diagnostic = {
                show_layout = 'normal',
            },

        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons'
        }
    },
    {
        'williamboman/mason.nvim',
        cmd = { 'Mason', 'MasonUpdate', 'MasonInstall', 'MasonUninstall', 'MasonLog', 'MasonUninstallAll' },
        config = function()
            local options = {
                ui = {
                    border = "rounded"
                },
                automatic_installation = true,
                max_concurrent_installers = 10,
            }
            if vim.env['LSP_LANGUAGE_SERVERS'] then
                options.install_root_dir = vim.env['LSP_LANGUAGE_SERVERS']
            end
            require('mason').setup(options)
        end
    },
    {
        "folke/trouble.nvim",
        event = "LspAttach",
        keys = {
            { "<leader>ltd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Show diagnostics" },
        },
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local diagnostic_signs = require 'base.ui.icons'.diagnostic_signs
            require('trouble').setup {
                signs = {
                    error = diagnostic_signs.Error,
                    warning = diagnostic_signs.Warn,
                    hint = diagnostic_signs.Hint,
                    information = diagnostic_signs.Info,
                    other = diagnostic_signs.Other,
                },
            }
        end,
    },
}
