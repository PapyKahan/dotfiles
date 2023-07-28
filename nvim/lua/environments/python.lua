return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "python" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                autoImportCompletions = true,
                                typeCheckingMode = "off",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = "workspace", -- "openFilesOnly",
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = "python",
        config = function()
            local dap_python = require("dap-python")
            if vim.env['NEXTHINK'] then
                dap_python.setup('C:/ieu/tools/WPy64-31101/python-3.11.0.amd64/python.exe')
            else
                dap_python.setup()
            end
        end,
    }
}
