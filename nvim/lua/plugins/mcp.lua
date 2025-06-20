return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- tag = "v4.8.0",
    -- comment the following line to ensure hub will be ready at the earliest
    cmd = "MCPHub", -- lazy load by default
    -- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    build = "bundled_build.lua",   -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    opts = {
        use_bundled_binary = true, -- Set to true if you want to use the bundled binary instead of the global one
        auto_approve = true,
        extensions = {
            avante = {
                make_slash_commands = true, -- make /slash commands from MCP server prompts
            }
        }
    },
    config = function(_, opts)
        require("mcphub").setup(opts)
    end,
}
