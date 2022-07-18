local loaded, trouble = pcall(require, 'trouble')
if not loaded then
    return
end

local diagnostic_signs = require'usr.ui.icons'.diagnostic_signs

trouble.setup {
    signs = {
        error = diagnostic_signs.Error,
        warning = diagnostic_signs.Warn,
        hint = diagnostic_signs.Hint,
        information = diagnostic_signs.Info,
        other = diagnostic_signs.Other,
    },
}
