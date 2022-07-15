local M = {}
local mappings = require 'usr.lsp.mappings'

function M.default_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
            properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
            },
        },
    }
    local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
    if cmp_ok then
        capabilities = cmp.update_capabilities(capabilities)
    end
end

local function setup_codelens_refresh(client, bufnr)
    local status_ok, codelens_supported = pcall(function()
        return client.supports_method "textDocument/codeLens"
    end)
    if not status_ok or not codelens_supported then
        return
    end
    local augroup_exist, _ = pcall(vim.api.nvim_get_autocmds, {
        group = "lsp_code_lens_refresh",
    })
    if not augroup_exist then
        vim.api.nvim_create_augroup("lsp_code_lens_refresh", {})
    end
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
        group = "lsp_code_lens_refresh",
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
    })
end

local function setup_document_highlight(client, bufnr)
    local status_ok, highlight_supported = pcall(function()
        return client.supports_method "textDocument/documentHighlight"
    end)
    if not status_ok or not highlight_supported then
        return
    end
    local augroup_exist, _ = pcall(vim.api.nvim_get_autocmds, {
        group = "lsp_document_highlight",
    })
    if not augroup_exist then
        vim.api.nvim_create_augroup("lsp_document_highlight", {})
    end
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

function M.default_on_attach_callback(client, bufnr)
    setup_codelens_refresh(client, bufnr)
    setup_document_highlight(client, bufnr)
    mappings.setup_buffer_mappings(bufnr)
end


function M.setup()
    mappings.setup_global_mappings()
    require'usr.lsp.handlers'.setup()
    require'usr.lsp.diagnostic'.setup()
    require'usr.lsp.config'.setup({'sumneko_lua', 'pyright'})

    -- suppress error messages from lang servers
    vim.notify = function(msg, log_level)
        if msg:match "exit code" then
            return
        end
        if log_level == vim.log.levels.ERROR then
            vim.api.nvim_err_writeln(msg)
        else
            vim.api.nvim_echo({ { msg } }, true, {})
        end
    end
end

return M
