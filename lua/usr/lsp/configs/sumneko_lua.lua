local lua_options = {
    cmd = { 'lua-language-server.cmd' },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    [vim.fn.stdpath('config') .. '/lua'] = true,
                    [vim.fn.stdpath('data') .. '/site/pack/packer'] = true,
                }
            },
        },
    },
}

local loaded, luadev = pcall(require, 'lua-dev')
if not loaded then
    return lua_options
end

return luadev.setup({
    lspconfig = lua_options,
    vimruntime = true,
    types = true,
    plugins = true,
})
