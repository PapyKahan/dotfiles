return {
    {
        "danymat/neogen",
        event = { 'BufReadPost', 'BufNewFile' },
        keys = {
            { "<leader>ld", group = "Docgen", desc = "Docgen" },
            { "<leader>ldm", function() require('neogen').generate({ snippet_engine = 'vsnip', type = 'module' }) end, desc = "Generate module doc"},
            { "<leader>ldf", function() require('neogen').generate({ snippet_engine = 'vsnip', type = 'func' }) end,  desc = "Generate function doc" },
            { "<leader>ldc", function() require('neogen').generate({ snippet_engine = 'vsnip', type = 'class' }) end, desc = "Generate class doc" },
            { "<leader>ldF", function() require('neogen').generate({ snippet_engine = 'vsnip', type = 'file' }) end,  desc = "Generate file doc" },
            { "<leader>ldt", function() require('neogen').generate({ snippet_engine = 'vsnip', type = 'type' }) end,  desc = "Generate type doc" },
        },
        dependencies = {
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
