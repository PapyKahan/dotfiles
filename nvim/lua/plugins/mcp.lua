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
        -- Set global environment variables for MCPHub and all MCP servers
        global_env = {
            HTTP_PROXY = os.getenv("HTTP_PROXY") or os.getenv("http_proxy"),
            HTTPS_PROXY = os.getenv("HTTPS_PROXY") or os.getenv("https_proxy"),
            http_proxy = os.getenv("HTTP_PROXY") or os.getenv("http_proxy"),
            https_proxy = os.getenv("HTTPS_PROXY") or os.getenv("https_proxy"),
            PATH = os.getenv("PATH") or os.getenv("Path"),
            Path = os.getenv("PATH") or os.getenv("Path"),
            UV_NATIVE_TLS = os.getenv("UV_NATIVE_TLS")
        },
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
