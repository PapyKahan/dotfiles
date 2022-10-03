local loaded, treesitter_config = pcall(require, 'nvim-treesitter.configs')
if not loaded then
    return
end

treesitter_config.setup {
    autotag = {
        enable = true
    },
    highlight = {
        enable = true
    }
}
