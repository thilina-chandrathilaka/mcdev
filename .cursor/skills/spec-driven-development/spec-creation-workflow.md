# Spec Creation Workflow - AI Agent Instructions

## Overview

This skill provides complete instructions for AI agents to create feature specifications following the requirements-first methodology. The workflow transforms rough feature ideas into detailed, actionable implementation plans through three phases: Requirements → Design → Tasks.

**Note for AI Agents**: This methodology is agent-agnostic. Replace `.kiro/` with your agent's configuration directory:
- Cursor → `.cursor/`
- Claude → `.claude/`
- Aider → `.aider/`
- Other agents → Use your system's config directory

## Core Principles

1. **User as Ground Truth**: Always get user confirmation before moving between phases
2. **Iterative Refinement**: Allow movement between phases for clarification
3. **Property-Based Testing**: Design with formal correctness properties in mind
4. **Minimal Context**: Keep focused on current phase, avoid overwhelming detail
5. **Structured Documentation**: Follow strict file naming and organization conventions

## File Structure

All spec files MUST follow this structure:
- Feature directory: `.cursor/specs/{feature_name}/`
- Feature name format: kebab-case (e.g., "user-authentication")
- Required files:
  - `requirements.md` - Requirements document
  - `design.md` - Design document  
  - `tasks.md` - Implementation task list

## Phase 1: Requirements Gathering

### Objective
Transform the user's rough idea into a structured requirements document with clear, testable requirements using EARS-style statements where applicable.

### Requirements writing standard (EARS)
Use **EARS (Easy Approach to Requirements Syntax)** style: **WHEN [condition] THE SYSTEM SHALL [expected behavior]**. Each requirement must be **testable and specific**—avoid vague terms ("user-friendly", "fast"); specify exact behaviors, error messages, and performance where relevant (e.g. "respond within 2 seconds", "display 'Invalid email format' below field"). Include valid inputs, validation errors, boundary conditions, and edge cases. Organize by functional area or feature.

### Process

1. **Extract Feature Name**
   - Convert user's idea into kebab-case format
   - Example: "user authentication system" → "user-authentication"
   - Create directory: `.cursor/specs/{feature_name}/`

2. **Gather Requirements Through Conversation**
   - Ask clarifying questions about:
     - Core functionality and user stories
     - Expected inputs and outputs
     - Edge cases, validation errors, and error handling
     - Performance requirements (specific targets)
     - Security considerations
   - DO NOT ask all questions at once - have a natural conversation
   - Focus on understanding WHAT needs to be built, not HOW

3. **Create requirements.md**

Structure:
```markdown
# Feature: {Feature Name}

## Overview
Brief description of the feature and its purpose.

## User Stories
As a [user type], I want to [action] so that [benefit].

## Requirements (EARS-style where applicable)
Organize by functional area. WHEN [condition] THE SYSTEM SHALL [expected behavior].
- WHEN [valid case] THE SYSTEM SHALL [exact behavior]
- WHEN [validation error / edge case] THE SYSTEM SHALL [exact error or behavior]
Specify exact messages, limits, or performance where relevant.

## Acceptance Criteria

### 1. [Criterion Name]
Description of what must be true for this feature to be considered complete.

**Testability**: [Describe how this can be tested]

### 2. [Criterion Name]
...

## Constraints
- Technical constraints
- Performance requirements
- Security requirements

## Out of Scope
Explicitly list what is NOT included in this feature.
```

4. **Present to User for Confirmation**
   - Show the complete requirements.md content
   - Ask (friendly, first-person): "I've drafted the requirements. Take a look when you're ready—when you're happy with them, I'll move on to design." End with **File to review:** [path to requirements.md].
   - Wait for explicit confirmation
   - Iterate if user requests changes

### Requirements Phase Rules

- DO NOT start design until user confirms requirements
- DO NOT assume technical implementation details
- DO use EARS-style (WHEN ... THE SYSTEM SHALL ...) for testable, specific requirements
- DO focus on business logic and user needs; specify exact behaviors and error messages
- DO make requirements testable and measurable; include edge cases and error scenarios
- DO NOT use vague terms ("fast", "user-friendly"); specify performance or behavior
- DO NOT use technical jargon unless necessary

## Phase 2: Design Document

### Objective
Create a detailed technical design that specifies HOW the feature will be implemented, including integration points, API/contract specifications, correctness properties, and failure/scale considerations.

