# Spec Creation Quick Reference

**Note for AI Agents**: This document uses `.kiro/` as the configuration directory. Replace it with your agent's directory:
- Cursor → `.cursor/`
- Claude → `.claude/`
- Aider → `.aider/`
- Other agents → Use your system's config directory

## Workflow Overview

```
User Idea → Requirements → Design → Tasks → Implementation
              ↓              ↓         ↓
           Confirm       Confirm   Confirm
```

## Phase Checklist

### Phase 1: Requirements
1. ⬜ Extract feature name (kebab-case)
2. ⬜ Create `.cursor/specs/{feature-name}/` directory
3. ⬜ Gather requirements through conversation (include edge cases and error conditions)
4. ⬜ Create `requirements.md` with:
   - Overview
   - User stories
   - **Requirements (EARS-style):** WHEN [condition] THE SYSTEM SHALL [expected behavior]; testable, specific; include valid inputs, validation errors, boundary cases; organize by functional area
   - Acceptance criteria (testable)
   - Constraints
   - Out of scope
5. ⬜ Present to user for confirmation
6. ⬜ Wait for explicit approval
7. ⬜ Iterate if needed

### Phase 2: Design
1. ⬜ Read confirmed `requirements.md`
2. ⬜ Research if needed
3. ⬜ Create `design.md` with:
   - Architecture overview (integration points; diagrams e.g. Mermaid where helpful)
   - Data models / schemas
   - API or contract specifications (inputs, outputs, validation)
   - Components with interfaces
   - **Correctness properties** (essential! linked to requirements)
   - Testing strategy
   - Error handling, security, performance (plan for failure/scale where relevant)
4. ⬜ Present to user for confirmation
5. ⬜ Wait for explicit approval
6. ⬜ Iterate if needed

### Phase 3: Tasks
1. ⬜ Read confirmed `design.md`
2. ⬜ Create `tasks.md` with **grouped, specific, verifiable** tasks:
   - Setup tasks
   - Core implementation (linked: "Addresses: Requirements X.Y")
   - Testing tasks (unit + property-based; "Validates: Property X.Y from design")
   - Integration tasks
   - Documentation tasks
   - Optional tasks (marked with `*`)
   - Logical order; include quality tasks
3. ⬜ Present to user for confirmation
4. ⬜ Wait for explicit approval
5. ⬜ Iterate if needed

## File Templates

### requirements.md
```markdown
# Feature: {Name}

## Overview
Brief description.

## User Stories
As a [user], I want to [action] so that [benefit].

## Requirements (EARS-style)
Organize by functional area. WHEN [condition] THE SYSTEM SHALL [expected behavior].
- WHEN [valid case] THE SYSTEM SHALL [exact behavior]
- WHEN [error / edge case] THE SYSTEM SHALL [exact error or behavior]
Be specific (exact messages, limits, performance e.g. "within 2s").

## Acceptance Criteria

### 1. [Criterion Name]
Description.

**Testability**: How to verify.

## Constraints
- Constraint 1
- Constraint 2

## Out of Scope
- Not included 1
- Not included 2
```

### design.md
```markdown
# Design: {Name}

## Architecture Overview
High-level approach; integration points; optional diagram (e.g. Mermaid).

## Data Models
Type definitions / schemas.

## API or Contract Specifications (if applicable)
Inputs, outputs, validation, rate limits.

## Components

### Component: {Name}
**Purpose**: What it does
**Responsibilities**: 
- Responsibility 1
**Interfaces**:
```language
// Code signatures
```

## Correctness Properties (REQUIRED)

### Property 1.1: {Name}
**Validates**: Requirements {X.Y}
**Specification**: What must be true.
**Example**: Concrete example.
**Test Strategy**: How to test.

## Testing Strategy
Unit, property-based, and integration testing plans.

## Error Handling | Security | Performance
As applicable; plan for failure and scale where relevant.
```

### tasks.md
```markdown
# Tasks: {Name}

## Implementation Tasks

- [ ] 1. Setup
  - [ ] 1.1 Install dependencies
  - [ ] 1.2 Create structure

- [ ] 2. Core Implementation
  - [ ] 2.1 Implement Component A
  - [ ] 2.2 Implement Component B

- [ ] 3. Testing
  - [ ] 3.1 Unit tests for A
  - [ ] 3.2 Property test for Property 1.1
  - [ ] 3.3 Integration tests

- [ ] 4. Documentation
  - [ ] 4.1 Code comments
  - [ ] 4.2 API docs

- [ ]* 5. Optional
  - [ ]* 5.1 Enhancement
```

## Task Status Syntax

- `- [ ]` = Not started
- `- [x]` = Completed
- `- [-]` = In progress
- `- [~]` = Queued
- `- [ ]*` = Optional task

## Property-Based Testing

### Property Categories
- **Reversibility**: `f(g(x)) === x`
- **Idempotence**: `f(f(x)) === f(x)`
- **Invariants**: `relationship always holds`
- **Commutativity**: `f(a,b) === f(b,a)`
- **Associativity**: `f(f(a,b),c) === f(a,f(b,c))`

