# Property-Based Testing Guide for AI Agents

**Note for AI Agents**: This guide is agent-agnostic. The methodology applies to all AI coding agents regardless of your system's configuration directory structure.

## What is Property-Based Testing?

Property-Based Testing (PBT) validates that software satisfies formal specifications by testing universal properties across many automatically-generated inputs, rather than testing specific examples.

### Traditional Testing vs Property-Based Testing

**Example-Based Testing**:
```typescript
it('should add two numbers', () => {
  expect(add(2, 3)).toBe(5);
  expect(add(0, 0)).toBe(0);
  expect(add(-1, 1)).toBe(0);
});
```
Tests specific cases. Might miss edge cases.

**Property-Based Testing**:
```typescript
it('addition is commutative', () => {
  fc.assert(
    fc.property(fc.integer(), fc.integer(), (a, b) => {
      expect(add(a, b)).toBe(add(b, a));
    })
  );
});
```
Tests universal property across thousands of generated inputs.

## Why Property-Based Testing?

### Benefits
1. **Finds edge cases**: Automatically discovers inputs you didn't think to test
2. **Formal specification**: Forces you to think about what should always be true
3. **Comprehensive coverage**: Tests thousands of cases instead of handful
4. **Regression prevention**: Properties remain valid as code evolves
5. **Documentation**: Properties describe system behavior formally

### When to Use
- Core business logic
- Data transformations
- Algorithms and calculations
- Serialization/deserialization
- State machines
- API contracts

### When NOT to Use
- UI interactions (better with integration tests)
- External API calls (use mocks/stubs)
- Time-dependent behavior (hard to make deterministic)
- Trivial code (getters/setters without logic)

## Property Categories

### 1. Reversibility (Inverse Functions)

**Definition**: Applying a function and its inverse returns the original value.

**Pattern**: `inverse(f(x)) === x`

**Examples**:
```typescript
// Encoding/Decoding
decode(encode(data)) === data

// Serialization
parse(stringify(obj)) === obj

// Encryption
decrypt(encrypt(plaintext, key), key) === plaintext

// Compression
decompress(compress(data)) === data
```

**Test Template**:
```typescript
describe('Property: Reversibility', () => {
  it('validates: decode(encode(x)) === x', () => {
    fc.assert(
      fc.property(fc.string(), (input) => {
        const encoded = encode(input);
        const decoded = decode(encoded);
        expect(decoded).toBe(input);
      })
    );
  });
});
```

### 2. Idempotence

**Definition**: Applying a function multiple times has the same effect as applying it once.

**Pattern**: `f(f(x)) === f(x)`

**Examples**:
```typescript
// Sorting
sort(sort(array)) === sort(array)

// Normalization
normalize(normalize(text)) === normalize(text)

// Deduplication
dedupe(dedupe(list)) === dedupe(list)

// Absolute value
abs(abs(x)) === abs(x)
```

**Test Template**:
```typescript
describe('Property: Idempotence', () => {
  it('validates: sort(sort(x)) === sort(x)', () => {
    fc.assert(
      fc.property(fc.array(fc.integer()), (arr) => {
        const sorted1 = sort(arr);
        const sorted2 = sort(sorted1);
        expect(sorted2).toEqual(sorted1);
      })
    );
  });
});
```

### 3. Invariants

**Definition**: Relationships or properties that always hold true.

**Pattern**: `relationship(input, output) === true`

**Examples**:
```typescript
// Length preservation
length(concat(a, b)) === length(a) + length(b)

// Conservation
balance_after === balance_before + deposit - withdrawal

// Ordering
if a < b then indexOf(a) < indexOf(b) in sorted array

// Bounds
min(array) <= all elements <= max(array)
```

**Test Template**:
```typescript
describe('Property: Length Invariant', () => {
  it('validates: length(concat(a,b)) === length(a) + length(b)', () => {
    fc.assert(
      fc.property(
        fc.array(fc.integer()),
        fc.array(fc.integer()),
        (a, b) => {
          const concatenated = concat(a, b);
          expect(concatenated.length).toBe(a.length + b.length);
        }
      )
    );
  });
});
```

### 4. Commutativity

