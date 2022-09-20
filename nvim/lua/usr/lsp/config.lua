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
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
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

local function setup_installer()
    local mason_loaded, installer = pcall(require, 'mason')
    if not mason_loaded then
        return
    end
    local options = {
        ui = {
            border = "rounded"
        },
        automatic_installation = true,
        max_concurrent_installers = 10,
    }

    if vim.env['NEXTHINK'] then
        options.install_root_dir = vim.env['LSP_LANGUAGE_SERVERS']
    end

    installer.setup(options)
end


local function setup_lspconfig()
    lspconfig.util.default_config = vim.tbl_extend(
        "force",
        lspconfig.util.default_config,
        {
            on_attach = default_on_attach_callback,
            default_capabilities = default_capabilities
        }
    )

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

local function setup_installer_handlers()
    local mason_lspconfig_loaded, mason_lspconfig = pcall(require, 'mason-lspconfig')
    if not mason_lspconfig_loaded then
	    return
    end
    mason_lspconfig.setup_handlers({
        function (server_name)
            local config_loaded, server_config = pcall(require, "usr.lsp.configs."..server_name)
            if config_loaded then
                lspconfig[server_name].setup(server_config)
            else
                lspconfig[server_name].setup({})
            end
        end
    })
    mason_lspconfig.setup({ automatic_installation = true })
end

function M.setup()
    setup_installer()
    setup_lspconfig()
    setup_installer_handlers()
end

return M