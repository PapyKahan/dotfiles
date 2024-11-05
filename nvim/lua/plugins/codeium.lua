return {
    'Exafunction/codeium.nvim',
    event = 'BufEnter',
    --init = function()
    --    vim.g.codeium_no_map_tab = true
    --    if vim.env['LSP_LANGUAGE_SERVERS'] then
    --        vim.g.codeium_bin = "C:\\ieu\\tools\\codeium\\bin\\language_server_windows_x64.exe"
    --    end
    --end,
    config = function()
        local config = {
            enable_cmp_source = false,
            enable_chat = true,
            virtual_text = {
                enabled = true,

                -- These are the defaults

                -- Set to true if you never want completions to be shown automatically.
                manual = false,
                -- A mapping of filetype to true or false, to enable virtual text.
                filetypes = {},
                -- Whether to enable virtual text of not for filetypes not specifically listed above.
                default_filetype_enabled = true,
                -- How long to wait (in ms) before requesting completions after typing stops.
                idle_delay = 75,
                -- Priority of the virtual text. This usually ensures that the completions appear on top of
                -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
                -- desired.
                virtual_text_priority = 65535,
                -- Set to false to disable all key bindings for managing completions.
                map_keys = true,
                -- The key to press when hitting the accept keybinding but no completion is showing.
                -- Defaults to \t normally or <c-n> when a popup is showing.
                accept_fallback = nil,
                -- Key bindings for managing completions in virtual text mode.
                key_bindings = {
                    -- Accept the current completion.
                    accept = "<M-i>",
                    -- Accept the next word.
                    accept_word = false,
                    -- Accept the next line.
                    accept_line = false,
                    -- Clear the virtual text.
                    clear = false,
                    -- Cycle to the next completion.
                    next = "<M-j>",
                    -- Cycle to the previous completion.
                    prev = "<M-k>",
                }
            }
        }
        if vim.env['LSP_LANGUAGE_SERVERS'] then
            config.detect_proxy = true
            config.config_path = "C:\\Users\\U118120\\.codeium\\codeium.json"
            config.bin_path = "C:\\ieu\\tools\\codeium"
            --config.language_server = "C:\\ieu\\tools\\codeium\\bin\\language_server_windows_x64.exe"
        end

        require('codeium').setup(config)
    end,
    --keys = {
    --    { "<M-i>", function() return vim.fn['codeium#Accept']() end,             mode = { "i" }, remap = true, expr = true, silent = true },
    --    { "<M-j>", function() return vim.fn['codeium#CycleCompletions'](1) end,  mode = { "i" }, remap = true, expr = true, silent = true },
    --    { "<M-k>", function() return vim.fn['codeium#CycleCompletions'](-1) end, mode = { "i" }, remap = true, expr = true, silent = true },
    --    { "<M-l>", function() return vim.fn['codeium#Clear']() end,              mode = { "i" }, remap = true, expr = true, silent = true },
    --},
}
