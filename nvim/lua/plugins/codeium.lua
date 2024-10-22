return {
    'Exafunction/codeium.vim',
    event = 'VeryLazy',
    init = function()
        if vim.env['LSP_LANGUAGE_SERVERS'] then
            vim.g.codeium_bin = "C:\\ieu\\tools\\codeium\\bin\\language_server_windows_x64.exe"
        end
        vim.g.codeium_disable_bindings = 1
    end,
    keys = {
        { "<M-i>", function() return vim.fn['codeium#Accept']() end },
        { "<M-j>", function() return vim.fn['codeium#CycleCompletions'](1) end },
        { "<M-k>", function() return vim.fn['codeium#CycleCompletions'](-1) end },
        { "<M-l>", function() return vim.fn['codeium#Clear']() end },
    },
}
