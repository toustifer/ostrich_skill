# Explanation Patterns

## Concept Bridge Template

Use this structure when introducing something new:

- What it is: one sentence
- Why it exists here: one sentence tied to the project
- What to look at: one file or one request path

Example:
- What it is: "A FastAPI router is the HTTP entry point."
- Why it exists here: "It keeps request parsing separate from business rules."
- What to look at: "Start at `api/routes/tasks.py`, then follow the call into `services/task_service.py`."

## Good Comparisons

Use comparisons to known ideas:
- React component: "like a UI building block"
- React hook: "logic extracted so the component stays readable"
- FastAPI router: "the endpoint door"
- service layer: "the place where the business rule lives"
- repository: "the part that knows how to talk to storage"
- Supabase RLS: "database-side permission checks"

## Scope Control

If the user did not ask for depth, explain only:
- the current goal
- the current pattern
- the next thing to notice

If the user asks "why" again, then go one layer deeper.

## Project Walkthrough Order

For a new project, explain in this order:

1. app entry point
2. route or page entry point
3. request or data flow
4. feature module boundaries
5. helper details

## Good End-Of-Step Summary

Use a short wrap-up:
- "What you should take away: pages compose, hooks coordinate, services fetch."
- "The main idea here: the backend decides rules, the frontend decides presentation."
- "The key pattern: keep the DB query out of the route so the endpoint stays thin."
