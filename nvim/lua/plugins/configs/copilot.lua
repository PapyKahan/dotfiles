if vim.env['COPILOT_PROXY'] then
    vim.g.copilot_proxy = vim.env['COPILOT_PROXY']
    vim.g.copilot_proxy_strict_ssl = false
end

vim.g.copilot_no_tab_map = true

--local loaded, whichkey = pcall(require, 'which-key')
--if not loaded then
--    return
--end

--whichkey.register({
--    ['<M-i>'] = { 'copilot#Accept("\\<CR>")', 'Accept' },
--    ['<M-j>'] = { 'copilot#Next()', 'Next' },
--    ['<M-k>'] = { 'copilot#Previous()', 'Prev' },
--}, {
--    mode = 'i',
--    silent = true,
--    expr = true,
--})

local loaded_copilot, copilot = pcall(require, 'copilot')
if not loaded_copilot then
    return
end

copilot.setup({
  panel = { enabled = false, },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-i>",
      accept_word = false,
      accept_line = false,
      next = "<M-j>",
      prev = "<M-k>",
      dismiss = "<M-l>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
})
