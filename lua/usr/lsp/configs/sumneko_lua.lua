local lua_options = {
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

return lua_options
