local loaded, lspconfig = pcall(require, "lspconfig")
if not loaded then
   return
end

-- Borders for LspInfo winodw
local win = require "lspconfig.ui.windows"
local _default_opts = win.default_opts

win.default_opts = function(options)
    local opts = _default_opts(options)
    opts.focusable = false
    opts.style = "minimal"
    opts.border = "rounded"
    return opts
end

local lsp = require 'lsp'
local default_capabilities = lsp.default_capabilities()

lspconfig.sumneko_lua.setup {
    on_attach = lsp.default_on_attach_callback,
    capabilities = default_capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
}

lspconfig.pyright.setup {
    on_attach = lsp.default_on_attach_callback,
    capabilities = default_capabilities,
    cmd = { vim.env['LSP_LANGUAGE_SERVERS']..'\\pyright\\node_modules\\.bin\\pyright-langserver.cmd', "--stdio" }
}
