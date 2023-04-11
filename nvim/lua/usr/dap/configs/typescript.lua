local dap_loaded, dap = pcall(require, 'dap')
if not dap_loaded then
    return
end

local dap_vscode_loaded, dap_vscode = pcall(require, 'dap-vscode-js')
if not dap_vscode_loaded then
    return
end

local debuger_adapter_path = "js-debug-adapter"
-- if we are on windows, we need to add the .cmd extension
if (vim.fn.has('win32') == 1 or vim.fn.has('win64') or vim.fn.has('win32unix')) then
    debuger_adapter_path = debuger_adapter_path..".cmd"
end
if vim.env['LSP_LANGUAGE_SERVERS'] then
    debuger_adapter_path = vim.env['LSP_LANGUAGE_SERVERS'].."/bin/"..debuger_adapter_path
end

dap_vscode.setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
    debugger_cmd = { debuger_adapter_path }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
    -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
    -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
    -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
    require("dap").configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
        }
    }
end
