local loaded, lualine = pcall(require, 'lualine')
if not loaded then
    return
end

local utils = require'lualine.utils.utils'
local function get_fg_color(hlgroup)
    return utils.extract_highlight_colors(hlgroup, 'fg')
end

local diagnostic_signs = require'usr.ui.icons'.diagnostic_signs

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
                    modified = ' ',
                    readonly = ' ',
                    unnamed = '[No Name]',
                }
            }
        },
        lualine_x = {
            'encoding',
            'fileformat',
            {
                'filetype',
                colored = false
            },
            {
                function()
                    local msg = 'No Active Lsp'
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                        end
                    end
                    return msg
                end,
                icon = ''
            },
        },
        lualine_y = {
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                sections = { 'error', 'warn', 'info', 'hint' },
                diagnostics_color = {
                    error = { fg = get_fg_color('DiagnosticSignError') },
                    warn  = { fg = get_fg_color('DiagnosticSignWarn') },
                    info  = { fg = get_fg_color('DiagnosticSignInfo') },
                    hint  = { fg = get_fg_color('DiagnosticSignHint') },
                },
                symbols = {
                    error = diagnostic_signs.Error.." ",
                    warn  = diagnostic_signs.Warn.." ",
                    info  = diagnostic_signs.Info.." ",
                    hint  = diagnostic_signs.Hint.." "
                },
                colored = true,
                update_in_insert = false,
                always_visible = false,
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
                    modified = ' ',
                    readonly = ' ',
                    unnamed = '[No Name]',
                }
            }
        },
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    --tabline = {
    --    lualine_a = {{
    --        'buffers',
    --        symbols = {
    --            modified = ' ',
    --            alternate_file = '#',
    --            directory =  '',
    --            readonly = ' ',
    --            unnamed = '[No Name]',
    --        },
    --    }},
    --    lualine_b = {},
    --    lualine_c = {},
    --    lualine_x = {},
    --    lualine_y = {},
    --    lualine_z = {}
    --},
    extensions = {
        'symbols-outline',
        'nvim-tree',
        'toggleterm',
        'nvim-dap-ui',
    }
}
