local map = vim.api.nvim_set_keymap

-------------------------------------------------------------------
-- Map leader
-------------------------------------------------------------------
vim.g.mapleader = ' '

-------------------------------------------------------------------
-- Better navigation
-------------------------------------------------------------------
map('n', "<C-h>", "<C-w>h", {silent = true, noremap = true})
map('n', "<C-j>", "<C-w>j", {silent = true, noremap = true})
map('n', "<C-k>", "<C-w>k", {silent = true, noremap = true})
map('n', "<C-l>", "<C-w>l", {silent = true, noremap = true})

map('n', "<C-Up>", ":resize -2<cr>", {silent = true, noremap = true})
map('n', "<C-Down>", ":resize +2<cr>", {silent = true, noremap = true})
map('n', "<C-Left>", ":vertical resize -2<cr>", {silent = true, noremap = true})
map('n', "<C-Right>", ":vertical resize +2<cr>", {silent = true, noremap = true})

map('n', "<S-l>", ":bn<cr>", {silent = true, noremap = true})
map('n', "<S-h>", ":bp<cr>", {silent = true, noremap = true})

-------------------------------------------------------------------
-- dap
-------------------------------------------------------------------
map('n', "<leader>dn", ":lua require('dap-python').test_method()<CR>", {silent = true, noremap = true})
map('n', "<leader>df", ":lua require('dap-python').test_class()<CR>", {silent = true, noremap = true})
map('n', "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", {silent = true, noremap = true})

map('n', "<F5>", "<Cmd>lua require'dap'.continue()<CR>", {silent = true, noremap = true})
map('n', "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", {silent = true, noremap = true})
map('n', "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", {silent = true, noremap = true})
map('n', "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", {silent = true, noremap = true})
map('n', "<Leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", {silent = true, noremap = true})
map('n', "<Leader>B", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {silent = true, noremap = true})
map('n', "<Leader>lp", "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", {silent = true, noremap = true})
map('n', "<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", {silent = true, noremap = true})
map('n', "<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", {silent = true, noremap = true})


-------------------------------------------------------------------
-- nvim-tree
-------------------------------------------------------------------
map("n", "<C-n>", ":NvimTreeToggle<CR>", {silent = true, noremap = true})


-------------------------------------------------------------------
-- Coc
-------------------------------------------------------------------
function _G.show_documentation()
    if vim.lsp.handlers["textDocument/hover"] ~= nil then
        return vim.lsp.buf.hover()
    else
        return vim.fn['feedkeys']('K', 'in')
    end
end

-- Use K to show documentation in preview window.
map('n', 'K', "v:lua.show_documentation()", { noremap = false, expr = true, silent = true })

-------------------------------------------------------------------
-- Telescope
-------------------------------------------------------------------

map('n', '<leader>p', ":Telescope<cr>", { silent = true, noremap = false })