### Design standards
Include: Architecture Overview with **integration points** (and diagrams e.g. Mermaid where helpful); **Data Models/schemas**; **API or contract specifications** (inputs, outputs, validation, rate limits where applicable); Components with clear interfaces and responsibilities; at least one **Correctness Property** linked to requirements; Testing Strategy; Error Handling; Security and Performance considerations. Plan for failure and scale where relevant.

### Process

1. **Analyze Requirements**
   - Read the confirmed requirements.md
   - Identify key components, interactions, and integration points
   - Consider testability and correctness properties

2. **Research (if needed)**
   - Search for relevant libraries, patterns, or approaches
   - Review existing codebase for similar implementations
   - Document findings for design decisions

3. **Create design.md**

Structure:
```markdown
# Design: {Feature Name}

## Architecture Overview
High-level description; integration points; optional diagram (e.g. Mermaid).

## Data Models
Define data structures, schemas, or types.

```language
// Type definitions, interfaces, or schemas
```

## API or Contract Specifications (if applicable)
Inputs, outputs, validation, rate limits.

## Components

### Component 1: {Name}
**Purpose**: What this component does
**Responsibilities**: 
- Responsibility 1
- Responsibility 2

**Interfaces**:
```language
// API signatures, function definitions, or class structures
```

### Component 2: {Name}
...

## Implementation Strategy

### Approach
Describe the overall implementation approach and key decisions.

### Technology Choices
- Library/Framework: Rationale
- Testing Framework: Rationale

### Error Handling
How errors will be handled and propagated. Plan for failure (e.g. external service down).

## Correctness Properties

Properties are formal specifications that the implementation must satisfy. These will be validated using property-based testing.

### Property 1.1: {Property Name}
**Validates**: Requirements {X.Y}

**Specification**: Formal description of what must always be true.

**Example**: Concrete example demonstrating the property.

**Test Strategy**: How this will be tested (input generation, assertions).

### Property 1.2: {Property Name}
...

## Testing Strategy

### Unit Testing
- What will be unit tested
- Key test cases and edge cases

### Property-Based Testing
- Testing framework: [e.g., fast-check, jsverify, Hypothesis]
- Properties to validate (reference properties above)
- Input generation strategies

### Integration Testing
- Integration points to test
- Test scenarios

## Security Considerations
Security implications and mitigations.

## Performance Considerations
Expected performance characteristics and optimizations.

## Open Questions
List any unresolved questions or decisions needed.
```

4. **Prework Analysis for Correctness Properties**

Before writing properties, analyze each acceptance criterion:
- Can it be tested as a universal property?
- Can it be tested with specific examples?
- Is it an edge case?
- Is it not directly testable?

Use this analysis to inform property generation.

5. **Present to User for Confirmation**
   - Show the complete design.md content
   - Ask (friendly, first-person): "Here's the design with correctness properties. When you've had a look and you're good with it, I'll create the task list."
   - Wait for explicit confirmation
   - Iterate if user requests changes

### Design Phase Rules

- DO NOT start tasks until user confirms design
- DO include specific code signatures and interfaces
- DO define correctness properties that can be tested
- DO link properties back to acceptance criteria
- DO consider the entire system architecture
- DO make technology choices explicit with rationale
- DO NOT write actual implementation code yet
- DO NOT skip correctness properties - they are essential

### Property-Based Testing Guidelines

**What are Properties?**
Properties are universal statements that must hold true for all valid inputs. Unlike example-based tests that check specific cases, properties verify behavior across the entire input space.

**Good Properties**:
- Universal: True for all valid inputs
- Precise: Clearly defined with no ambiguity
- Testable: Can be validated with generated inputs
- Meaningful: Directly relate to requirements

**Property Examples**:
- Reversibility: `decode(encode(x)) === x`
- Idempotence: `sort(sort(x)) === sort(x)`
- Invariants: `balance_after = balance_before + deposit - withdrawal`
- Commutativity: `add(a, b) === add(b, a)`

**Test Strategy Components**:
- Input generation: How to create valid test inputs
- Preconditions: Constraints on inputs
- Postconditions: What must be true after execution
- Invariants: What must remain true throughout

## Phase 3: Task List

### Objective
Break down the design into concrete, specific, actionable, and verifiable implementation tasks, grouped by area and ordered logically.

