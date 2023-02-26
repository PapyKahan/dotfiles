if vim.env['NEXTHINK'] then
    vim.g.copilot_proxy = vim.env['HTTPS_PROXY']
    vim.g.copilot_proxy_strict_ssl = false
end

vim.g.copilot_no_tab_map = true

local loaded, whichkey = pcall(require, 'which-key')
if not loaded then
    return
end

whichkey.register({
    ['<M-i>'] = { 'copilot#Accept("\\<CR>")', 'Accept' },
    ['<M-j>'] = { 'copilot#Next()', 'Next' },
    ['<M-k>'] = { 'copilot#Previous()', 'Prev' },
}, {
    mode = 'i',
    silent = true,
    expr = true,
})


local loaded, copilot = pcall(require, 'copilot')
if not loaded then
    return
end

copilot.setup()
