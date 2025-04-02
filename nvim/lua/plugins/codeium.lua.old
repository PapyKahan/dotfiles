return {
    'Exafunction/codeium.nvim',
    event = 'BufEnter',
    config = function()
        local config = {
            enable_cmp_source = false,
            enable_chat = true,
            virtual_text = {
                enabled = true,
                manual = false,
                filetypes = {},
                default_filetype_enabled = true,
                idle_delay = 75,
                virtual_text_priority = 65535,
                map_keys = true,
                accept_fallback = nil,
                key_bindings = {
                    accept = "<M-i>",
                    accept_word = false,
                    accept_line = false,
                    clear = false,
                    next = "<M-j>",
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
}
