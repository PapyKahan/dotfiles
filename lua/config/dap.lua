-- Define debug signs
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='🔘', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='❕', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🔷', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🚫', texthl='', linehl='', numhl=''})



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
},{
    silent = true,
    noremap = false,
    prefix = "<leader>"
})

local dap_loaded, dap = pcall(require, 'dap')
if not dap_loaded then
    return
end

whichkey.register({
    name = "Dap",
    ["<F5>"] = { function() dap.continue() end, "Continue debugging" },
    ["<F10>"] = { function() dap.step_over({}) end, "Debugging step over" },
    ["<F11>"] = { function() dap.step_into() end, "Debugging step into" },
    ["<F12>"] = { function() dap.step_out() end, "Debugging step out" },
},{
    silent = true,
    noremap = false,
})

whichkey.register({
    name = "Dap",
    b = { function() dap.toggle_breakpoint() end, "Toggle breakpoint" },
    B = { function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Toggle conditional breakpoint" },
    lp = { function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, "Toggle logging breakpoint" },
    dr = { function() dap.repl.open() end, "" },
    dl = { function() dap.run_last() end, "Run last debug session" },
},{
    silent = true,
    noremap = false,
    prefix = "<leader>"
})