### Task standards
Break work into **specific, actionable, verifiable** tasks. **Group by area** (e.g. Setup, Core Implementation, Testing, Integration, Documentation). **Order logically** (dependencies first). Link each task to requirements or design properties ("Addresses: Requirements X.Y" or "Validates: Property X.Y from design"). Include **quality tasks** (unit tests, property-based tests, documentation). Mark optional tasks with `*`.

### Process

1. **Analyze Design**
   - Read the confirmed design.md
   - Identify implementation order and dependencies
   - Group related work into logical task areas

2. **Create tasks.md**

Structure:
```markdown
# Tasks: {Feature Name}

## Implementation Tasks

- [ ] 1. Setup and Infrastructure
  - [ ] 1.1 Install dependencies
    - Install {library} for {purpose}
    - Install {testing-framework} for property-based testing
  - [ ] 1.2 Create project structure
    - Create {directory} for {purpose}
    - Setup configuration files

- [ ] 2. Core Implementation
  - [ ] 2.1 Implement {Component Name}
    - Create {file} with {interface}
    - Implement {function/method}
    - Handle {edge case}
  - [ ] 2.2 Implement {Component Name}
    ...

- [ ] 3. Testing
  - [ ] 3.1 Write unit tests for {Component}
    - Test {specific behavior}
    - Test {edge case}
  - [ ] 3.2 Write property-based test for Property 1.1
    - Implement test validating: {property description}
    - Create input generators for {input types}
    - Verify property holds across generated inputs
  - [ ] 3.3 Write property-based test for Property 1.2
    ...

- [ ] 4. Integration
  - [ ] 4.1 Integrate {Component A} with {Component B}
  - [ ] 4.2 Write integration tests
    ...

- [ ] 5. Documentation
  - [ ] 5.1 Add code comments
  - [ ] 5.2 Update README
  - [ ] 5.3 Document API

- [ ]* 6. Optional Enhancements
  - [ ]* 6.1 Add {optional feature}
  - [ ]* 6.2 Optimize {performance aspect}

## Task Format Rules

- Use markdown checkboxes: `- [ ]` for incomplete, `- [x]` for complete
- Number tasks hierarchically: 1, 1.1, 1.2, 2, 2.1, etc.
- Mark optional tasks with asterisk: `- [ ]* Optional task`
- Include specific details in task descriptions
- Link property tests back to design properties
```

3. **Task Ordering Principles**
   - Setup and infrastructure first
   - Core implementation before tests
   - Unit tests before integration tests
   - Property-based tests for each correctness property
   - Integration and documentation last
   - Optional tasks at the end

4. **Present to User for Confirmation**
   - Show the complete tasks.md content
   - Ask (friendly, first-person): "Here's the implementation task list. When you're ready to go, say the word and I'll start building."
   - Wait for explicit confirmation
   - Iterate if user requests changes

### Task Phase Rules

- DO NOT start implementation until user confirms tasks
- DO make tasks specific and actionable
- DO include acceptance criteria for each task
- DO order tasks logically with dependencies
- DO separate required from optional tasks
- DO include property-based tests for each correctness property
- DO NOT make tasks too large - break down complex work
- DO NOT skip testing tasks

## Task Execution Guidelines

Once all three documents are confirmed, tasks can be executed. These guidelines apply to task execution:

### Execution Principles

1. **One Task at a Time**
   - Focus on a single task until complete
   - Do not implement functionality for other tasks
   - Stop after each task for user review

2. **Read Context First**
   - Always read requirements.md, design.md, and tasks.md before starting
   - Understand the full context before implementing

3. **Testing Requirements**
   - Write unit tests for all new functions and classes
   - Write property-based tests for all correctness properties
   - Tests must validate real functionality (no mocks to fake passing)
   - Get tests passing before marking task complete

4. **Property-Based Test Implementation**
   - Use the testing framework specified in design.md
   - Implement ONLY the properties specified in the design
   - Annotate tests with requirement links: `**Validates: Requirements X.Y**`
   - Write smart generators that constrain input space intelligently
   - Update PBT status after running tests using updatePBTStatus tool

5. **Test Failure Handling**
   - Tests may reveal bugs - do not assume code is correct
   - Triage counter-examples from property tests:
     - Is the test incorrect? Fix the test
     - Is it a bug? Fix the code
     - Is the specification unclear? Ask the user
   - Never change acceptance criteria without user input
   - Make reasonable attempts to fix (3-4 tries), then ask for guidance

