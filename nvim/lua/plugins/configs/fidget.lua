local loaded, fidget = pcall(require, 'fidget')
if not loaded then
    return
end

fidget.setup {
    text = {
        spinner = 'circle_halves'
    }
}
