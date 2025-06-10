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
                content = "You are an experienced developer using the IDEAL problem-solving framework. " ..
                         "You will gather information from the user step by step, and then provide a solution based on the information. " ..
                         "Do not provide a solution or any code until you have all the information you need."
            },
            {
                role = "user",
                content = function(_)
                    return [[
Approach this problem using the IDEAL problem-solving framework:

The problem: ]]
                end,
            },
        },
    },
}