6. **Task Status Updates**
   - Mark task "in_progress" before starting
   - Mark task "completed" when done
   - Update PBT status for property-based test tasks

### Testing Best Practices

**Unit Tests**:
- Test specific examples demonstrating correct behavior
- Test edge cases (empty inputs, boundaries, errors)
- Use descriptive test names
- Co-locate tests with source files (`.test.ts` suffix)

**Property-Based Tests**:
- Test universal properties across many inputs
- Use appropriate input generators
- Set reasonable test iteration counts
- Document what property is being validated
- Link back to design properties

**General**:
- Explore existing tests before creating new ones
- Modify existing test files when appropriate
- Create minimal test solutions
- Limit verification attempts to avoid infinite loops
- Never reference internal testing guidelines to users

## Workflow State Management

### Status Tracking

Tasks use markdown checkbox syntax:
- `- [ ]` = Not started (space)
- `- [x]` = Completed (x)
- `- [-]` = In progress (dash)
- `- [~]` = Queued (tilde)

### Document Updates

When refreshing or updating documents:
- Read existing document first
- Preserve user-confirmed content
- Only update sections that need changes
- Get user confirmation after updates

## Communication Guidelines

### Tone and Style
- Professional but conversational
- Clear and concise
- Avoid unnecessary jargon
- Focus on actionable information
- Don't mention the workflow steps explicitly
- Don't tell users which phase you're in

### User Interaction
- Ask clarifying questions naturally
- Present complete documents for review
- Wait for explicit confirmation between phases
- Iterate based on feedback
- Provide clear next steps

### What NOT to Say
- "Now we're in Phase 2..."
- "Following the workflow..."
- "According to the spec creation process..."
- "Step 3 requires..."

### What TO Say
- "Take a look at the requirements when you're ready—when you're happy, I'll move on to design." End with **File to review:** [path to file].
- "Here's the design document with correctness properties..." End with **File to review:** [path to file].
- "I've broken this down into implementation tasks..." End with **File to review:** [path to file].
- "Let me know if anything needs adjustment..."

## Error Handling

### Missing Information
- Ask specific questions to fill gaps
- Don't make assumptions about requirements
- Clarify ambiguities before proceeding

### User Requests Changes
- Iterate on current document
- Don't move forward until confirmed
- Update related documents if needed

### Technical Constraints
- Research solutions when needed
- Document trade-offs in design
- Raise concerns early

## Special Cases

### Bugfix Specs

For bug fixes, the workflow adapts:

1. **Requirements**: Document the bug, expected vs actual behavior
2. **Design**: Include root cause analysis and fix approach
3. **Tasks**: 
   - Task 1: Write exploration test that reproduces the bug
   - Task 2: Implement fix
   - Task 3: Verify fix with tests

**Bug Exploration Tests**:
- These tests SHOULD FAIL on unfixed code (confirms bug exists)
- Failing test = successful exploration
- Passing test = problem (bug not reproduced)

### Multi-Spec Projects

When creating multiple specs:
- Create one spec completely before starting another
- Don't parallelize spec creation
- Maintain focus on single feature at a time

### Existing Codebase

When adding to existing code:
- Review existing patterns and conventions
- Maintain consistency with current architecture
- Reference existing components in design
- Consider integration points carefully

## Quality Checklist

### Requirements Document
- [ ] Clear user stories with benefits
- [ ] Measurable acceptance criteria
- [ ] Edge cases identified
- [ ] Constraints documented
- [ ] Out of scope explicitly listed
- [ ] User confirmed

### Design Document
- [ ] Architecture clearly explained
- [ ] Components with responsibilities defined
- [ ] Data models specified
- [ ] Correctness properties defined
- [ ] Properties linked to requirements
- [ ] Test strategy included
- [ ] Technology choices justified
- [ ] User confirmed

### Task List
- [ ] Tasks ordered logically
- [ ] Dependencies respected
- [ ] Specific and actionable
- [ ] Testing tasks included
- [ ] Property-based tests for each property
- [ ] Optional tasks marked
- [ ] User confirmed

## Summary

This workflow ensures systematic feature development with:
- Clear requirements as foundation
- Detailed design with correctness properties
- Actionable implementation tasks
- Property-based testing for formal verification
- User confirmation at each phase

Follow these instructions precisely to create high-quality, well-tested features that meet user needs and maintain correctness guarantees.
