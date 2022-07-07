local M = {}

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

local whichkey_loaded, whichkey = pcall(require, 'which-key')
if not whichkey_loaded then
    return
end

local function setup_mappings(client, bufnr)

    whichkey.register({
        gD = { function () vim.lsp.buf.declaration() end, "Go to declaration" },
        gd = { function() vim.lsp.buf.definition() end, "Go to definition" },
        K = { function() vim.lsp.buf.hover() end, "Show documentation" },
        gi = { function() vim.lsp.buf.implementation() end, "Go to implementation" },
        gS = { function() vim.lsp.buf.signature_help() end, "Get signature" },
        gr = { function() vim.lsp.buf.references() end, "Get all references" },
    }, {
        noremap = true,
        silent = true,
        buffer = bufnr
    })

    whichkey.register({
        D = { function() vim.lsp.buf.type_definition() end, "Go to type definition" },
        rn = { function() vim.lsp.buf.rename() end, "Rename" },
        ca = { function () vim.lsp.buf.code_action() end, "Code action" },
        f = { function() vim.lsp.buf.format() end, "Format" },
    }, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        prefix = '<leader>'
    })
end

function M.default_on_attach_callback(client, bufnr)
    setup_codelens_refresh(client, bufnr)
    setup_document_highlight(client, bufnr)
    setup_mappings(client, bufnr)
end

local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

function M.setup()
    lspSymbol("Error", "")
    lspSymbol("Info", "")
    lspSymbol("Hint", "")
    lspSymbol("Warn", "")

    -- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
    whichkey.register({
        e = { function() vim.diagnostic.open_float() end, "Show diagnostics" },
        q = { function() vim.diagnostic.setloclist() end, "Show local list" },

    }, {
        noremap = true,
        silent = true,
        prefix = '<leader>',
    })

    whichkey.register({
        ["[d"] = { function() vim.diagnostic.goto_prev() end, "Goto previous diagnostic" },
        ["]d"] = { function() vim.diagnostic.goto_next() end, "Goto next diagnostic" },

    }, {
        noremap = true,
        silent = true,
    })

    vim.diagnostic.config {
        virtual_text = {
            prefix = "",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
            format = function(d)
                local t = vim.deepcopy(d)
                local code = d.code or (d.user_data and d.user_data.lsp.code)
                if code then
                    t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
                end
                return t.message
            end,
        }
    }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        focusable = true,
        style = "minimal",
        border = "rounded",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        focusable = true,
        style = "minimal",
        border = "rounded",
    })

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
