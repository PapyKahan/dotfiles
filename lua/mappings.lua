local map = vim.api.nvim_set_keymap
local loaded, whichkey = pcall(require, 'which-key')
if not loaded then
    return
end

-------------------------------------------------------------------
-- Map leader
-------------------------------------------------------------------
vim.g.mapleader = ' '

-------------------------------------------------------------------
-- Better navigation
-------------------------------------------------------------------
whichkey.register({
    ["<C-h>"] = { "<C-w>h", 'Move to left window' },
    ["<C-j>"] = { "<C-w>j", "Move to downward window" },
    ["<C-k>"] = { "<C-w>k", "Move to upward window" },
    ["<C-l>"] = { "<C-w>l", "Move to right window" },

    ["<C-Up>"] = { "<cmd>resize -2<cr>", "Horizontaly decrease windows size" },
    ["<C-Down>"] = { "<cmd>resize +2<cr>", "Horizontaly increase windows size" },
    ["<C-Left>"] = { "<cmd>vertical resize -2<cr>", "Verticaly decrease windows size" },
    ["<C-Right>"] = { "<cmd>vertical resize +2<cr>", "Verticaly increase windows size" },

    ["<S-l>"] = { "<cmd>bn<cr>", "Select next buffer" },
    ["<S-h>"] = { "<cmd>bp<cr>", "Select previous buffer" },
}, {
    silent = true,
    noremap = false
})

-------------------------------------------------------------------
-- nvim-tree
-------------------------------------------------------------------
whichkey.register({
    ["C-n"] = { ":NvimTreeToggle<CR>", "Open Nvim-Tree"},
}, {
    silent = true,
    noremap = false
})

-------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------
-- Use K to show documentation in preview window.
whichkey.register({
    K = { function () vim.lsp.buf.hover() end, "Show documentation"}
}, {
    silent = true,
    noremap = false
})

-------------------------------------------------------------------
-- Telescope
-------------------------------------------------------------------
whichkey.register({
    p = { ":Telescope<cr>", "Open Telescope"}
},{
    silent = true,
    noremap = false,
    prefix = "<leader>"
})