**Definition**: Order of operands doesn't affect the result.

**Pattern**: `f(a, b) === f(b, a)`

**Examples**:
```typescript
// Addition
add(a, b) === add(b, a)

// Multiplication
multiply(a, b) === multiply(b, a)

// Set union
union(A, B) === union(B, A)

// Logical AND
and(a, b) === and(b, a)
```

**Test Template**:
```typescript
describe('Property: Commutativity', () => {
  it('validates: add(a, b) === add(b, a)', () => {
    fc.assert(
      fc.property(fc.integer(), fc.integer(), (a, b) => {
        expect(add(a, b)).toBe(add(b, a));
      })
    );
  });
});
```

### 5. Associativity

**Definition**: Grouping of operations doesn't affect the result.

**Pattern**: `f(f(a, b), c) === f(a, f(b, c))`

**Examples**:
```typescript
// Addition
(a + b) + c === a + (b + c)

// String concatenation
concat(concat(a, b), c) === concat(a, concat(b, c))

// Set union
union(union(A, B), C) === union(A, union(B, C))
```

**Test Template**:
```typescript
describe('Property: Associativity', () => {
  it('validates: (a + b) + c === a + (b + c)', () => {
    fc.assert(
      fc.property(
        fc.integer(),
        fc.integer(),
        fc.integer(),
        (a, b, c) => {
          expect(add(add(a, b), c)).toBe(add(a, add(b, c)));
        }
      )
    );
  });
});
```

### 6. Monotonicity

**Definition**: Function preserves or reverses ordering.

**Pattern**: `if a <= b then f(a) <= f(b)` (increasing)
**Pattern**: `if a <= b then f(a) >= f(b)` (decreasing)

**Examples**:
```typescript
// Increasing
if x < y then sqrt(x) < sqrt(y)

// Decreasing
if x < y then -x > -y

// Preserving order
sorted array maintains relative order of equal elements (stable sort)
```

**Test Template**:
```typescript
describe('Property: Monotonicity', () => {
  it('validates: if a < b then f(a) < f(b)', () => {
    fc.assert(
      fc.property(
        fc.integer({ min: 0 }),
        fc.integer({ min: 0 }),
        (a, b) => {
          fc.pre(a < b); // Precondition
          expect(sqrt(a)).toBeLessThan(sqrt(b));
        }
      )
    );
  });
});
```

### 7. Conservation

**Definition**: Some quantity or property is preserved through transformation.

**Pattern**: `measure(input) === measure(output)`

**Examples**:
```typescript
// Element count
count(input) === count(output) + deleted

// Total value
sum(split(total, n)) === total

// Data integrity
checksum(original) === checksum(transmitted)
```

**Test Template**:
```typescript
describe('Property: Conservation', () => {
  it('validates: sum(split(total, n)) === total', () => {
    fc.assert(
      fc.property(
        fc.integer({ min: 0, max: 1000 }),
        fc.integer({ min: 1, max: 10 }),
        (total, n) => {
          const parts = split(total, n);
          const sum = parts.reduce((a, b) => a + b, 0);
          expect(sum).toBe(total);
        }
      )
    );
  });
});
```

## Writing Good Properties

### Characteristics of Good Properties

1. **Universal**: Must hold for all valid inputs
2. **Precise**: No ambiguity in specification
3. **Testable**: Can be validated with generated inputs
4. **Meaningful**: Directly relates to requirements
5. **Independent**: Doesn't depend on implementation details

### Property Quality Checklist

- ⬜ Property is stated clearly and formally
- ⬜ Property is universal (not just specific examples)
- ⬜ Property relates to acceptance criteria
- ⬜ Property can be tested with generated inputs
- ⬜ Property is not trivially true or false
- ⬜ Property tests behavior, not implementation

### Common Property Mistakes

**Too Weak** (always passes):
```typescript
// Bad: Always true
expect(result).toBeDefined();

// Good: Specific constraint
expect(result.length).toBe(input.length);
```

**Too Strong** (always fails):
```typescript
// Bad: Impossible to satisfy
expect(sort(array)).toEqual(array); // Only true if already sorted

// Good: Testable property
expect(isSorted(sort(array))).toBe(true);
```

