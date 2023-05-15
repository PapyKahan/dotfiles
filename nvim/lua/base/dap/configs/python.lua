local dap_python_loaded, dap_python = pcall(require, 'dap-python')
if not dap_python_loaded then
    return
end

if vim.env['NEXTHINK'] then
    dap_python.setup('C:/ieu/tools/WPy64-31101/python-3.11.0.amd64/python.exe')
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
    --dc = { function() dap_python.test_class({}) end, "Exectute test class" },
    --ds = { function() dap_python.debug_selection({}) end, "Debug selection" }
}, {
    silent = true,
    noremap = false,
    prefix = "<leader>"
})
