local loaded, lualine = pcall(require, 'lualine')
if not loaded then
    return
end

local utils = require'lualine.utils.utils'
local function get_fg_color(hlgroup)
    return utils.extract_highlight_colors(hlgroup, 'fg')
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
                sources = { 'nvim_diagnostic' },
                -- Displays diagnostics for the defined severity types
                sections = { 'error', 'warn', 'info', 'hint' },
                diagnostics_color = {
                    -- Same values as the general color option can be used here.
                    error = { fg = get_fg_color('DiagnosticSignError') }, -- Changes diagnostics' error color.
                    warn  = { fg = get_fg_color('DiagnosticSignWarn') },  -- Changes diagnostics' warn color.
                    info  = { fg = get_fg_color('DiagnosticSignInfo') },  -- Changes diagnostics' info color.
                    hint  = { fg = get_fg_color('DiagnosticSignHint') },  -- Changes diagnostics' hint color.
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
