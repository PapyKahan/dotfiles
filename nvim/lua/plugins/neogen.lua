return {
    {
        "folke/which-key.nvim",
        lazy = false,
        opts = {
            defaults = {
                { "<leader>g", group = "Docgen" },
            },
        },
        config = function(_, opts)
            require('which-key').add(opts.defaults)
        end
    },
    {
        "danymat/neogen",
        event = { 'BufReadPost', 'BufNewFile' },
        keys = {
            { "<leader>gf", function() require('neogen').generate({ snippet_engine = 'vsnip', type = 'func' }) end,  desc = "Generate function doc" },
            { "<leader>gc", function() require('neogen').generate({ snippet_engine = 'vsnip', type = 'class' }) end, desc = "Generate class doc" },
            { "<leader>gF", function() require('neogen').generate({ snippet_engine = 'vsnip', type = 'file' }) end,  desc = "Generate file doc" },
            { "<leader>gt", function() require('neogen').generate({ snippet_engine = 'vsnip', type = 'type' }) end,  desc = "Generate type doc" },
        },
        dependencies = {
            "folke/which-key.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require 'neogen'.setup({
                snippet_engine = "vsnip",
                enabled = true,
                languages = {
                    lua = {
                        template = {
                            annotation_convention = "ldoc",
                        },
                    },
                    python = {
                        template = {
                            annotation_convention = "google_docstrings",
                        },
                    },
                    rust = {
                        template = {
                            annotation_convention = "rustdoc",
                        },
                    },
                    javascript = {
                        template = {
                            annotation_convention = "jsdoc",
                        },
                    },
                    typescript = {
                        template = {
                            annotation_convention = "tsdoc",
                        },
                    },
                    typescriptreact = {
                        template = {
                            annotation_convention = "tsdoc",
                        },
                    },
                },
            });
        end
    }
}
