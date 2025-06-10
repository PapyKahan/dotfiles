return {
    ["IDEAL promblem solving"] = {
        strategy = "chat",
        description = "IDEAL problem-solving framework for developers",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                role = "system",
                content = "You are an experienced developer",
            },
            {
                role = "user",
                content = function(_)
                    return [[
Approach this problem using the IDEAL problem-solving framework:

1. Identify the problem precisely: ]]
                end,
            },
            {
                role = "user",
                content = function(_)
                    return [[
2. Define the constraints and requirements: ]]
                end,
            },
            {
                role = "user",
                content = function(_)
                    return [[
3. Explore potential strategies: Generate at least three different approaches
]]
                end,
            },
            {
                role = "user",
                content = function(_)
                    return [[
4. Act on the best strategy: Implement the solution with clean, documented code
]]
                end,
            },
            {
                role = "user",
                content = function(_)
                    return [[
5. Look back and learn: Evaluate the solution's efficiency, edge cases, and potential improvements

Problem to solve: ]]
                end,
            }
        },
    },
}
