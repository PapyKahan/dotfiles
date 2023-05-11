return {
    -- Note: Debugger
    {
        'mfussenegger/nvim-dap',
        event = "VeryLazy",
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'mfussenegger/nvim-dap-python',
            'mxsdev/nvim-dap-vscode-js',

        },
        config = function() require 'plugins.configs.dap' end,
    },
}