### Property Template
```markdown
### Property X.Y: {Name}
**Validates**: Requirements {A.B}
**Specification**: Universal statement
**Example**: Concrete demonstration
**Test Strategy**: 
- Input generation: How to create inputs
- Assertions: What to verify
```

## Communication Rules

### DO Say
- "Take a look at the requirements when you're ready—when you're happy, I'll move on to design." End with **File to review:** [path to file].
- "Here's the design document. Let me know if anything needs adjustment..." End with **File to review:** [path to file].
- "I've created the task list. Please confirm before we begin..." End with **File to review:** [path to file].

### DON'T Say
- "Now we're in Phase 2..."
- "Following the workflow..."
- "Step 3 requires..."
- "According to the spec process..."

## Critical Rules

### Between Phases
- ❌ Never proceed without user confirmation
- ✅ Always wait for explicit approval
- ✅ Iterate based on feedback

### During Requirements
- ❌ No implementation details
- ✅ Focus on WHAT, not HOW
- ✅ Make criteria testable

### During Design
- ❌ Never skip correctness properties
- ✅ Link properties to requirements
- ✅ Include test strategy

### During Tasks
- ❌ Don't make tasks too large
- ✅ Include property-based test tasks
- ✅ Mark optional tasks with `*`

### During Execution
- ❌ Never implement multiple tasks at once
- ✅ Read requirements/design first
- ✅ Write tests before marking complete
- ✅ Update task status

## Testing Guidelines

### Unit Tests
- Test happy path
- Test edge cases
- Test error cases
- Use AAA pattern (Arrange, Act, Assert)

### Property-Based Tests
- Test universal properties
- Use smart generators
- Run 100-10000 iterations
- Link to design properties
- Annotate: `**Validates: Requirements X.Y**`

### Test Failures
When property test fails:
1. Is the test wrong? → Fix test
2. Is it a bug? → Fix code
3. Is spec unclear? → Ask user

## Common Mistakes

### Requirements
- ❌ "Use JWT tokens" → ✅ "Authenticate users securely" (or EARS: WHEN user provides valid credentials THE SYSTEM SHALL return an access token)
- ❌ "Should be fast" → ✅ "Respond within 200ms" / WHEN under normal load THE SYSTEM SHALL respond within 2 seconds
- ❌ Only happy path → ✅ Include error scenarios (WHEN invalid input THE SYSTEM SHALL return exact error message)
- ❌ Vague "user-friendly" → ✅ Specific behavior and messages (EARS: WHEN validation fails THE SYSTEM SHALL display "Invalid email format" below the email field)

### Design
- ❌ No properties → ✅ Define correctness properties
- ❌ Vague interfaces → ✅ Specific signatures
- ❌ Missing errors → ✅ Error handling strategy

### Tasks
- ❌ "Implement auth" → ✅ "Implement token generation function"
- ❌ No test tasks → ✅ Unit + property tests
- ❌ All required → ✅ Mark optional tasks

## File Locations

```
.cursor/specs/
├── feature-name/
│   ├── requirements.md
│   ├── design.md
│   └── tasks.md
```

Specs live in **`.cursor/specs/`**.

## Naming Conventions

- Feature names: `kebab-case`
- File names: `requirements.md`, `design.md`, `tasks.md`
- Never deviate from these names

## Quality Checks

Before user confirmation:
- ✅ All sections complete
- ✅ No placeholders
- ✅ Consistent formatting
- ✅ Valid code examples
- ✅ Testable criteria
- ✅ Properties linked to requirements
- ✅ Clear task descriptions

## Success Indicators

- ✅ User confirms each phase
- ✅ Requirements are testable
- ✅ Design has correctness properties
- ✅ Tasks are actionable
- ✅ Tests validate properties
- ✅ Implementation matches design

## Emergency Procedures

### User Wants Changes
- Stop current phase
- Iterate on document
- Get new confirmation
- Update dependent documents if needed

### Missing Information
- Ask specific questions
- Don't assume
- Clarify before proceeding

### Technical Blockers
- Research solutions
- Document trade-offs
- Raise concerns early
- Ask for guidance

## Remember

1. **User is ground truth** - Always get confirmation
2. **Properties are essential** - Never skip them
3. **One task at a time** - Focus and complete
4. **Tests must pass** - No fake passing with mocks
5. **Be conversational** - Don't mention workflow steps

## Quick Decision Tree

```
User provides idea
    ↓
Is feature name clear? → No → Ask for clarification
    ↓ Yes
Create requirements.md
    ↓
User confirms? → No → Iterate
    ↓ Yes
Create design.md with properties
    ↓
User confirms? → No → Iterate
    ↓ Yes
Create tasks.md
    ↓
User confirms? → No → Iterate
    ↓ Yes
Ready for execution
```

## Tool Usage

- `taskStatus`: Update task progress
- `updatePBTStatus`: Update property test results
- `getDiagnostics`: Check for code errors
- `executeBash`: Run tests (not for long-running processes)

## Final Checklist

Before saying "done":
- ⬜ All three documents created
- ⬜ User confirmed each document
- ⬜ Properties defined and linked
- ⬜ Tasks are specific and ordered
- ⬜ Testing strategy complete
- ⬜ Ready for implementation

---

Keep this reference handy during spec creation. Follow the workflow, get confirmations, and create high-quality specifications.
