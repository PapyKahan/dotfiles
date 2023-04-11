local loaded, telescope = pcall(require, 'telescope')
if not loaded then
    return
end

local previewers = require "telescope.previewers"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        file_previewer = previewers.file_previewer,
        grep_previewer = previewers.grep_previewer,
        qflist_previewer = previewers.qflist_previewer,
        file_sorter = sorters.file_sorter,
        generic_sorter = sorters.get_generic_fuzzy_sorter,

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
        ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
        mappings = {
            i = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<C-j>"] = actions.cycle_history_next,
                ["<C-k>"] = actions.cycle_history_prev,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<CR>"] = actions.select_default + actions.center,
            },
            n = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
        },
    },
}
