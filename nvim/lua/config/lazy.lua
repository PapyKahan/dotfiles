local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local msg = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = "base" },
        { import = "plugins" },
    },
    defaults = { lazy = true, version = nil },
    concurrency = 10,
    install = { missing = true, colorscheme = { 'tokyonight' } },
    ui = {
        border = "rounded",
    },
    performance = {
        cache = { enabled = true, },
        rtp = {
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    }
})
