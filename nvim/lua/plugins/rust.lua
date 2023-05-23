return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            defaults = {
                ['<leader>c'] = { name = '+Crates' },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.register(opts.defaults)
        end
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = {
            'nvim-dap',
            'which-key.nvim',
        },
        config = function() require 'plugins.configs.rust-tools' end
    },

    {
        'saecki/crates.nvim',
        event = 'BufRead Cargo.toml',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            popup = {
                style = "minimal",
                border = "rounded",
            },
        },
        keys = {
            { "<leader>ct", function() require('crates').toggle() end,                  desc = "Toggle" },
            { "<leader>cr", function() require('crates').reload() end,                  desc = "Reload" },
            --
            -- nnoremap <silent> <leader>cv :lua require('crates').show_versions_popup()<cr>
            { "<leader>cv", function() require('crates').show_versions_popup() end,     desc = "Show versions" },
            -- nnoremap <silent> <leader>cf :lua require('crates').show_features_popup()<cr>
            { "<leader>cf", function() require('crates').show_features_popup() end,     desc = "Show features" },
            -- nnoremap <silent> <leader>cd :lua require('crates').show_dependencies_popup()<cr>
            { "<leader>cd", function() require('crates').show_dependencies_popup() end, desc = "Show dependencies" },
            --
            -- nnoremap <silent> <leader>cu :lua require('crates').update_crate()<cr>
            { "<leader>cu", function() require('crates').update_crate() end,            desc = "Update crate" },
            -- vnoremap <silent> <leader>cu :lua require('crates').update_crates()<cr>
            { "<leader>cu", function() require('crates').update_crate() end,            desc = "Update crates" },
            -- nnoremap <silent> <leader>ca :lua require('crates').update_all_crates()<cr>
            { "<leader>ca", function() require('crates').update_all_crates() end,       desc = "Update all crates" },
            -- nnoremap <silent> <leader>cU :lua require('crates').upgrade_crate()<cr>
            { "<leader>cU", function() require('crates').upgrade_crate() end,           desc = "Upgrade crate" },
            -- vnoremap <silent> <leader>cU :lua require('crates').upgrade_crates()<cr>
            { "<leader>cU", function() require('crates').upgrade_crates() end,          desc = "Upgrade crates" },
            -- nnoremap <silent> <leader>cA :lua require('crates').upgrade_all_crates()<cr>
            { "<leader>cA", function() require('crates').upgrade_all_crates() end,      desc = "Upgrade all crates" },

            -- nnoremap <silent> <leader>cH :lua require('crates').open_homepage()<cr>
            { "<leader>cH", function() require('crates').open_homepage() end,           desc = "Open homepage" },
            -- nnoremap <silent> <leader>cR :lua require('crates').open_repository()<cr>
            { "<leader>cR", function() require('crates').open_repository() end,         desc = "Open repository" },
            -- nnoremap <silent> <leader>cD :lua require('crates').open_documentation()<cr>
            { "<leader>cD", function() require('crates').open_documentation() end,      desc = "Open documentation" },
            -- nnoremap <silent> <leader>cC :lua require('crates').open_crates_io()<cr>
            { "<leader>cC", function() require('crates').open_crates_io() end,          desc = "Open Crates.io" },
        }
    },
}
