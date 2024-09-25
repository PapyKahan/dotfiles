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
            local mason_registry = require "mason-registry"
            local powershell_es = mason_registry.get_package "powershell-editor-services"
            if not powershell_es then
                return
            end
            local powershell_es_path = powershell_es:get_install_path()
            opts.servers.powershell_es = {
                bundle_path = powershell_es_path
                --cmd = { 'pwsh', '-NoLogo', '-NoProfile', powershell_es_path .. "\\PowerShellEditorServices\\Start-EditorServices.ps1"},
            }
            vim.print "setup"
        end,
    }
}

