require'neogen'.setup({
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

-- the annotation type to generate. Currently supported: func, class, type, file
require'which-key'.register({
    name = "Docgen",
    g = {
        f = { function() require'neogen'.generate({ snippet_engine = 'vsnip', type = 'func' }) end, "Generate function doc" },
        c = { function() require'neogen'.generate({ snippet_engine = 'vsnip', type = 'class' }) end, "Generate class doc" },
        F = { function() require'neogen'.generate({ snippet_engine = 'vsnip', type = 'file' }) end, "Generate file doc" },
        t = { function() require'neogen'.generate({ snippet_engine = 'vsnip', type = 'type' }) end, "Generate type doc" },
    }
}, {
    noremap = true,
    mode = 'n',
    silent = true,
    expr = true,
    prefix = '<leader>',
})
