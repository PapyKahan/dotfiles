return {
    {
        "folke/which-key.nvim",
        lazy = false,
        opts = {
            defaults = {
                ['<leader>d'] = { name = 'Debugger' },
            },
        },
        config = function(_, opts)
            require('which-key').register(opts.defaults)
        end
    },
    -- Note: Debugger
    {
        'mfussenegger/nvim-dap',
        --event = "VeryLazy",
        dependencies = {
            { 'rcarriga/nvim-dap-ui' },
            { 'theHamsta/nvim-dap-virtual-text' },
            --'mfussenegger/nvim-dap-python',
            --'mxsdev/nvim-dap-vscode-js',

        },
        keys = {
            { "<leader>db", function() require('dap').toggle_breakpoint() end,                                           desc =
            "Toggle breakpoint" },
            { "<leader>dB", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
                                                                                                                             desc =
                "Toggle conditional breakpoint" },
            { "<leader>dl", function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
                                                                                                                             desc =
                "Toggle logging breakpoint" },
            { "<leader>dx", function() require('dap').clear_breakpoints() end,                                           desc =
            "Clear all breakpoints" },
            { "<leader>dr", function() require('dap').repl.toggle() end,                                                 desc =
            "Open debug console" },
            { "<leader>dd", function() require('dap').run_last() end,                                                    desc =
            "Run last session" },
            { "<leader>dc", function() require('dap').continue() end,                                                    desc =
            "Continue" },
            { "<leader>do", function() require('dap').step_over({}) end,                                                 desc =
            "Step over" },
            { "<leader>di", function() require('dap').step_into() end,                                                   desc =
            "Step into" },
            { "<leader>du", function() require('dap').step_out() end,                                                    desc =
            "Step out" },
            { "<leader>ds", function() require('dap').continue() end,                                                    desc =
            "Start" },
            { "<leader>dq", function() require('dap').close() end,                                                       desc =
            "Quit" },
            { "<leader>de", function() require('dapui').eval() end,                                                      mode = {
                'n', 'v' },                                                                                                                                     desc =
            "Evaluate expression" },
        },
        config = function(plugin, opts)
            local ui = {
                breakpoint = {
                    text = "",
                    texthl = "DiagnosticSignError",
                    linehl = "",
                    numhl = "",
                },
                breakpoint_condition = {
                    text = "",
                    texthl = "DiagnosticSignWarn",
                    linehl = "",
                    numhl = "",
                },
                log_point = {
                    text = "",
                    texthl = "DiagnosticSignInfo",
                    linehl = "",
                    numhl = "",
                },
                breakpoint_rejected = {
                    text = "",
                    texthl = "DiagnosticSignHint",
                    linehl = "",
                    numhl = "",
                },
                stopped = {
                    text = "",
                    texthl = "DiagnosticsSignInfo",
                    linehl = "DiagnosticUnderlineInfo",
                    numhl = "DiagnosticSignInfo",
                },
            }

            -- Define debug signs
            vim.fn.sign_define("DapBreakpoint", ui.breakpoint)
            vim.fn.sign_define('DapBreakpointCondition', ui.breakpoint_condition)
            vim.fn.sign_define('DapLogPoint', ui.log_point)
            vim.fn.sign_define('DapStopped', ui.stopped)
            vim.fn.sign_define('DapBreakpointRejected', ui.breakpoint_rejected)

            -- Dap log level

            local dap, dapui = require('dap'), require('dapui')
            dap.set_log_level('ERROR')
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end

            -- Load language specific configs
            local files = vim.api.nvim_get_runtime_file("lua/base/dap/configs/*.lua", true)
            for _, file in pairs(files) do
                local dap_config_file = file:match("^.*[/|\\](.*).lua$")
                if dap_config_file then
                    require('base.dap.configs.' .. dap_config_file)
                end
            end

            for k, _ in pairs(opts.setup) do
                opts.setup[k](plugin, opts)
            end
        end
    },
}
