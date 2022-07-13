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
    x = { "<cmd>NvimTreeToggle<CR>", "Open Nvim-Tree"},
}, {
    silent = true,
    noremap = true,
    prefix = '<leader>'
})

-------------------------------------------------------------------
-- Telescope
-------------------------------------------------------------------
whichkey.register({
    name = "Telescope",
    p = { ":Telescope<cr>", "Open Telescope"},
    f = {
        name = "Find",
        f = { "<cmd>Telescope find_files<cr>", "Find files"},
        g = { "<cmd>Telescope live_grep<cr>", "Find text"}
    }
},{
    silent = true,
    noremap = false,
    prefix = "<leader>"
})
