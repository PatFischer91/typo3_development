---
description: >
  Run the TYPO3 code-simplifier agent. Defaults to changed files but supports interactive scope selection:
  changed files, specific directory, specific files, or whole repository. Also supports interactive goals selection:
  formatting-only, readability refactor, TYPO3 best practices alignment, security-focused pass, or full pass.
  Offers /typo3:init when CLAUDE.md is missing.
allowed-tools: Read, Glob, Grep, Bash, Edit
---

# /typo3:code-simplify

Purpose:
- Manually run the TYPO3 Code Simplifier Agent with a user-chosen scope and simplification goals.
- Preserve behavior and produce a detailed report.

## Step 0: CLAUDE.md bootstrap (mandatory)

1) Check if `CLAUDE.md` exists in the repository root.
2) If it exists:
    - Read it fully.
    - Follow its rules.
3) If it does not exist:
    - Ask the user:
      "CLAUDE.md is missing. Should we run /typo3:init first (recommended)?"
    - If yes:
        - Instruct user to run `/typo3:init`.
        - After it exists, read `CLAUDE.md`, then continue.
    - If no:
        - Continue with safe defaults and explicitly report that CLAUDE.md was missing.

## Step 1: Scope selection (interactive)

If the user provided scope arguments in $ARGUMENTS, use them.
If $ARGUMENTS is empty or unclear, ask the user:

"What should I simplify?"
- A) Changed files only (recommended)
- B) A specific directory
- C) Specific file(s)
- D) The whole repository

If A:
- Use Git changed files:
    - `git status --porcelain`
    - `git diff --name-only`
    - `git diff --name-only --staged`

If B:
- Ask for one or more directory paths (repeatable), for example:
  `Classes/Service`, `Classes/Controller`, `Configuration/`, `Resources/Private/`

If C:
- Ask for file paths (one per line).
- Validate each path exists (best-effort with Read/Grep/Glob).

If D:
- Confirm default exclusions:
    - exclude `vendor/`, caches, generated artifacts by default
- Ask whether to limit to certain file types.

## Step 2: Goals selection (interactive)

If the user provided goal arguments in $ARGUMENTS, use them.
If goal is not specified, ask:

"What kind of simplification do you want?"
- 1) Formatting and consistency only
- 2) Readability refactors
- 3) TYPO3 best practices alignment
- 4) Security-focused pass
- 5) Full pass (1 + 2 + 3 + 4), conservative edits plus proposals

Default if user does not choose:
- Goal 5 (full pass), conservative edits, proposals for risky items

## Step 3: Execution

- Invoke the agent: `code-simplifier`.
- Provide it:
    - CLAUDE.md status (present or missing)
    - the chosen scope mode
    - the list of files or directories
    - include/exclude filters and file type filters
    - the chosen goals mode
- The agent must print a short scope and goals summary before applying edits.

## Step 4: Output

- Always produce a "TYPO3 Code Simplification Report" with:
    - project context (TYPO3 version, CLAUDE.md status)
    - scope and goals summary
    - applied changes
    - proposals not applied
    - security notes
    - follow-up recommendations

## Arguments

You may pass scope and goals via $ARGUMENTS.

Scope patterns:
- `changed`
  Meaning: changed files only (default)
- `dir:<path>`
  Meaning: simplify everything under the given directory (repeatable)
- `file:<path>`
  Meaning: simplify a single file (repeatable)
- `repo`
  Meaning: simplify the whole repository (with default exclusions)

Goals patterns:
- `goal:format`
  Meaning: formatting and consistency only
- `goal:refactor`
  Meaning: readability refactors only
- `goal:typo3`
  Meaning: TYPO3 best practices alignment (DI, QueryBuilder, Extbase/Fluid correctness)
- `goal:security`
  Meaning: security-focused pass
- `goal:full`
  Meaning: full pass

Examples:
- `/typo3:code-simplify changed goal:full`
- `/typo3:code-simplify dir:Classes/Service goal:typo3`
- `/typo3:code-simplify file:Classes/Controller/FooController.php goal:refactor`
- `/typo3:code-simplify repo goal:security`
