local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- Clone the lazy.nvim repository if it doesn't exist
    vim.fn.system({
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
        { import = "environments" },
        { import = "plugins" },
    },
    defaults = { lazy = true, version = nil },
    concurrency = vim.loop.available_parallelism() or 8,
    install = { missing = true, colorscheme = { 'tokyonight' } },
    checker = { enabled = false }, -- Disable automatic update checking
    ui = {
        border = "rounded",

    performance = {
        cache = { enabled = true, },
        reset_packpath = true, -- Reset the package path to improve startup time
        rtp = {
            reset = true, -- Reset the runtime path to improve startup time
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
                "2html_plugin",
                "getscript",
                "getscriptPlugin",
                "logipat",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
            },
        },
        -- Startup optimization
        startup = {
            events = {
                -- Load UI events as late as possible
                "UIEnter",
                "BufReadPost",
                "BufNewFile",
                "BufWritePre",
            },
        },
    }
    }
})
