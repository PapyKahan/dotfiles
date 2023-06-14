return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "c_sharp" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "Hoffs/omnisharp-extended-lsp.nvim" },
        opts = function(_, opts)
            opts.servers.omnisharp = {
                on_attach = function(client, bufnr)
                    -- There's on issue with Ominisharp and neovim 0.9.0's semantic highlighting
                    --client.server_capabilities.semanticTokensProvider = nil
                    -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
                    local function toSnakeCase(str)
                        return string.gsub(str, "%s*[- ]%s*", "_")
                    end

                    local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
                    for i, v in ipairs(tokenModifiers) do
                        tokenModifiers[i] = toSnakeCase(v)
                    end
                    local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
                    for i, v in ipairs(tokenTypes) do
                        tokenTypes[i] = toSnakeCase(v)
                    end
                    require 'base.lsp.config'.default_on_attach_callback(client, bufnr)
                end,
                cmd = { "omnisharp.cmd" },
                enable_roslyn_analyzers = true,
                enable_import_completion = true,
                handlers = {
                    ["textDocument/definition"] = require 'omnisharp_extended'.handler,
                },
            }
        end,
    },
}
