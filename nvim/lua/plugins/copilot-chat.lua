return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = "VeryLazy",
        enabled = false,
        dependencies = {
            "zbirenbaum/copilot.lua",
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "ravitemer/mcphub.nvim",
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>cc", "<cmd>CopilotChatToggle<cr>",  desc = "Copilot Chat" },
            { "<leader>cm", "<cmd>CopilotChatModels<cr>",  desc = "Copilot Chat Models" },
            { "<leader>cp", "<cmd>CopilotChatPrompts<cr>", desc = "Copilot Chat Prompts" },
        },
        opts = {
            model = 'claude-sonnet-4',
            -- See Configuration section for options
            mappings = {
                reset = {
                    normal = '<C-l>',
                    insert = '<C-l>',
                },
            },
            -- default window options
            window = {
                layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace', or a function that returns the layout
                width = 0.3,         -- fractional width of parent, or absolute width in columns when > 1
            },
        },
        -- See Commands section for default commands if you want to lazy load on them
        config = function(_, opts)
            -- Integrates mcphub with CopilotChat, dynamically registering tools and resources as CopilotChat functions.
            -- Listens for mcphub events to update available tools/resources in CopilotChat.
            local chat = require('CopilotChat')
            chat.setup(opts)
            local mcp = require('mcphub')
            -- Register event handler for mcphub updates.
            mcp.on({ 'servers_updated', 'tool_list_changed', 'resource_list_changed' }, function()
                local hub = mcp.get_hub_instance()
                if not hub then
                    return
                end

                -- Import plenary async utilities.
                local async = require('plenary.async')

                -- Wraps hub:call_tool in an async function for CopilotChat tool invocation.
                -- @param server string: Server name
                -- @param tool string: Tool name
                -- @param input table: Tool input
                -- @param callback function: Callback to receive result and error
                local call_tool = async.wrap(function(server, tool, input, callback)
                    hub:call_tool(server, tool, input, {
                        callback = function(res, err)
                            callback(res, err)
                        end,
                    })
                end, 4)

                -- Wraps hub:access_resource in an async function for CopilotChat resource access.
                -- @param server string: Server name
                -- @param uri string: Resource URI
                -- @param callback function: Callback to receive result and error
                local access_resource = async.wrap(function(server, uri, callback)
                    hub:access_resource(server, uri, {
                        callback = function(res, err)
                            callback(res, err)
                        end,
                    })
                end, 3)

                -- Register resources as CopilotChat functions.
                local resources = hub:get_resources()
                for _, resource in ipairs(resources) do
                    local name = resource.name:lower():gsub(' ', '_'):gsub(':', '')
                    if not chat.config.functions then
                        chat.config.functions = {}
                    end
                    chat.config.functions[name] = {
                        uri = resource.uri,
                        description = type(resource.description) == 'string' and resource.description or '',
                        -- Resolves the resource and returns its content for CopilotChat.
                        resolve = function()
                            local res, err = access_resource(resource.server_name, resource.uri)
                            if err then
                                error(err)
                            end

                            res = res or {}
                            local result = res.result or {}
                            local content = result.contents or {}
                            local out = {}

                            for _, message in ipairs(content) do
                                if message.text then
                                    table.insert(out, {
                                        uri = message.uri,
                                        data = message.text,
                                        mimetype = message.mimeType,
                                    })
                                end
                            end

                            return out
                        end
                    }
                end

                -- Register tools as CopilotChat functions.
                local tools = hub:get_tools()
                for _, tool in ipairs(tools) do
                    chat.config.functions[tool.name] = {
                        group = tool.server_name,
                        description = tool.description,
                        schema = tool.inputSchema,
                        -- Resolves the tool invocation and returns its output for CopilotChat.
                        -- @param input table: Tool input
                        resolve = function(input)
                            local res, err = call_tool(tool.server_name, tool.name, input)
                            if err then
                                error(err)
                            end

                            res = res or {}
                            local result = res.result or {}
                            local content = result.content or {}
                            local out = {}

                            for _, message in ipairs(content) do
                                if message.type == 'text' then
                                    table.insert(out, {
                                        data = message.text
                                    })
                                elseif message.type == 'resource' and message.resource and message.resource.text then
                                    table.insert(out, {
                                        uri = message.resource.uri,
                                        data = message.resource.text,
                                        mimetype = message.resource.mimeType,
                                    })
                                end
                            end

                            return out
                        end
                    }
                end
            end)
        end,
    },
}
