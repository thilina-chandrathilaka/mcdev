# Spec Standards and Best Practices

## Document Standards

**Note for AI Agents**: This document uses `.kiro/` as the configuration directory. Replace it with your agent's directory:
- Cursor → `.cursor/`
- Claude → `.claude/`
- Aider → `.aider/`
- Other agents → Use your system's config directory

### Naming Conventions

**Feature Names**:
- Use kebab-case: `user-authentication`, `payment-processing`, `data-export`
- Be descriptive but concise
- Avoid abbreviations unless widely understood
- Use singular form: `user-profile` not `user-profiles`

**File Names**:
- Always use: `requirements.md`, `design.md`, `tasks.md`
- Never deviate from these names
- All lowercase

**Directory Structure**:
```
.cursor/specs/
├── feature-name-1/
│   ├── requirements.md
│   ├── design.md
│   └── tasks.md
├── feature-name-2/
│   ├── requirements.md
│   ├── design.md
│   └── tasks.md
```

**Note**: Replace `{CONFIG_DIR}` with your agent's directory (e.g., `.cursor/`, `.claude/`, `.kiro/`)

### Markdown Formatting

**Headers**:
- Use `#` for document title
- Use `##` for major sections
- Use `###` for subsections
- Use `####` sparingly for deep nesting

**Lists**:
- Use `-` for unordered lists
- Use `1.`, `2.` for ordered lists
- Indent sub-items with 2 spaces

**Code Blocks**:
- Always specify language: ` ```typescript`, ` ```python`
- Use inline code for short snippets: `` `functionName` ``
- Include comments in code examples

**Emphasis**:
- Use `**bold**` for important terms
- Use `*italic*` for emphasis
- Use `> blockquote` for notes or warnings

## Requirements Best Practices

### EARS-style requirements (recommended)

Use **EARS (Easy Approach to Requirements Syntax)** for testable, specific requirements:

**Template:** WHEN [condition] THE SYSTEM SHALL [expected behavior]

- Each statement must be **testable** and **specific** (exact behaviors, error messages, performance where relevant).
- Avoid vague terms: not "user-friendly" or "fast"—use e.g. "respond within 2 seconds", "display 'Invalid email format' below the email field".
- Organize by **functional area** or feature.
- Cover **valid inputs**, **validation errors**, **boundary conditions**, and **edge cases**.

**Examples**:
```markdown
## User Registration
WHEN a user submits valid registration data THE SYSTEM SHALL create a new user account
WHEN a user submits an email that already exists THE SYSTEM SHALL display "Email already registered" error
WHEN a user submits invalid email format THE SYSTEM SHALL display email validation error below the field

## User Login
WHEN a user enters correct credentials THE SYSTEM SHALL authenticate and redirect to dashboard within 2 seconds
WHEN a user enters incorrect password THE SYSTEM SHALL display "Invalid credentials" error
WHEN a user fails login 3 times THE SYSTEM SHALL temporarily lock the account and display lockout message
```

**Advanced:** Include performance where relevant (e.g. "THE SYSTEM SHALL respond within 200ms under normal load"), and define success criteria explicitly.

### Writing User Stories

**Format**: As a [user type], I want to [action] so that [benefit].

**Good Examples**:
- As a developer, I want to authenticate API requests so that only authorized users can access protected resources.
- As an admin, I want to view audit logs so that I can track system changes.

**Bad Examples**:
- As a user, I want authentication (missing benefit)
- I want to add a login button (not user-focused)
- The system should validate passwords (not a user story)

### Writing Acceptance Criteria

**Structure**:
```markdown
### X. [Criterion Name]
Description of what must be true.

**Testability**: How this can be verified.
```

**Good Criteria**:
- Specific and measurable
- Focused on behavior, not implementation
- Include success and failure cases
- Consider edge cases

**Examples** (aligned with EARS):
```markdown
### 1. Valid Authentication
WHEN a user provides correct credentials THE SYSTEM SHALL return an access token valid for 1 hour.

**Testability**: Verify token is returned, contains correct claims, and expires after 1 hour.

### 2. Invalid Credentials Handling
WHEN a user provides incorrect credentials THE SYSTEM SHALL return a 401 error with a generic message.

**Testability**: Verify error code, message doesn't reveal whether username or password was wrong.
```

### Requirements Anti-Patterns

