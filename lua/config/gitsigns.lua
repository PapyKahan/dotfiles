local loaded, gitsigns = pcall(require, 'gitsigns')
if not loaded then
    return
end
gitsigns.setup {}
