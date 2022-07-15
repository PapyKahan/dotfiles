local loaded, lspconfig = pcall(require, "lspconfig")
if not loaded then
   return
end

local M = {}
local lsp = require 'usr.lsp'

function M.setup(servers)
    local default_capabilities = lsp.default_capabilities()
    for _, server_name in pairs(servers) do
        local server_config = require("usr.lsp.configs."..server_name)
        server_config.capabilities = default_capabilities
        server_config.on_attach = lsp.default_on_attach_callback

        lspconfig[server_name].setup(server_config)
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
end

return M
