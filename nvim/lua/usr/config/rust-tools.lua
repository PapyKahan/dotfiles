local loaded, rust_tools = pcall(require, 'rust-tools')
if not loaded then
    return
end

rust_tools.setup({
    tools = {
        inlay_hints = {
            -- automatically set inlay hints (type hints)
            -- default: true
            auto = true,
        }

    }
})