**Implementation-Dependent**:
```typescript
// Bad: Tests implementation
expect(sort(array)).toEqual(quickSort(array));

// Good: Tests behavior
expect(isSorted(sort(array))).toBe(true);
```

**Not Universal**:
```typescript
// Bad: Only tests specific case
expect(add(2, 3)).toBe(5);

// Good: Universal property
expect(add(a, b)).toBe(add(b, a)); // For all a, b
```

## Input Generation

### Generator Strategies

**1. Constrained Generation**
Generate only valid inputs:
```typescript
// Email addresses
const emailGen = fc.string()
  .filter(s => s.includes('@') && s.length > 3);

// Positive integers
const positiveIntGen = fc.integer({ min: 1 });

// Non-empty arrays
const nonEmptyArrayGen = fc.array(fc.integer(), { minLength: 1 });
```

**2. Structured Generation**
Generate complex data structures:
```typescript
const userGen = fc.record({
  id: fc.integer({ min: 1 }),
  name: fc.string({ minLength: 1 }),
  email: emailGen,
  age: fc.integer({ min: 0, max: 120 }),
  roles: fc.array(fc.constantFrom('admin', 'user', 'guest'))
});
```

**3. Recursive Generation**
Generate nested structures:
```typescript
const treeGen: fc.Arbitrary<Tree> = fc.letrec(tie => ({
  node: fc.record({
    value: fc.integer(),
    left: fc.option(tie('node')),
    right: fc.option(tie('node'))
  })
})).node;
```

**4. Dependent Generation**
Generate related values:
```typescript
fc.integer({ min: 0, max: 100 }).chain(max =>
  fc.record({
    max: fc.constant(max),
    value: fc.integer({ min: 0, max })
  })
);
```

### Generator Best Practices

**DO**:
- Constrain to valid input space
- Use appropriate data types
- Generate edge cases (empty, zero, max)
- Use meaningful ranges
- Combine generators for complex data

**DON'T**:
- Generate invalid inputs (unless testing error handling)
- Use overly broad generators
- Ignore domain constraints
- Generate too-simple inputs that miss edge cases

## Test Configuration

### Number of Test Runs

```typescript
fc.assert(
  fc.property(generator, (input) => {
    // Test logic
  }),
  { 
    numRuns: 1000, // Adjust based on complexity
    seed: 42,      // For reproducibility
    timeout: 5000  // Milliseconds
  }
);
```

**Guidelines**:
- Simple properties: 100-1000 runs
- Complex properties: 1000-10000 runs
- Critical properties: 10000+ runs
- Quick feedback: 100 runs during development

### Shrinking

When a property fails, the framework tries to find the minimal failing example:

```typescript
// Original failure: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
// After shrinking: [1]
```

**Shrinking helps**:
- Understand root cause
- Debug more easily
- Create regression tests

**Enable shrinking** (usually default):
```typescript
fc.assert(
  fc.property(generator, test),
  { endOnFailure: false } // Continue shrinking
);
```

## Preconditions

Use preconditions to skip invalid inputs:

```typescript
fc.assert(
  fc.property(fc.integer(), fc.integer(), (a, b) => {
    fc.pre(b !== 0); // Skip when b is zero
    expect(divide(a, b) * b).toBeCloseTo(a);
  })
);
```

**When to use**:
- Filtering is too restrictive
- Complex validity conditions
- Dependent constraints

**Caution**: Too many skipped tests indicate poor generator design.

## Linking Properties to Requirements

Always link properties to acceptance criteria:

```markdown
### Property 1.1: Token Reversibility
**Validates**: Requirements 2.3 (Token validation)

**Specification**: 
For any valid user ID, decoding an encoded token returns the original user ID.

**Example**:
```typescript
const userId = "user123";
const token = generateToken(userId);
const decoded = validateToken(token);
expect(decoded.userId).toBe(userId);
```

**Test Strategy**:
- Generate random user IDs
- Generate tokens for each
- Verify decoding returns original ID
```

## Property Test Template

