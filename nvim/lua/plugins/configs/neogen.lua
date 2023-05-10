local loaded, neogen = pcall(require, "neogen")
if not loaded then
    return
end

neogen.setup({
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

local whichkey_loaded, whichkey = pcall(require, 'which-key')
if not whichkey_loaded then
    return
end

-- the annotation type to generate. Currently supported: func, class, type, file
whichkey.register({
    name = "Docgen",
    c = {
        f = { function() neogen.generate({ snippet_engine = 'vsnip', type = 'func' }) end, "Generate function doc" },
        c = { function() neogen.generate({ snippet_engine = 'vsnip', type = 'class' }) end, "Generate class doc" },
        F = { function() neogen.generate({ snippet_engine = 'vsnip', type = 'file' }) end, "Generate file doc" },
        t = { function() neogen.generate({ snippet_engine = 'vsnip', type = 'type' }) end, "Generate type doc" },
    }
}, {
    noremap = true,
    mode = 'n',
    silent = true,
    expr = true,
    prefix = '<leader>',
})
