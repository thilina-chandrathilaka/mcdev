---
name: spec-property-testing
description: Writes property-based tests for correctness properties defined in spec design documents. Use when implementing a property test task, validating a design property, writing PBT, or when tasks.md or design.md reference "Property X.Y" or "property-based test".
---

# Spec Property-Based Testing

Validates **correctness properties** from `.cursor/specs/[feature-name]/design.md` using property-based tests. Use when implementing a task that "Validates: Property X.Y from design" or when the user asks for property-based tests for a spec.

## When to use this skill

- Task in tasks.md is a "Property test for Property X.Y" or "Validates: Property X.Y".
- Design defines a property (reversibility, idempotence, invariant, commutativity, associativity) and you need to implement the test.

## Workflow

1. **Read the property** from design.md (Property X.Y: specification, example, test strategy).
2. **Implement the test** using the project's PBT framework (e.g. fast-check, Hypothesis, jqwik). Create input generators for valid inputs; assert the property holds.
3. **Run many iterations** (e.g. 1000–10000). If it fails, triage the counter-example: fix the code or fix the test.
4. **State traceability**: "This validates Property X.Y from the design."

## Property categories (from design)

- **Reversibility**: `decode(encode(x)) === x`
- **Idempotence**: `f(f(x)) === f(x)`
- **Invariants**: e.g. `length(concat(a,b)) === length(a) + length(b)`
- **Commutativity**: `f(a,b) === f(b,a)`
- **Associativity**: `f(f(a,b),c) === f(a,f(b,c))`