**Avoid**:
- Implementation details: "Use JWT tokens" → Focus on authentication need (or EARS: WHEN valid credentials THE SYSTEM SHALL return a signed token)
- Vague criteria: "Should be fast" → "THE SYSTEM SHALL respond within 200ms" or specify performance
- Missing edge cases: Only happy path → Include WHEN [error/edge] THE SYSTEM SHALL [behavior]
- Scope creep: Adding unrelated features → Stay focused

## Design Best Practices

### Design document elements

Include: **Architecture Overview** (with integration points; use Mermaid or text diagrams where helpful); **Data Models/schemas**; **API or contract specifications** (inputs, outputs, validation, rate limits); **Components** with clear interfaces; **Correctness Properties** (at least one, linked to requirements); **Testing Strategy**; **Error Handling** (plan for failure, e.g. external service down); **Security and Performance** (plan for scale where relevant).

### Architecture Description

**Good Architecture Overview**:
- Explains the high-level approach and **integration points**
- Identifies major components and their interactions
- Justifies architectural decisions
- Considers scalability, maintainability, and failure modes
- Optionally includes a diagram (e.g. Mermaid) for flow or structure

**Example**:
```markdown
## Architecture Overview

This feature implements a token-based authentication system using a middleware pattern. 
The authenticator validates credentials against a user store, generates signed tokens, 
and provides middleware to protect routes. Integration: Frontend → API Gateway → Auth Service → Database; JWT Token Service. 
This approach separates authentication logic from business logic and allows for easy testing and reuse.
```

### Component Design

**Component Template**:
```markdown
### Component: {Name}

**Purpose**: One-sentence description

**Responsibilities**:
- Specific responsibility 1
- Specific responsibility 2

**Interfaces**:
```typescript
interface ComponentName {
  method1(param: Type): ReturnType;
  method2(param: Type): ReturnType;
}
```

**Dependencies**: What this component depends on

**Error Handling**: How errors are handled
```

### Correctness Properties

**Property Quality Criteria**:
1. **Universal**: Must hold for all valid inputs
2. **Precise**: No ambiguity in specification
3. **Testable**: Can be validated with generated inputs
4. **Meaningful**: Directly supports requirements

**Property Template**:
```markdown
### Property X.Y: {Name}
**Validates**: Requirements {A.B}

**Specification**: 
Formal statement of what must always be true.

**Example**: 
Concrete example demonstrating the property.

**Test Strategy**:
- Input generation: How to create test inputs
- Preconditions: Constraints on inputs
- Assertions: What to verify
```

**Property Categories**:

1. **Reversibility**: Operations that can be undone
   - `decode(encode(x)) === x`
   - `deserialize(serialize(x)) === x`

2. **Idempotence**: Repeated operations have same effect
   - `sort(sort(x)) === sort(x)`
   - `normalize(normalize(x)) === normalize(x)`

3. **Invariants**: Relationships that always hold
   - `length(concat(a, b)) === length(a) + length(b)`
   - `sum(split(total, n)) === total`

4. **Commutativity**: Order doesn't matter
   - `add(a, b) === add(b, a)`
   - `union(A, B) === union(B, A)`

5. **Associativity**: Grouping doesn't matter
   - `add(add(a, b), c) === add(a, add(b, c))`

6. **Monotonicity**: Preserves ordering
   - `if a < b then f(a) <= f(b)`

7. **Conservation**: Something is preserved
   - `count_before === count_after + deleted`
   - `total_in === total_out + stored`

### Design Anti-Patterns

**Avoid**:
- Over-engineering: Keep it simple
- Missing error handling: Always consider failures
- Unclear interfaces: Be explicit about contracts
- No properties: Every feature should have testable properties
- Implementation in design: Design specifies WHAT, not HOW (but include signatures)

## Task List Best Practices

### Task standards

Break work into **specific, actionable, verifiable** tasks. **Group by area** (Setup, Core Implementation, Testing, Integration, Documentation). **Order logically** (dependencies first). **Link each task** to requirements or design properties ("Addresses: Requirements X.Y" or "Validates: Property X.Y from design"). Include **quality tasks** (unit tests, property-based tests, documentation). Mark optional tasks with `*`.

### Task Granularity

**Good Task Size**:
- Completable in 30 minutes to 2 hours
- Single, clear objective
- **Verifiable** outcome (testable or demonstrable)

**Too Large**:
- "Implement authentication system" → Break into components

**Too Small**:
- "Add semicolon to line 42" → Combine with related work

**Just Right**:
- "Implement token generation function with expiration"
- "Write property test for token validation"

### Task Organization

