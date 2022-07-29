local dap_python_loaded, dap_python = pcall(require, 'dap-python')
if not dap_python_loaded then
    return
end

if vim.env['NEXTHINK'] then
    dap_python.setup('c:/ieu/tools/python3/python.exe')
else
    dap_python.setup()
end

-------------------------------------------------------------------
-- Mapping
-------------------------------------------------------------------
local whichkey_loaded, whichkey = pcall(require, 'which-key')
if not whichkey_loaded then
    return
end

whichkey.register({
    name = "Dap Python",
    dm = { function() dap_python.test_method({}) end, "Exectute test method" },
    dc = { function() dap_python.test_class({}) end, "Exectute test class" },
    ds = { function() dap_python.debug_selection({}) end, "Debug selection" }
}, {
    silent = true,
    noremap = false,
    prefix = "<leader>"
})

local dap_loaded, dap = pcall(require, 'dap')
if not dap_loaded then
    return
end


whichkey.register({
    name = "Debugging",
    d = {
        b = { function() dap.toggle_breakpoint() end, "Toggle breakpoint" },
        B = { function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Toggle conditional breakpoint" },
        l = { function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, "Toggle logging breakpoint" },
        x = { function() dap.clear_breakpoints() end, "Clear all breakpoints" },
        r = { function() dap.repl.toggle() end, "Open debug console" },
        d = { function() dap.run_last() end, "Run last session" },
        c = { function() dap.continue() end, "Continue" },
        o = { function() dap.step_over({}) end, "Step over" },
        i = { function() dap.step_into() end, "Step into" },
        u = { function() dap.step_out() end, "Step out" },
        s = { function() dap.continue() end, "Start" },
        q = { function() dap.close() end, "Quit" },
    }
}, {
    silent = true,
    noremap = false,
    prefix = "<leader>"
})

local ui = {
    breakpoint = {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
    },
    breakpoint_condition = {
        text = "",
        texthl = "DiagnosticSignWarn",
        linehl = "",
        numhl = "",
    },
    log_point = {
        text = "",
        texthl = "DiagnosticSignInfo",
        linehl = "",
        numhl = "",
    },
    breakpoint_rejected = {
        text = "",
        texthl = "DiagnosticSignHint",
        linehl = "",
        numhl = "",
    },
    stopped = {
        text = "",
        texthl = "DiagnosticsSignInfo",
        linehl = "DiagnosticUnderlineInfo",
        numhl = "DiagnosticSignInfo",
    },
}

-- Define debug signs
vim.fn.sign_define("DapBreakpoint", ui.breakpoint)
vim.fn.sign_define('DapBreakpointCondition', ui.breakpoint_condition)
vim.fn.sign_define('DapLogPoint', ui.log_point)
vim.fn.sign_define('DapStopped', ui.stopped)
vim.fn.sign_define('DapBreakpointRejected', ui.breakpoint_rejected)
