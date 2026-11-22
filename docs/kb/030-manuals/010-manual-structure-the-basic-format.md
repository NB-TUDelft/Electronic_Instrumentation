---
summary: >-
  Every weekly manual follows Background, Anticipate, Simulate, Implement
  and Investigate, Compare and Conclude, with task names, modes, and time
  budgets; pair and group work; the CORE, TRANSFERABLE, NICE, and OMIT plan
  tags. AGENTS.md section 2 before the split.
always_read: true
---

# Manual structure (the BASIC format)

Every weekly manual follows the same five-phase pattern. Use this for every new manual you draft.

| Phase | Mode | Time budget | Tasks named |
| --- | --- | --- | --- |
| **Background** | individual, BAS (homework) | a few minutes of reading | `B1`, `B2`, ...(task numbers, Not mandatory but can be used to improve readibility) |
| **Anticipate** | individual, BAS | typically 30 to 60 min total | `A1`, `A2`, ... |
| **Simulate** (LTspice or Python) | individual, BAS | typically 20 to 60 min total | `S1`, `S2`, ... |
| **Implement and Investigate** (use full name not one with "&" nor I&I nor InI) | pairs, IC (in-class) | typically 90 to 130 min total | `I1`, `I2`, ... |
| **Compare and Conclude** (use full name not one with "&" nor C&C nor CnC) | groups of four, IC | typically 20 to 30 min | `C1`, `C2`, ... |

The full Background through Simulate part is **homework**, capped at about **2 hours** per manual. The Implement, Investigate, Compare, Conclude part is in-class and budgeted for about **2.5 hours** of active work inside a **3 hour** practicum block (the extra 30 min is buffer for assembly trouble and writing up the onepager).

A teaching week typically has **two manuals** (`X.1` and `X.2`), one per practicum block.

## Pair work and group work

* The "How To Work" admonition at the top of every manual states that BAS is individual and IC is in pairs. It is one shared template, `book/manuals/tpl/how_to_work.md`, which every manual pulls in with `{include}` (see Shared templates under Authoring). Change its wording there, never in a single notebook.
* When you write the IC tasks, suggest a concrete way to share the load between the two students: "one student builds, the other configures the scope, then swap roles for the next task". Do not just say "work together".
* Compare and Conclude is reviewed at the table (groups of four) before a TA check-off.

## Available task tags (write them in the plan, not in the published task)

When triaging or scoping content (e.g., in the plan documents under `book/manuals/weekX/_plan_*.md`), use these tags:

* **CORE** must keep, central to the topic;
* **TRANSFERABLE** teaches a general lab or problem-solving skill (hypothesis, calibration, datasheet reading, error analysis);
* **NICE** keep if the budget allows, otherwise move to a Deep dive dropdown;
* **OMIT** redundant with the textbook, with another week, or platform-specific cruft.

These tags do not appear in the published manuals. They are a planning aid.