**Standard Structure** (grouped by area, linked to requirements/properties):
```markdown
1. Setup and Infrastructure
   1.1 Install dependencies          Addresses: Requirements X.Y
   1.2 Create project structure
   1.3 Setup configuration

2. Core Implementation
   2.1 Implement Component A        Addresses: Requirements X.Y
   2.2 Implement Component B        Addresses: Requirements X.Y
   2.3 Integrate components

3. Testing
   3.1 Unit tests for Component A   Addresses: Requirements X.Y
   3.2 Unit tests for Component B
   3.3 Property test for Property 1.1   Validates: Property 1.1 from design
   3.4 Property test for Property 1.2   Validates: Property 1.2 from design
   3.5 Integration tests

4. Documentation
   4.1 Code comments
   4.2 API documentation
   4.3 Usage examples

5. Optional Enhancements
   5.1* Performance optimization
   5.2* Additional features
```

### Task Description Quality

**Good Task Description**:
```markdown
- [ ] 2.1 Implement token generation function
  - Create `generateToken(userId, expiresIn)` function
  - Use JWT with HS256 algorithm
  - Include userId and expiration in payload
  - Return signed token string
  - Handle signing errors appropriately
```

**Poor Task Description**:
```markdown
- [ ] 2.1 Add token stuff
```

### Task Dependencies

**Respect Dependencies**:
- Infrastructure before implementation
- Implementation before tests
- Unit tests before integration tests
- Core features before optional enhancements

**Mark Dependencies**:
```markdown
- [ ] 2.1 Implement Component A
- [ ] 2.2 Implement Component B (depends on 2.1)
- [ ] 3.1 Test Component B (depends on 2.2)
```

## Property-Based Testing Standards

### Test Framework Selection

**Popular Frameworks**:
- JavaScript/TypeScript: `fast-check`, `jsverify`
- Python: `Hypothesis`
- Java: `jqwik`, `QuickCheck`
- Haskell: `QuickCheck`
- Rust: `proptest`, `quickcheck`

**Selection Criteria**:
- Language compatibility
- Community support
- Shrinking capabilities (finding minimal failing examples)
- Integration with existing test framework

### Writing Generators

**Good Generator**:
```typescript
// Constrained to valid input space
const validEmailGen = fc.string()
  .filter(s => s.includes('@') && s.length > 3);

// Structured data
const userGen = fc.record({
  id: fc.integer({ min: 1 }),
  email: validEmailGen,
  age: fc.integer({ min: 0, max: 120 })
});
```

**Poor Generator**:
```typescript
// Too broad - generates invalid inputs
const emailGen = fc.string();

// Too narrow - misses edge cases
const ageGen = fc.constant(25);
```

### Property Test Structure

**Template**:
```typescript
describe('Property: {Name}', () => {
  it('validates: Requirements X.Y', () => {
    fc.assert(
      fc.property(
        inputGenerator,
        (input) => {
          // Arrange
          const precondition = checkPrecondition(input);
          fc.pre(precondition); // Skip if precondition fails
          
          // Act
          const result = functionUnderTest(input);
          
          // Assert
          expect(result).toSatisfy(property);
        }
      ),
      { numRuns: 1000 } // Adjust based on complexity
    );
  });
});
```

### Property Test Best Practices

**Do**:
- Test universal properties, not specific examples
- Use appropriate number of test runs (100-10000)
- Leverage shrinking to find minimal failing cases
- Document what property is being tested
- Link properties to requirements

**Don't**:
- Test implementation details
- Use mocks to make properties pass
- Ignore failing counter-examples
- Write properties that are too weak (always pass)
- Write properties that are too strong (always fail)

## Testing Standards

### Unit Test Standards

**Naming Convention**:
```typescript
describe('ComponentName', () => {
  describe('methodName', () => {
    it('should do X when Y', () => {
      // Test
    });
    
    it('should throw error when invalid input', () => {
      // Test
    });
  });
});
```

**Test Structure (AAA Pattern)**:
```typescript
it('should calculate total correctly', () => {
  // Arrange
  const items = [{ price: 10 }, { price: 20 }];
  const calculator = new Calculator();
  
  // Act
  const total = calculator.calculateTotal(items);
  
  // Assert
  expect(total).toBe(30);
});
```

### Test Coverage Guidelines

**What to Test**:
- Happy path (expected usage)
- Edge cases (boundaries, empty inputs)
- Error cases (invalid inputs, failures)
- Integration points (component interactions)

