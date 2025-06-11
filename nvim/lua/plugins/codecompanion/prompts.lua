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
                    "Steps are :" ..
                    "1. Identify the problem" ..
                    "2. Define the goals" ..
                    "3. Explore possible strategies" ..
                    "4. Act on the best strategy" ..
                    "5. Look back and evaluate",
                "Do not provide a solution or any code until you have all the information you need." ..
                "Ask the user for more information if needed.",
            },
            {
                role = "user",
                content = function(_)
                    return "The problem:"
                end,
            },
        },
    },
    ["Iterative Refinement Through Targeted Feedback"] = {
        strategy = "chat",
        description = "Iterative Refinement Through Targeted Feedback",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                role = "system",
                content = [[
You are an experienced developer

I'll evaluate your solution based on these specific criteria:
1. Performance: Does it scale efficiently with large data sets?
2. Maintainability: Is the code well-structured and documented?
3. Error handling: Does it gracefully handle edge cases?
4. Security: Are there any potential vulnerabilities?
5. Test coverage: Can this solution be thoroughly tested?

For any areas that don't meet expectations,
I'll provide specific feedback for improvement.
                ]]
            },
            {
                role = "user",
                content = function(_)
                    return "Initial task:"
                end,
            },
        },
    },
    ["Progressive API Design"] = {
        strategy = "chat",
        description = "Progressive API Design",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                role = "user",
                content = [[
I'm designing a RESTful API for a [SPECIFIC DOMAIN] system.
Let's develop this progressively:

STAGE 1: Core resource definition
- Define the essential resources and their relationships
- Specify primary attributes for each resource
- Outline basic CRUD operations

STAGE 2: Interaction patterns
- Define specialized endpoints beyond CRUD
- Specify query parameters and filtering capabilities
- Design pagination and sorting approaches

STAGE 3: Advanced considerations
- Authentication and authorization patterns
- Rate limiting and quota strategies
- Caching directives and ETag implementation
- Versioning approach
- Error handling standardization

STAGE 4: Documentation and examples
- Generate OpenAPI specifications
- Provide example requests/responses for common operations
- Document best practices for API consumers

Let's start with Stage 1: [YOUR SPECIFIC API DOMAIN DETAILS]
                ]]
            },
        },
    },
    ["Advanced Debugging Strategy"] = {
        strategy = "chat",
        description = "Advanced Debugging Strategy",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                role = "user",
                content = [[
I'm debugging an issue with the following characteristics:

SYMPTOMS:
- [Describe the observable problem in detail]
- Occurs approximately [FREQUENCY] under [SPECIFIC CONDITIONS]
- Started after [RELEVENT CHANGE OR TIMELINE]

ENVIRONMENT:
- [Relevant technologies, versions, platforms]
- [Configuration details that might be relevant]

INVESTIGATION SO FAR:
- [Steps already taken]
- [Evidence collected]
- [Theories explored and ruled out]

ERROR LOGS:
[Include relevant logs here]

RELEVANT CODE:
[Include suspicious code sections]

Help me by:
1. Suggesting the most likely root causes based on this information
2. Proposing specific diagnostic steps to confirm each hypothesis
3. Recommending targeted fixes once the cause is identified
                ]]
            },
        },
    },
    ["Architectural Decision Framework"] = {
        strategy = "chat",
        description = "Architectural Decision Framework",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                role = "user",
                content = [[
I need to evaluate architectural approaches for [SPECIFIC SYSTEM COMPONENT].

For each of the following options, provide a comprehensive analysis:

OPTION 1: [Architectural approach A]
OPTION 2: [Architectural approach B]
OPTION 3: [Architectural approach C]

For each option, analyze:
1. Performance characteristics under our expected load of [SPECIFIC METRICS]
2. Development complexity and timeline implications
3. Operational considerations (monitoring, debugging, deployment)
4. Scalability limitations and growth potential
5. Security implications
6. Cost factors (development, infrastructure, maintenance)

Conclude with a recommendation based on our priority of [SPECIFIC PRIORITIES].
                ]]
            },
        },
    },
    ["Documentation Generation Framework"] = {
        strategy = "chat",
        description = "Documentation Generation Framework",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                role = "user",
                content = [[
Generate comprehensive developer documentation for this [FUNCTION/COMPONENT/MODULE]:

[YOUR CODE]

Structure the documentation as follows:

1. OVERVIEW
   - Purpose and primary functionality
   - When to use this component vs. alternatives
   - Architectural context (where it fits in the larger system)

2. TECHNICAL SPECIFICATION
   - API reference with all methods/properties
   - Parameters, return values, and types
   - State management (if applicable)
   - Events emitted/listened for

3. IMPLEMENTATION EXAMPLES
   - Basic usage example
   - Advanced configuration example
   - Customization scenarios
   - Common patterns and best practices

4. TROUBLESHOOTING
   - Common errors and their solutions
   - Debugging strategies
   - Performance considerations

5. RELATED COMPONENTS
   - Dependencies
   - Components commonly used alongside this one
   - Alternative approaches

Format using markdown with proper headings, code blocks, tables, and emphasis where appropriate.
                ]]
            },
        },
    },
    ["Test Suite Generator"] = {
        strategy = "chat",
        description = "Test Suite Generator",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                role = "user",
                content = [[
I need to create a comprehensive test suite for this function:

[FUNCTION CODE]

Please generate tests organized into these categories:

1. FUNCTIONAL CORRECTNESS
   - Happy path tests with various valid inputs
   - Edge case handling (empty inputs, boundary values, etc.)
   - Expected error conditions and error handling

2. PERFORMANCE CHARACTERISTICS
   - Tests verifying performance under expected loads
   - Tests for memory usage patterns
   - Time complexity verification for key operations

3. INTEGRATION POINTS
   - Tests for interactions with external dependencies
   - Mocking strategies for isolating the function
   - Testing side effects on the system

4. SECURITY CONSIDERATIONS
   - Input validation and sanitization tests
   - Authorization bypass attempts
   - Potential injection vectors

Use [Jest/Mocha/YOUR TESTING FRAMEWORK] syntax and follow AAA (Arrange-Act-Assert) pattern.
Include setup and teardown where appropriate.
                ]]
            },
        },
    },
    ["Multi-Persona Code Review"] = {
        strategy = "chat",
        description = "Multi-Persona Code Review",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                role = "user",
                content = [[
Please review this code from three different perspectives:

1. As a security specialist:
Identify potential vulnerabilities, injection risks, or authentication issues

2. As a performance engineer:
Highlight inefficient patterns, memory leaks, or bottlenecks

3. As a maintainability expert:
Point out unclear naming, complex logic, or architectural concerns

CODE:
[YOUR CODE HERE]

For each role, provide specific feedback and suggested improvements.
                ]]
            },
        },
    },
    ["Dependency Evaluation Analyzer"] = {
        strategy = "chat",
        description = "Dependency Evaluation Analyzer",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                role = "user",
                content = [[
I'm evaluating [LIBRARY/FRAMEWORK] for use in our [SPECIFIC USE CASE].
Provide a comprehensive analysis including:

FUNCTIONALITY ASSESSMENT
- Feature completeness for our requirements: [LIST KEY REQUIREMENTS]
- API design quality and developer experience
- Customization and extension capabilities

TECHNICAL EVALUATION
- Performance benchmarks and optimization opportunities
- Bundle size and loading impact
- Browser/environment compatibility
- TypeScript/type definition quality

COMMUNITY AND SUPPORT
- Maintenance activity (commits, issue response time)
- Community size and engagement
- Documentation quality and examples
- Commercial support options

INTEGRATION ASSESSMENT
- Compatibility with our existing stack: [list technologies]
- Migration path from our current solution
- Lock-in concerns and exit strategies

ALTERNATIVES COMPARISON
- How it compares to [alternative A], [alternative B] in key areas
- Unique advantages and disadvantages

Based on this analysis, provide a recommendation with specific justification.
                ]]
            },
        },
    },
    ["AI-Powered Development Workflows"] = {
        strategy = "chat",
        description = "AI-Powered Development Workflows",
        opts = {
            user_prompt = true,
        },
        prompts = {
            {
                role = "user",
                content = [[
I want to establish an AI-assisted workflow for [SPECIFIC DEVELOPMENT TASK].

Please design a comprehensive workflow that:

1. BREAKS DOWN THE TASK
   - Identify distinct components and their relationships
   - Suggest a logical development sequence
   - Define clear milestones and deliverables

2. DEFINES PROMPT TEMPLATES
   - For initial code generation
   - For code review and improvement
   - For documentation generation
   - For test case development

3. ESTABLISHES QUALITY GATES
   - Criteria for evaluating generated code
   - Feedback loops for iterative improvement
   - Integration with existing quality processes

4. PROVIDES CONTEXTUAL FRAMEWORKS
   - Project-specific knowledge to include in prompts
   - Standards and conventions to enforce
   - Reference examples to guide AI outputs

The workflow should be reusable for similar tasks and optimize for both
efficiency and quality.
                ]]
            },
        },
    }
}
