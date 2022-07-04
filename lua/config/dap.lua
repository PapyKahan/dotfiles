local loaded, dap_python = pcall(require, 'dap-python')
if not loaded then
    return
end

if vim.env['NEXTHINK'] then
    dap_python.setup('c:/ieu/tools/python3/python.exe')
else
    dap_python.setup()
end

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='🔘', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='❕', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🔷', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🚫', texthl='', linehl='', numhl=''})
