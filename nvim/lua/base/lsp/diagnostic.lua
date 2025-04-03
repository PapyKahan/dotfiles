local M =  {}

function M.setup()
    local diagnostic_signs = require 'base.ui.icons'.diagnostic_signs
    vim.diagnostic.config {
        virtual_text = {
            prefix = "",
        },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
                [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
                [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
                [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
            },
            linehl = {
                [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
                [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
                [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
                [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
                [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
                [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
                [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
            },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
            format = function(d)
                local t = vim.deepcopy(d)
                local code = d.code or (d.user_data and d.user_data.lsp.code)
                if code then
                    t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
                end
                return t.message
            end,
        }
    }
end

return M
