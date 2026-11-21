---
summary: >-
  Notebook file names, internal working files (_*.md) and plan documents,
  manual titles, task labels and cross-references, and figure names.
  AGENTS.md section 5 before the split.
---

# Naming conventions

* **Notebook file names**: `<week>.<manual>_<descriptive_snake_case>.ipynb`, e.g. `1.1_voltage_divider.ipynb`, `4.2_real_opamps.ipynb`.
* **Internal working files**: any file you create for your own use rather than for publication (plans, scoping notes, triage tables, research summaries, drafts, TODO lists, review reports) **must** be a Markdown file whose name starts with an underscore, i.e. it matches `_*.md`. That pattern is gitignored, so these files stay local and never reach the published book or the repository history. Never write internal notes to a name that does not match `_*.md`, and never put them in a scratch directory outside the repository.
* **Plan documents** follow `_plan_<week>.<manual>_<descriptive_snake_case>.md` and live in the week folder they belong to, next to the notebook they plan. Current examples: [book/manuals/week5/_plan_5.2_wheatstone_bridge.md](../../../book/manuals/week5/_plan_5.2_wheatstone_bridge.md) and [book/manuals/week6/_plan_6.1_relaxation_oscillator.md](../../../book/manuals/week6/_plan_6.1_relaxation_oscillator.md). For internal files that are not tied to one manual, still lead with the underscore, e.g. `_notes_bom_week7.md`.
* **Manual titles**: keep the H1 short and concrete, similar to week 1 and week 2 titles.
* **Task labels** (MyST anchors): `(Task_<Section><N>_<Week>_<Manual>)=` placed on a line of its own immediately before the task heading. Sections are `A`, `S`, `I`, `C`, `B`. So Task A2 of week 4 manual 1 is `(Task_A2_4_1)=`.
* **Cross-references between tasks** use the inline link form: `[Task A1](Task_A1_4_1)`.
* **Figure names** use kebab-case with a topical prefix: `name: fig-non-inverting-amp`, `name: fig-tl072-pinout`. Always include a `height:` (typically 300 to 400 px) and a one-line caption underneath the YAML block.
