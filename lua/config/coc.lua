vim.g.coc_global_extensions = { 'coc-json', 'coc-html', 'coc-html-css-support', 'coc-tsserver', 'coc-yaml', 'coc-lists', 'coc-pairs', 'coc-pyright', 'coc-clangd', 'coc-sumneko-lua' }

local config = vim.fn['coc#config']

config("sumneko-lua.enable", true)
config("sumneko-lua.enableNvimLuaDev", true)
-- Only for my corporate workplace
if vim.env['NEXTHINK'] then
    config("sumneko-lua.serverDir", vim.env['LUA_LANGUAGE_SERVER'])
end
config("Lua.diagnostics.workspaceDelay", 10000)
config("Lua.telemetry.enable", false)
