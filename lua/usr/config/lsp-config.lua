local loaded, lspconfig = pcall(require, "lspconfig")
if not loaded then
   return
end

local win = require "lspconfig.ui.windows"
local _default_opts = win.default_opts

win.default_opts = function(options)
    local opts = _default_opts(options)
    opts.focusable = false
    opts.style = "minimal"
    opts.border = "rounded"
    return opts
end

local lsp = require 'usr.lsp'
local default_capabilities = lsp.default_capabilities()

local lua_options = {
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
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
}

if vim.env['NEXTHINK'] then
    lua_options.cmd = { vim.env['LSP_LANGUAGE_SERVERS']..'sumneko_lua\\extension\\server\\bin\\lua-language-server.exe', "--stdio" }
end

lspconfig.sumneko_lua.setup(lua_options)

local pyright_opt = {
    on_attach = lsp.default_on_attach_callback,
    capabilities = default_capabilities,
}

if vim.env['NEXTHINK'] then
    pyright_opt.cmd = { vim.env['LSP_LANGUAGE_SERVERS']..'\\pyright\\node_modules\\.bin\\pyright-langserver.cmd', "--stdio" }
end

lspconfig.pyright.setup(pyright_opt)
