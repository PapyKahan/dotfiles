local pyright_opt = {
}

if vim.env['NEXTHINK'] then
    pyright_opt.cmd = { vim.env['LSP_LANGUAGE_SERVERS']..'\\pyright\\node_modules\\.bin\\pyright-langserver.cmd', "--stdio" }
end

return pyright_opt