**What NOT to Test**:
- Third-party library internals
- Language built-ins
- Trivial getters/setters (unless they have logic)

### Test Independence

**Good**:
```typescript
beforeEach(() => {
  // Fresh state for each test
  database = createTestDatabase();
});

afterEach(() => {
  // Clean up
  database.close();
});
```

**Bad**:
```typescript
// Tests depend on execution order
let sharedState;

it('test 1', () => {
  sharedState = setup();
});

it('test 2', () => {
  // Depends on test 1 running first
  expect(sharedState).toBeDefined();
});
```

## Documentation Standards

### Code Comments

**When to Comment**:
- Complex algorithms or logic
- Non-obvious design decisions
- Public APIs and interfaces
- Workarounds or hacks (with explanation)

**When NOT to Comment**:
- Obvious code: `// increment i` for `i++`
- Redundant information already in code
- Outdated comments (update or remove)

**Good Comments**:
```typescript
/**
 * Generates a JWT token for the given user.
 * 
 * @param userId - Unique identifier for the user
 * @param expiresIn - Token lifetime in seconds (default: 3600)
 * @returns Signed JWT token string
 * @throws {TokenGenerationError} If signing fails
 */
function generateToken(userId: string, expiresIn: number = 3600): string {
  // Use HS256 for symmetric signing (faster than RS256 for our use case)
  const payload = { userId, exp: Date.now() + expiresIn * 1000 };
  return jwt.sign(payload, SECRET_KEY, { algorithm: 'HS256' });
}
```

### API Documentation

**Include**:
- Purpose and usage
- Parameters with types and constraints
- Return values
- Possible errors/exceptions
- Examples

**Example**:
```markdown
## API: `authenticateUser`

Validates user credentials and returns an access token.

### Parameters
- `username` (string): User's username
- `password` (string): User's password

### Returns
- `Promise<AuthResult>`: Object containing:
  - `token` (string): JWT access token
  - `expiresIn` (number): Token lifetime in seconds

### Errors
- `AuthenticationError`: Invalid credentials
- `RateLimitError`: Too many failed attempts

### Example
```typescript
const result = await authenticateUser('john', 'secret123');
console.log(result.token); // eyJhbGc...
```
```

## Quality Assurance

### Review Checklist

**Before User Confirmation**:
- [ ] All sections complete
- [ ] No placeholder text
- [ ] Consistent formatting
- [ ] No typos or grammar errors
- [ ] Code examples are valid
- [ ] Links and references work
- [ ] Follows naming conventions

**Requirements Review**:
- [ ] User stories have clear benefits
- [ ] Requirements use EARS-style (WHEN ... THE SYSTEM SHALL ...) where applicable; testable and specific
- [ ] Acceptance criteria are testable; edge cases and error scenarios included
- [ ] Constraints documented
- [ ] Out of scope defined

**Design Review**:
- [ ] Architecture clearly explained
- [ ] All components defined
- [ ] Interfaces specified
- [ ] Correctness properties included
- [ ] Properties linked to requirements
- [ ] Test strategy complete
- [ ] Error handling addressed

**Tasks Review**:
- [ ] Logical ordering
- [ ] Appropriate granularity
- [ ] Clear descriptions
- [ ] Testing tasks included
- [ ] Property tests for each property
- [ ] Optional tasks marked

## Common Pitfalls

### Requirements Phase
- ❌ Including implementation details
- ❌ Vague acceptance criteria
- ❌ Missing edge cases
- ❌ Skipping user confirmation

### Design Phase
- ❌ No correctness properties
- ❌ Properties not linked to requirements
- ❌ Missing error handling
- ❌ Unclear component boundaries
- ❌ No test strategy

### Tasks Phase
- ❌ Tasks too large or too small
- ❌ Missing testing tasks
- ❌ No property-based tests
- ❌ Poor task descriptions
- ❌ Ignoring dependencies

### Execution Phase
- ❌ Implementing multiple tasks at once
- ❌ Not reading requirements/design first
- ❌ Skipping tests
- ❌ Using mocks to fake passing tests
- ❌ Not updating task status

## Success Criteria

A high-quality spec has:
- ✅ Clear, testable requirements
- ✅ Detailed design with correctness properties
- ✅ Actionable task list
- ✅ User confirmation at each phase
- ✅ Property-based testing strategy
- ✅ Comprehensive test coverage
- ✅ Clear documentation

Follow these standards to create specifications that lead to correct, well-tested implementations.
