local loaded, rust_tools = pcall(require, 'rust-tools')
if not loaded then
    return {}
end

local registry = require'mason-registry'
local codelldb = registry.get_package('codelldb')
if not codelldb then
    return {}
end

local install_path = codelldb:get_install_path()

local extension_path = install_path .. '/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb'

local this_os = vim.loop.os_uname().sysname;
-- The path in windows is different
if this_os:find "Windows" then
  codelldb_path = extension_path .. "adapter\\codelldb.exe"
  liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
else
  -- The liblldb extension is .so for linux and .dylib for macOS
  liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

rust_tools.setup({
    tools = {
        inlay_hints = {
            -- automatically set inlay hints (type hints)
            -- default: true
            auto = true,
        }

    },
    server = {
        on_attach = function(client, bufnr)
        end,
        settings = {
            ["rust-analyzer"] = {
                enable = true,
                cargo = {
                    autoReload = true,
                },
            }
        }
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
})

require('dap.ext.vscode').load_launchjs(nil, {rt_lldb={'rust'}})
