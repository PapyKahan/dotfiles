local loaded, dressing = pcall(require, 'dressing')
if not loaded then
    return
end

dressing.setup {}
