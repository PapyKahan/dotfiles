local lua_options = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                }
            },
        },
    },
}

if vim.env['NEXTHINK'] then
    lua_options.cmd = { vim.env['LSP_LANGUAGE_SERVERS']..'sumneko_lua\\extension\\server\\bin\\lua-language-server.exe', "--stdio" }
end

local loaded, lua_dev = pcall(require, "lua-dev")
if not loaded then
    return lua_options
end

local opts = {
    library = {
        vimruntime = true,
        types = true,
        plugins = true,
    },
    lspconfig = lua_options
}

return lua_dev.setup(opts)
