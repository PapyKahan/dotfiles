local loaded, bufferline = pcall(require, 'bufferline')
if not loaded then
    return
end

bufferline.setup{
    options = {
        offsets = {
            { filetype = "NvimTree", text = "File Explorer" },
            { filetype = "Outline", text = "Outline" },
        }
    }
}
