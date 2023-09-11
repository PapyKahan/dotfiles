return {
    {
        "folke/which-key.nvim",
        lazy = false,
        opts = {
            defaults = {
                ['<leader>f'] = { name = 'Find' },
            },
        },
        config = function(_, opts)
            require('which-key').register(opts.defaults)
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = function()
            local utils = require 'lualine.utils.utils'

            local function get_fg_color(hlgroup)
                return utils.extract_highlight_colors(hlgroup, 'fg')
            end

            local diagnostic_signs = require 'base.ui.icons'.diagnostic_signs

            return {
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
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff' },
                    lualine_c = {
                        {
                            'filename',
                            symbols = {
                                modified = ' 󰏫',
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
                                error = diagnostic_signs.Error .. " ",
                                warn  = diagnostic_signs.Warn .. " ",
                                info  = diagnostic_signs.Info .. " ",
                                hint  = diagnostic_signs.Hint .. " "
                            },
                            colored = true,
                            update_in_insert = false,
                            always_visible = false,
                        } },
                    lualine_z = { 'progress', 'location' }
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
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                extensions = {
                    'symbols-outline',
                    'neo-tree',
                    'toggleterm',
                    'nvim-dap-ui',
                    'lazy',
                }
            }
        end,
    },
    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        version = "v3.*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diag)
                    local signs = require 'base.ui.icons'.diagnostic_signs
                    local ret = (diag.error and signs.Error .. diag.error .. " " or "") ..
                        (diag.warning and signs.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    { filetype = "neo-tree", text = "File Explorer", highlight = "Directory", text_align = "left" },
                }
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        keys = {
            { '<leader>x', "<cmd>Neotree toggle<CR>", desc = "Open Nvim-Tree" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        cmd = { 'Telescope' },
        keys = {
            { "<leader>p",  ":Telescope<cr>",            desc = "Open Telescope" },
            { "<leader>ff", ":Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", ":Telescope live_grep<cr>",  desc = "Grep files" },
            { "<leader>fb", ":Telescope buffers<cr>",    desc = "Find buffers" },
            { "<leader>fh", ":Telescope help_tags<cr>",  desc = "Find help tags" }
        },
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            'sharkdp/fd',
            'folke/which-key.nvim',
        },
        opts = {
            defaults = {
                file_ignore_patterns = { ".git/", ".git\\", "node_modules" },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" },
                mappings = {
                    i = {
                        ["<C-n>"] = function(...)
                            return require("telescope.actions").move_selection_next(...)
                        end,
                        ["<C-p>"] = function(...)
                            return require "telescope.actions".move_selection_previous(...)
                        end,
                        ["<C-c>"] = function(...)
                            require "telescope.actions".close(...)
                        end,
                        ["<C-j>"] = function(...)
                            require "telescope.actions".cycle_history_next(...)
                        end,
                        ["<C-k>"] = function(...)
                            require "telescope.actions".cycle_history_prev(...)
                        end,
                    },
                    n = {
                        ["<C-n>"] = function(...)
                            return require("telescope.actions").move_selection_next(...)
                        end,
                        ["<C-p>"] = function(...)
                            return require "telescope.actions".move_selection_previous(...)
                        end,
                    },
                },
            },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        'stevearc/dressing.nvim',
        event = "VeryLazy",
        dependencies = 'MunifTanjim/nui.nvim',
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
}
