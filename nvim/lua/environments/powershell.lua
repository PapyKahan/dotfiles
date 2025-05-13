return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "powershell" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            local registry = require "mason-registry"
            if registry.is_installed('powershell-editor-services') then
                local powershell_es_path = vim.fn.exepath("powershell-editor-services")
                opts.servers.powershell_es = {
                    bundle_path = powershell_es_path
                    --cmd = { 'pwsh', '-NoLogo', '-NoProfile', powershell_es_path .. "\\PowerShellEditorServices\\Start-EditorServices.ps1"},
                }
            end
        end,
    }
}
