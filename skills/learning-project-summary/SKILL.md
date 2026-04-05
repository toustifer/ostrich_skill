---
name: learning-project-summary
description: "Create and update structured learning-project markdown in the user's learning workspace. Use when the user wants to create a new project summary, add or update goal pages, maintain goal status, or keep learning-project notes aligned with the workspace spec."
---

# Learning Project Summary

Use this skill to write project-learning cards into the user's learning workspace.

## Scope

- Only write under the user's learning-project workspace root.
- Treat the workspace spec markdown in that root as the source of truth.
- Follow the directory structure, field order, and writing style from that spec.
- Preserve existing content unless the user explicitly asks to rewrite or replace it.

## Required first step

Before creating or editing any file:

1. Find the learning workspace root the user is referring to.
2. If the user has not set up a local markdown workspace yet, ask them to choose or install a suitable local note application, such as Obsidian, and then provide the workspace root.
3. Read the spec markdown in that root.
4. Use that spec to drive all new structure and templates.

If the spec and an existing project file conflict, prefer:

1. explicit user instruction
2. existing user-written content
3. the spec for all new structure and new sections

## Workflow

1. Resolve the target project under the learning workspace root.
2. Check whether the project already exists.
3. If it does not exist, create the standard skeleton from the spec.
4. If it exists, update only the requested sections.
5. Keep folder names, filenames, and H1 titles identical.
6. Keep markdown simple and readable.

## Supported operations

### Create a new project skeleton

Create the standard project root page and goal index page defined by the spec.

If the user provides initial goals, also create one goal detail page per goal.

### Add a learning goal

When the project already exists and the user adds a goal:

- append the goal to the goal index checklist
- create the goal detail page if missing

### Update an existing project

Allowed updates include:

- project status
- project description
- motivation
- expected capability
- weak points
- goal status
- completion criteria
- current experience
- necessity
- checklist items

## Writing rules

- Write from a personal growth perspective, not as official documentation.
- Prefer short, clear sections over long reports.
- Keep project pages high-level.
- Keep the goal index page as a checklist page only.
- Keep each goal page focused on ability building and completion criteria.
- Do not create README, changelog, installation guide, or extra helper files.

## Guardrails

- Do not invent a new directory structure.
- Do not rename folders or files away from the spec.
- Do not overwrite whole files when a targeted append or section update is enough.
- Do not create technical deep-dives unless the user explicitly asks for them.
- Do not write outside the learning workspace root.

## Expected requests

This skill should trigger for prompts like:

- "Use learning-project-summary to create a learning project summary"
- "Build the project skeleton in the learning workspace"
- "Add a few goal pages for this project"
- "Update the weak points and completion criteria"
- "Organize this project according to the workspace spec"
