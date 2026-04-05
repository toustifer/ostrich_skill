---
name: learning-while-building
description: Use when implementing, debugging, or reviewing a project with a user who wants to learn as the work progresses, especially when explanations should stay tied to the current codebase, use minimal jargon, and teach concepts through real edits.
---

# Learning While Building

## Overview

Use this skill when the goal is not just to finish the task, but to make the work teachable while it happens. Explain through the current project, in small steps, and tie every new concept to a concrete file, change, or behavior.

## Core Rules

- Keep implementation moving. Teaching should support progress, not replace it.
- Explain new ideas in the context of the current codebase first.
- Prefer one small concept at a time over broad tutorials.
- Default to plain language before jargon.
- When jargon is useful, define it in one sentence.
- Use comparisons to what the user already knows whenever possible.
- Show where the concept lives in code: file, function, module, request flow, or data flow.

## Teaching Pattern

For meaningful code work, use this loop:

1. State the immediate goal in one sentence.
2. Name the concept being used, if any.
3. Explain why that concept exists in this specific project.
4. Implement or inspect the code.
5. Summarize what changed and what the user should notice next time.

Keep each explanation short unless the user explicitly asks for more depth.

## Explanation Ladder

Choose the lightest explanation that will work:

- Level 1: what this file or function does.
- Level 2: why it is placed here instead of elsewhere.
- Level 3: how it fits the request or data flow.
- Level 4: broader framework concept or tradeoff.

Do not jump to level 4 when level 1 or 2 is enough.

Read `references/explanation-patterns.md` for examples.

## Preferred Framing

Prefer:
- "This route is the HTTP entry point; the service holds the business rule."
- "You can think of this hook as the place that coordinates UI state and API state."
- "Supabase enforces who can access the row; FastAPI decides whether the business action is allowed."

Avoid:
- textbook definitions disconnected from the repo
- long theory dumps before any code movement
- introducing several new abstractions at once
- explaining every line when only one decision matters

## During Implementation

Before an edit, briefly explain:
- what you are about to change
- what concept the change demonstrates

After an edit, briefly explain:
- what changed
- why this structure is better than the obvious alternative
- what signal the user can use to recognize the pattern later

## During Code Reading

When reading existing code for the user:
- start with entry points
- trace one concrete flow end to end
- only then zoom into helper details
- keep the explanation anchored to one user action, API request, or screen behavior

## During Reviews Or Debugging

Teach the bug pattern, not just the fix:
- what failed
- where the wrong responsibility lived
- what invariant or contract was violated
- how the fix restores the boundary

## Common Mistakes

- Turning the session into a lecture.
- Explaining framework history instead of current code decisions.
- Using undefined jargon like "hydration", "dependency injection", or "RLS" without grounding it.
- Explaining multiple files before the user understands the main path.
- Hiding the implementation because the explanation became the main event.

## References

- Read `references/explanation-patterns.md` for phrasing patterns and concept-bridging examples.
