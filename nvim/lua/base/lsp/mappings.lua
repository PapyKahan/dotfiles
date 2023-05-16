local M = {}

local whichkey_loaded, whichkey = pcall(require, 'which-key')

function M.setup_buffer_mappings(bufnr)
    if whichkey_loaded then
        whichkey.register({
            l = {
                name = "Code",
                g = {
                    name = "Goto/Get",
                    D = { function () vim.lsp.buf.declaration() end, "Go to declaration" },
                    d = { function() vim.lsp.buf.definition() end, "Go to definition" },
                    t = { function() vim.lsp.buf.type_definition() end, "Go to type definition" },
                    i = { function() vim.lsp.buf.implementation() end, "Go to implementation" },
                    S = { function() vim.lsp.buf.signature_help() end, "Get signature" },
                    r = { function() vim.lsp.buf.references() end, "Get all references" },
                },
                r = { function() vim.lsp.buf.rename() end, "Rename" },
                a = { function () vim.lsp.buf.code_action() end, "Code action" },
                f = { function() vim.lsp.buf.format() end, "Format" },
            }
        }, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            prefix = '<leader>'
        })

        whichkey.register({
            name = "Code",
            K = { function() vim.lsp.buf.hover() end, "Show documentation" },
        }, {
            noremap = true,
            silent = true,
            buffer = bufnr
        })
    end
end

function M.setup()
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    if whichkey_loaded then
        whichkey.register({
            l = {
                e = { function() vim.diagnostic.open_float() end, "Show diagnostics" },
                q = { function() vim.diagnostic.setloclist() end, "Show local list" },
                t = { "<cmd>TroubleToggle<cr>", "Show troubles"},
                o = { "<cmd>SymbolsOutline<cr>", "Show symbols outline"},
            }
        }, {
            noremap = true,
            silent = true,
            prefix = '<leader>',
        })

        whichkey.register({
            name = "Code",
            ["[d"] = { function() vim.diagnostic.goto_prev() end, "Goto previous diagnostic" },
            ["]d"] = { function() vim.diagnostic.goto_next() end, "Goto next diagnostic" },

        }, {
            noremap = true,
            silent = true,
        })
    end
end

return M
