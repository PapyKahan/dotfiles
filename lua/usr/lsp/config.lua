local loaded, lspconfig = pcall(require, "lspconfig")
if not loaded then
   return
end

local M = {}

local function default_capabilities()
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

local function default_on_attach_callback(client, bufnr)
    setup_codelens_refresh(client, bufnr)
    setup_document_highlight(client, bufnr)
    require'usr.lsp.mappings'.setup_buffer_mappings(bufnr)
end

function M.setup()
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

    lspconfig.util.default_config = vim.tbl_extend(
        "force",
        lspconfig.util.default_config,
        {
            on_attach = default_on_attach_callback,
            default_capabilities = default_capabilities
        }
    )

    for _, server in pairs(installer.get_installed_servers()) do
        local config_loaded, server_config = pcall(require, "usr.lsp.configs."..server.name)
        if config_loaded then
            lspconfig[server.name].setup(server_config)
        else
            lspconfig[server.name].setup({})
        end
    end

    local win = require "lspconfig.ui.windows"
    local _default_opts = win.default_opts

    win.default_opts = function(default_opts)
        local opts = _default_opts(default_opts)
        opts.focusable = false
        opts.style = "minimal"
        opts.border = "rounded"
        return opts
    end
end

return M
