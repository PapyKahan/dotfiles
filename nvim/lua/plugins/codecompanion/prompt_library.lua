local workflows = require("plugins/codecompanion.workflows")
local prompts = require("plugins/codecompanion.prompts")
return vim.tbl_deep_extend("keep", prompts, workflows)
