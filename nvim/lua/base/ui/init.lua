return {
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
                    --section_separators = { left = '', right = '' },
                    --section_separators = { left = '', right = '' },
                    section_separators = '',
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
                        {
                            function()
                                local register = vim.fn.reg_recording()
                                if register == "" then return "" end
                                return "@recording " .. register
                            end,
                            color = { fg = "#ff9e64" },
                        },
                        'encoding',
                        'fileformat',
                        {
                            'filetype',
                            --colored = false
                        },
                        {
                            function()
                                local msg = 'No Active Lsp'
                                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                                local clients = vim.lsp.get_clients()
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
                        {
                            function()
                                -- Check if MCPHub is loaded
                                if not vim.g.loaded_mcphub then
                                    return "󰐻 -"
                                end

                                local count = vim.g.mcphub_servers_count or 0
                                local status = vim.g.mcphub_status or "stopped"
                                local executing = vim.g.mcphub_executing

                                -- Show "-" when stopped
                                if status == "stopped" then
                                    return "󰐻 -"
                                end

                                -- Show spinner when executing, starting, or restarting
                                if executing or status == "starting" or status == "restarting" then
                                    local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                                    local frame = math.floor(vim.loop.now() / 100) % #frames + 1
                                    return "󰐻 " .. frames[frame]
                                end

                                return "󰐻 " .. count
                            end,
                            color = function()
                                if not vim.g.loaded_mcphub then
                                    return { fg = "#6c7086" } -- Gray for not loaded
                                end

                                local status = vim.g.mcphub_status or "stopped"
                                if status == "ready" or status == "restarted" then
                                    return { fg = "#50fa7b" } -- Green for connected
                                elseif status == "starting" or status == "restarting" then
                                    return { fg = "#ffb86c" } -- Orange for connecting
                                else
                                    return { fg = "#ff5555" } -- Red for error/stopped
                                end
                            end,

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
        --branch = "v3.x",
        keys = {
            { '<leader>x', "<cmd>Neotree toggle<CR>", desc = "Open Nvim-Tree" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require('neo-tree').setup({
                filesystem = {
                    commands = {
                        avante_add_files = function(state)
                            local node = state.tree:get_node()
                            local filepath = node:get_id()
                            local relative_path = require('avante.utils').relative_path(filepath)

                            local sidebar = require('avante').get()

                            local open = sidebar:is_open()
                            -- ensure avante sidebar is open
                            if not open then
                                require('avante.api').ask()
                                sidebar = require('avante').get()
                            end

                            sidebar.file_selector:add_selected_file(relative_path)

                            -- remove neo tree buffer
                            if not open then
                                sidebar.file_selector:remove_selected_file('neo-tree filesystem [1]')
                            end
                        end,
                    },
                    window = {
                        mappings = {
                            ['oa'] = 'avante_add_files',
                        },
                    },
                },
            })
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        cmd = { 'Telescope' },
        keys = {
            { "<leader>p",  ":Telescope<cr>",            desc = "Open Telescope" },
            { "<leader>f",  group = "Find",              desc = "Find" },
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
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("ui-select")
        end,
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
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            views = {
                cmdline_popup = {
                    size = { width = "60%", height = "auto" },
                },
            },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
            "hrsh7th/nvim-cmp",
        },
    }
}
