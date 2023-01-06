local loaded, copilot = pcall(require, 'copilot')
if not loaded then
    return
end

copilot.setup()

if vim.env['NEXTHINK'] then
    vim.g.copilot_proxy = vim.env['HTTPS_PROXY']
    vim.g.copilot_proxy_strict_ssl = "false"
end
