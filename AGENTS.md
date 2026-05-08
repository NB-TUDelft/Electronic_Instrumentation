# Repository instructions for AI agents

These rules apply to any AI assistant (Claude Code, Cursor, Copilot, Codex, etc.) when generating, editing, or reviewing prose in this repository (notebooks, README, comments, docstrings, commit messages, PR descriptions).

## Punctuation: no em or en dashes

**Do not use em dashes (`—`, U+2014) or en dashes (`–`, U+2013) anywhere in prose.**

When you would naturally reach for one, choose one of:

1. A comma, when the inserted clause is parenthetical.
2. A colon, when introducing a list, definition, or explanation.
3. A semicolon, when joining two related independent clauses.
4. A period, splitting into two sentences.
5. Parentheses, for asides.

**Do not substitute a regular hyphen (`-`) for an em or en dash either.** A hyphen is only correct in:

- Compound modifiers and compound nouns: `current-correct`, `voltage-correct`, `2-wire`, `5-1/2-digit`, `BNC-to-banana`, `Y-Δ`, `cross-check`.
- Markdown bullet lists (`- item`).
- Markdown horizontal rules (`---`).
- YAML separators inside MyST/Jupyter Book figure directives (`---`).
- Math expressions and identifiers (minus signs, negative exponents).

### Replacements for common dash idioms

| Dash usage | Replace with |
|---|---|
| `1–2 %`, `Tasks I1–I5`, `pages 10–14` | `1 to 2 %`, `Tasks I1 to I5`, `pages 10 to 14` |
| `voltmeter–ammeter`, `series–parallel` | `voltmeter and ammeter`, `series-parallel` (regular hyphen, since these are compound modifiers) |
| `... briefly — keep ...` | `... briefly. Keep ...` |
| `... node N — having a name ...` | `... node N. Having a name ...` |
| `e.g. — about 0.43 V` | `e.g., about 0.43 V` |

### Quick self-check before saving

Before writing or committing a file, search your output for the literal characters `—` and `–`. If either appears outside of a code block, math, or a quoted external source, rewrite that sentence.

## Other writing conventions

- Use straight quotes (`"`, `'`), not typographic quotes (`"`, `"`, `'`, `'`).
- Use `e.g.` and `i.e.` followed by a comma.
- Prefer short sentences over long ones connected by stacked clauses; this also makes it easier to avoid dashes.
- In notebooks, keep the existing voice: instructional, second-person ("you"), present tense.

## Scope

These rules govern *all* prose. They do require rewriting historical content the user has not asked to touch. If you are already editing a paragraph, fix any dashes you encounter in it. Only leave these untouched if user strictly requested that.
