local lsp_installer_loaded, installer = pcall(require, 'nvim-lsp-installer')
if not lsp_installer_loaded then
    return
end

local options = {
   automatic_installation = true,
   ui = {
      icons = {
         server_installed = " ",
         server_pending = " ",
         server_uninstalled = " ﮊ",
      },
      keymaps = {
         toggle_server_expand = "<CR>",
         install_server = "i",
         update_server = "u",
         check_server_version = "c",
         update_all_servers = "U",
         check_outdated_servers = "C",
         uninstall_server = "X",
      },
   },

   max_concurrent_installers = 10,
}

if vim.env['NEXTHINK'] then
    options.install_root_dir = vim.env['LSP_LANGUAGE_SERVERS']
end


installer.setup(options)

