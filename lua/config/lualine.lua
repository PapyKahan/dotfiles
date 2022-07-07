local loaded, lualine = pcall(require, 'lualine')
if not loaded then
    return
end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff' },
        lualine_c = {
            {
                'filename',
                symbols = {
                    modified = ' ',       -- Text to show when the file is modified.
                    readonly = ' ',      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                }
            }
        },
        lualine_x = {'encoding', 'fileformat', { 'filetype', colored = false } },
        lualine_y = {
            {
                'diagnostics',
                -- Table of diagnostic sources, available sources are:
                --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
                -- or a function that returns a table as such:
                --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
                sources = { 'nvim_diagnostic' },
                -- Displays diagnostics for the defined severity types
                sections = { 'error', 'warn', 'info', 'hint' },
                diagnostics_color = {
                    -- Same values as the general color option can be used here.
                    error = 'DiagnosticError', -- Changes diagnostics' error color.
                    warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
                    info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
                    hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
                },
                symbols = { error = " ", warn  = " ", info  = " ", hint  = " " },
                colored = true,           -- Displays diagnostics status in color if set to true.
                update_in_insert = false, -- Update diagnostics in insert mode.
                always_visible = false,   -- Show diagnostics even if there are none.
            }},
        lualine_z = {'progress', 'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                symbols = {
                    modified = ' ',       -- Text to show when the file is modified.
                    readonly = ' ',      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                }
            }
        },
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {{
            'buffers',
            symbols = {
                modified = ' ',      -- Text to show when the buffer is modified
                alternate_file = '#', -- Text to show to identify the alternate file
                directory =  '',     -- Text to show when the buffer is a directory
                readonly = ' ',      -- Text to show when the file is non-modifiable or readonly.
                unnamed = '[No Name]', -- Text to show for unnamed buffers.
            },
        }},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {}
}
