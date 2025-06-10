return {
    ["IDEAL promblem solving - workflow"] = {
        strategy = "workflow",
        description = "IDEAL problem-solving framework for developers",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                {
                    role = "system",
                    content =  [[
You are an experienced developer gather information of each steap in the IDEAL problem-solving framework.
You will gather information from the user step by step, and then provide a solution based on the information.
don't provide a solution or any code until you have all the information you need.]],
                },
                {
                    role = "user",
                    opts = {
                        auto_submit = false,
                    },
                    content = function(_)
                        return [[
Approach this problem using the IDEAL problem-solving framework:

1. Identify the problem precisely: ]]
                    end,
                },
            },
            {
                {
                    role = "user",
                    opts = {
                        auto_submit = false,
                    },
                    content = function(_)
                        return [[
2. Define the constraints and requirements: ]]
                    end,
                }
            },
            {
                {
                    role = "user",
                    opts = {
                        auto_submit = false,
                    },
                    content = function(_)
                        return [[
3. Explore potential strategies: Generate at least three different approaches
]]
                    end,
                }
            },
            {
                {
                    role = "user",
                    opts = {
                        auto_submit = false,
                    },
                    content = function(_)
                        return [[
4. Act on the best strategy: Implement the solution with clean, documented code
]]
                    end,
                }
            },
            {
                {
                    role = "user",
                    opts = {
                        auto_submit = false,
                    },
                    content = function(_)
                        return [[
5. Look back and learn: Evaluate the solution's efficiency, edge cases, and potential improvements

Problem to solve: ]]
                    end,
                }
            }
        },
    },
    ["Test Workflow"] = {
        strategy = "workflow",
        description = "test",
        opts = {
            short_name = "ct",
        },
        prompts = {
            {
                -- We can group prompts together to make a workflow
                -- This is the first prompt in the workflow
                -- Everything in this group is added to the chat buffer in one batch
                {
                    role = "system",
                    content = function(context)
                        return string.format(
                            "You carefully provide accurate, factual, thoughtful, nuanced answers, and are brilliant at reasoning. If you think there might not be a correct answer, you say so. Always spend a few sentences explaining background context, assumptions, and step-by-step thinking BEFORE you try to answer a question. Don't be verbose in your answers, but do provide details and examples where it might help the explanation. You are an expert software engineer for the %s language",
                            context.filetype
                        )
                    end,
                    opts = {
                        visible = false,
                    },
                },
                {
                    role = "user",
                    content = "I want you to ",
                    opts = {
                        auto_submit = false,
                    },
                },
            },
            -- This is the second group of prompts
            {
                {
                    role = "user",
                    content =
                    "Great. Now let's consider your code. I'd like you to check it carefully for correctness, style, and efficiency, and give constructive criticism for how to improve it.",
                    opts = {
                        auto_submit = false,
                    },
                },
            },
            -- This is the final group of prompts
            {
                {
                    role = "user",
                    content = "Thanks. Now let's revise the code based on the feedback, without additional explanations.",
                    opts = {
                        auto_submit = false,
                    },
                },
            },
        },
    },
}