```typescript
describe('Property: {Property Name}', () => {
  it('validates: Requirements {X.Y}', () => {
    fc.assert(
      fc.property(
        // Generators
        generator1,
        generator2,
        
        // Test function
        (input1, input2) => {
          // Preconditions (optional)
          fc.pre(isValid(input1));
          
          // Arrange
          const setup = prepareTest(input1, input2);
          
          // Act
          const result = functionUnderTest(setup);
          
          // Assert - verify property holds
          expect(result).toSatisfy(property);
        }
      ),
      {
        numRuns: 1000,
        seed: 42 // For reproducibility
      }
    );
  });
});
```

## Triaging Counter-Examples

When a property test fails, you get a counter-example. Determine:

### 1. Test is Incorrect
The property specification is wrong.

**Symptoms**:
- Property doesn't match requirements
- Property is too strong
- Test logic has bugs

**Action**: Fix the test

### 2. Code Has a Bug
The implementation doesn't satisfy the property.

**Symptoms**:
- Property matches requirements
- Counter-example reveals unexpected behavior
- Bug is reproducible

**Action**: Fix the code

### 3. Specification is Unclear
The requirements are incomplete or ambiguous.

**Symptoms**:
- Property is technically correct
- But behavior seems wrong
- Requirements don't cover this case

**Action**: Ask user for clarification

**Example**:
```typescript
// Property: Division is reversible
expect(divide(multiply(a, b), b)).toBe(a);

// Counter-example: a=1, b=3
// Result: 0.9999999999 !== 1

// Diagnosis: Specification unclear about floating-point precision
// Action: Ask user about acceptable precision tolerance
```

## Testing Frameworks

### JavaScript/TypeScript

**fast-check** (recommended):
```typescript
import fc from 'fast-check';

describe('Properties', () => {
  it('addition is commutative', () => {
    fc.assert(
      fc.property(fc.integer(), fc.integer(), (a, b) => {
        expect(add(a, b)).toBe(add(b, a));
      })
    );
  });
});
```

**jsverify**:
```typescript
import jsc from 'jsverify';

describe('Properties', () => {
  it('addition is commutative', () => {
    jsc.assert(
      jsc.forall(jsc.integer, jsc.integer, (a, b) => {
        return add(a, b) === add(b, a);
      })
    );
  });
});
```

### Python

**Hypothesis**:
```python
from hypothesis import given
from hypothesis.strategies import integers

@given(integers(), integers())
def test_addition_commutative(a, b):
    assert add(a, b) == add(b, a)
```

### Java

**jqwik**:
```java
@Property
boolean additionIsCommutative(@ForAll int a, @ForAll int b) {
    return add(a, b) == add(b, a);
}
```

## Integration with Spec Workflow

### In Design Document

Define properties clearly:
```markdown
### Property 1.1: Token Reversibility
**Validates**: Requirements 2.3
**Specification**: decode(encode(userId)) === userId
**Test Strategy**: Generate random user IDs, verify reversibility
```

### In Task List

Create specific tasks:
```markdown
- [ ] 3.2 Write property-based test for Property 1.1
  - Implement test validating token reversibility
  - Create user ID generator
  - Verify property holds across 1000 generated inputs
```

### During Execution

1. Read the property from design.md
2. Implement the test
3. Run the test
4. Update PBT status using `updatePBTStatus` tool
5. If fails, triage counter-example
6. Fix code or test as needed

## Best Practices Summary

### DO
- ✅ Test universal properties, not specific examples
- ✅ Use appropriate number of test runs
- ✅ Leverage shrinking to find minimal failures
- ✅ Link properties to requirements
- ✅ Use smart generators constrained to valid inputs
- ✅ Combine with unit tests for comprehensive coverage

### DON'T
- ❌ Test implementation details
- ❌ Use mocks to make properties pass
- ❌ Ignore failing counter-examples
- ❌ Write properties that are too weak or too strong
- ❌ Skip property tests - they're essential
- ❌ Generate invalid inputs (unless testing error handling)

## Conclusion

Property-based testing is a powerful technique for validating software correctness. By defining and testing universal properties, you create formal specifications that provide strong guarantees about system behavior. Combined with traditional unit tests, property-based tests form a comprehensive testing strategy that catches bugs and documents expected behavior.

Remember: Properties are not just tests - they're executable specifications that describe what your software should always do.
