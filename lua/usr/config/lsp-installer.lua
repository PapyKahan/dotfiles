local lsp_installer_loaded, installer = pcall(require, 'nvim-lsp-installer')
if not lsp_installer_loaded then
    return
end

local options = {
   automatic_installation = true,
   max_concurrent_installers = 10,
}

if vim.env['NEXTHINK'] then
    options.install_root_dir = vim.env['LSP_LANGUAGE_SERVERS']
end

installer.setup(options)
