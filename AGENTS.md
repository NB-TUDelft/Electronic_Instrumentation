# Repository instructions for AI agents

These rules apply to any AI assistant (Claude Code, Cursor, Copilot, Codex, etc.) when generating, editing, or reviewing content in this repository (notebooks, README, prose, code comments, docstrings, commit messages, PR descriptions).

The first half of this file gives you the project context every change should be aligned with: what the course is, who the audience is, what counts as "good", and where things live. The second half gives you the strict prose rules (punctuation, voice, etc.) that have been here from the start.

## 0. Repository map

This file conatins a map of the repository, with links to the relevant sections of the manual. If u need to have deeper knowladge please use graphify (https://github.com/Graphify-Labs/graphify) if it is avaliabe on system. If not prompt user to agree upon setting it up as uv tool with [all] option. If user agrees execute instalation for them. The generated graph is pyshed and avaliable for u even if they refuse.

## 0.1 Git synchronization

Before beginning any user-requested repository work, fetch every configured remote with `git fetch --all --prune`. Check the current branch, its configured upstream, and the worktree state. Preserve all existing staged, unstaged, and untracked user changes.

Bring the current branch up to date with its configured upstream before editing:

* If the branch is only behind, use `git merge --ff-only @{upstream}`.
* If the branch has diverged and its local commits have not been pushed, rebase those commits onto the upstream branch to keep history linear.
* Do not create a merge commit solely to synchronize the branch.
* If there is no configured upstream, local changes prevent safe integration, conflicts occur, or rebasing would rewrite shared commits, stop and ask the user how to proceed.

Immediately before every push, repeat the fetch and synchronization check. Push only when the local branch contains the latest upstream state. Prefer a fast-forward update or a safe rebase of unpushed commits so routine agent work does not introduce avoidable conflicts or nonlinear history.

## 1. What this repository is

This is the source for the practicum manuals of **NB2420 Electronic Instrumentation**, a second-year course in the **Nanobiology BSc programme** (TU Delft and Erasmus MC). The published artefact is a Jupyter Book ("TeachBook") that students read online and, when they need ALPACA hardware access, also run as notebooks on their laptops.

The book is built into HTML and served from the `book/` folder. Everything you write must build cleanly with `jupyter-book build book/` and render correctly in both light and dark theme.

### Course goals, in priority order

1. **Transferable problem-solving and lab skills.** Predict before you measure. Reconcile prediction with simulation with measurement. Read a datasheet. Pick the test condition that isolates the parameter you want. Document numbers and reasoning so a future you (or a teammate) can follow them. These skills are the primary outcome.

2. **Basic electronics fluency.** Ohm's law, Kirchhoff, voltage and current dividers, RC and RL circuits, Bode plots, opamp configurations, non-idealities, sensors, microcontrollers, noise. The electronics is the vehicle, not the destination.

3. **Problem-solving based.** Every cell either asks a question, sets up a measurement, or scaffolds a comparison. The book is not a concept dump.

When you make a pedagogical trade-off, the priority order above breaks the tie: a transferable skill survives a content cut before a "nice to know" fact does.

### Audience

* Second-year Nanobiology students. Most have no prior electronics background.
* Working in pairs at the bench, in groups of four around a table for the comparison phase, and individually for homework.
* Evaluated by Teaching Assistants via a Scientific Graphical Organizer (SGO) on BrightSpace.

## 2. Manual structure (the BASIC format)

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

### Pair work and group work

* The "How To Work" admonition at the top of every manual states that BAS is individual and IC is in pairs.
* When you write the IC tasks, suggest a concrete way to share the load between the two students: "one student builds, the other configures the scope, then swap roles for the next task". Do not just say "work together".
* Compare and Conclude is reviewed at the table (groups of four) before a TA check-off.

### Available task tags (write them in the plan, not in the published task)

When triaging or scoping content (e.g., in the plan documents under `book/manuals/weekX/_plan_*.md`), use these tags:

* **CORE** must keep, central to the topic;
* **TRANSFERABLE** teaches a general lab or problem-solving skill (hypothesis, calibration, datasheet reading, error analysis);
* **NICE** keep if the budget allows, otherwise move to a Deep dive dropdown;
* **OMIT** redundant with the textbook, with another week, or platform-specific cruft.

These tags do not appear in the published manuals. They are a planning aid.

## 3. Repository layout

```text
book/                              # Jupyter Book source; this is what gets published
  _config.yml                      # build configuration
  _toc.yml                         # publication order; every new manual must be listed
  static/                          # global CSS, JS, icons, downloads
    global.css                     # custom admonition colours and other overrides
  manuals/
    intros/                        # equipment and tooling intros (alpaca, breadboard, scope, ...)
    week1/                         # week-specific manuals + local images/
      _summary.ipynb               # short landing page for the week
      1.1_voltage_divider.ipynb
      1.2_intro_to_oscilloscope_and_filters.ipynb
      _plan_*.md                   # internal plan notes; gitignored, never published
      images/
    week2/                         # ... same pattern
    ...
    week8/
  miscellaneous/
    intro.md                       # book landing page (root of the TOC)
    admonitions.md                 # gallery of admonition types in use
    appendix/                      # cross-week reference material (e.g., resistance.ipynb)
old/                               # legacy manuals (12A, 13A, ...) kept for reference, do not edit
.venv/                             # local virtualenv created by the user
README.md
AGENTS.md                          # this file
```

### Folder responsibilities

* **`book/`** is the only directory that ships. Anything outside `book/` is either author-facing reference (`helpers/`, `old/`) or build infrastructure.
* **`book/manuals/intros/`** is for tooling and equipment intros that are reused across weeks (DMM, scope, ALPACA, breadboard, LTspice, ...). Reference these from week manuals via the "Preparation" admonition, do not re-explain the equipment in every week.
* **`book/manuals/weekX/`** holds one folder per teaching week. Each week folder contains a `_summary.ipynb`, the numbered manuals (`X.1_*.ipynb`, `X.2_*.ipynb`), and an `images/` subfolder for assets that belong to that week only.
* **`helpers/theory_part/`** is the **textbook source**. Treat it as the canonical theory reference. Lab manuals should refer the student back to it for derivations and proofs, and should not duplicate them. When the textbook covers a concept that students nevertheless trip on (virtual ground, the "+1" in non-inverting gain, dB and decade, BW = GBW / (1 + closed-loop gain) for non-inverting amps), re-explain it briefly in the manual where it is used, and link to the textbook for the full version. Three chapters are still **stubs** (`6_transistor.md`, `9_sensors.md`, `11_noise_interference.md`); if a manual depends on those topics, the manual itself has to carry the theory until the textbook catches up.
* **`helpers/ei_helpers/`** is legacy bench-side reference: vendor textbooks, schematics for the old test boards, Multisim files, scanned photographs. Use it to understand what the legacy lab looked like; **do not** copy testboard schematics directly into a new manual since the test boards are being phased out.
* **`helpers/belay/voltammetry/`** is **Krzysztof's' Belay-based voltammetry rig** for an Electronic Instrumentation report on the ALPACA platform. **Belay** ([belay.readthedocs.io](https://belay.readthedocs.io/)) is a third-party Python library by Brian Pugh that lets host code transparently run slices on a MicroPython device via decorators (`@device.setup`, `@device.task`, `@device.teardown`). It is **not** custom firmware and **not** part of the standard ALPACA toolchain. The folder contains a working 3-electrode potentiostat (MCP4822 DAC over SPI1, three Pico ADCs, two TL072 op-amps with transimpedance feedback), a single `voltammetry.py` driver, and a 600-line `CLAUDE.md` documenting hardware pinout, Belay gotchas, and a diagnostic playbook (binary I-V jump = OPAMP1 feedback open; pinned ADC currents = saturation, with formulas; >18 mV DAC-B sag = fault indicator). **Read this when authoring future complex-systems / colorimeter / voltammetry manuals (textbook chapter 10).** The ALPACA standard student stack is just MicroPython on the Pico; Belay is only used when an experiment needs to ship on-device task code from the host.
* **`old/`** holds legacy manuals (e.g., `EI_manuals/12A_*.ipynb`) used as source material when authoring the new ones. Do not edit; treat as read-only reference.

### High-value items inside `helpers/` worth knowing about

The `helpers/` catalogue may be unavailable in some users' local checkouts. Check that a referenced path exists before relying on it. If it is unavailable, continue with the sources that are present and tell the user which helper reference you could not consult. Do not treat the missing catalogue as a repository error or invent its contents.

When a manual needs a schematic, a worked example, a photograph, an exercise idea, or an original explanation, look here before drawing or writing anything new.

* **`helpers/theory_part/images/standard_symbols/`** is the canonical schematic-symbol library for this book: battery, ideal voltage / current source, AC source, ammeter, voltmeter, resistor, capacitor (polarised and not), inductor, diode, LED, LDR, multiple GND symbols, switches, coax, crossings, junction dots. **Reuse these SVGs in new manuals** instead of drawing new symbols. The list of symbols and the conventions around them (V vs U, lowercase vs uppercase, European vs American conventions) is documented in [helpers/theory_part/0_symbols_and_conventions.md](helpers/theory_part/0_symbols_and_conventions.md).
* **`helpers/theory_part/textbook layout.txt`** is the canonical author-side TOC for the whole textbook, in mixed Dutch and English. Each chapter is structured as A (natuurkunde / physics), B (elektronica theoretisch), C (praktisch / lab and instrument), D (examples / context), E (exercises). When you write a manual for chapter N, this file tells you which sub-section the textbook is meant to cover and which is left to the lab manual.
* **`helpers/theory_part/2_resistor.ipynb`** and **`helpers/theory_part/3_capacitor.ipynb`** are interactive companions to chapters 2 and 3. If a homework task needs an interactive plot (RC step response, Bode plot, Thevenin equivalent calculator), check here first; the notebook code is reusable.
* **`helpers/theory_part/template-chapter.md`** and **`template-subchapter.md`** are the boilerplate for new textbook chapters and include working examples of `note`, `tip`, `warning`, and `exercise` admonitions. Use them as a reference when you need to add a new theory section, not when writing a lab manual (the lab template lives in [book/manuals/week1/1.1_voltage_divider.ipynb](book/manuals/week1/1.1_voltage_divider.ipynb)).
* **`helpers/theory_part/images/images_<N>/Reference/`** holds the raw drawings and scanned exercises that the chapter authors used. Several chapters (especially 4, 5, 7, 10) include hand-drawn working examples and scanned exercise sheets that the manual authors sometimes want to redraw or reuse. Chapter 7 has 55 reference images; chapter 5 has 41.
* **`helpers/ei_helpers/Practical Electronics for Inventors.pdf`** is Scherz's full reference. Useful when a manual needs a worked example or a piece of practical advice (decoupling, scope hygiene, soldering) that the in-house textbook does not cover.
* **`helpers/ei_helpers/Zbiór zadań z elektrotechniki ... pdf`** is a 290 MB Polish problem-set book. If the user asks for "a few extra exercises" on a topic, this is the source mine.
* **`helpers/ei_helpers/EI testboards/schemas/`** has the schematics for legacy test boards 1, 2, 3, 4, 5, 7, 15. If a legacy old/EI_manuals notebook references "test board 4", the schematic is here. Do **not** include these in new manuals; the boards are going away.
* **`helpers/ei_helpers/Alpaca + Cria pictures.pdf`** has the only existing photographic record of the legacy ALPACA + CRIA combo. Use it when a new manual mentions ALPACA pinout that has not changed across revisions.
* **`helpers/belay/voltammetry/CLAUDE.md`** has the only diagnostic playbook anywhere in the repository for the 3-electrode potentiostat circuit. The numbers (`I_min_uA = -V_WE_v / Rf * 1e6`, `I_max_uA = (3 / gain - V_WE_v) / Rf * 1e6`, `f_c = 1 / (2 pi Rf C) ~ 219 Hz` for default values) and failure-mode signatures (binary jumps, ADC clipping, DAC-B sag) are directly applicable to any future voltammetry / colorimetry manual.

## 4. Hardware platform

* The teaching hardware is **ALPACA**, a custom RPi Pico based board with an on-board breadboard, decoupling, attenuation front-end, DAC, and ADC. A new revision is currently in development.
* Bench instruments around the ALPACA: dual-rail bench supply ($\pm 12\,\mathrm{V}$ typical), function generator, bench oscilloscope, $5\,\mathrm{1/2}$ digit DMM.
* The legacy **test boards** are being phased out. New manuals build circuits from scratch on the ALPACA breadboard. Reuse of the legacy testboard Fritzing diagrams is therefore not appropriate.
* Provide circuit schematics and conceptual diagrams, not proposed breadboard layouts. Students should translate the schematic to the ALPACA breadboard as part of problem-based e-learning. Only include breadboard photos when they document fixed hardware orientation or safety-critical pin locations, not as step-by-step layouts.
* Software for student-side automation: **MicroPython** on the Pico. Where a manual needs to ship a tight sampling loop or a long automated sweep on the device, the [Belay](https://belay.readthedocs.io/) Python library is the recommended host-to-Pico bridge (see [helpers/belay/voltammetry/](helpers/belay/voltammetry/) for a working example). LTspice is the simulator.
* If a manual needs an extra bulk component (an opamp, a photodiode, a special capacitor), add it to a Bill of Materials section in the manual's plan document; the user will order it.

## 5. Naming conventions

* **Notebook file names**: `<week>.<manual>_<descriptive_snake_case>.ipynb`, e.g. `1.1_voltage_divider.ipynb`, `4.2_real_opamps.ipynb`.
* **Internal working files**: any file you create for your own use rather than for publication (plans, scoping notes, triage tables, research summaries, drafts, TODO lists, review reports) **must** be a Markdown file whose name starts with an underscore, i.e. it matches `_*.md`. That pattern is gitignored, so these files stay local and never reach the published book or the repository history. Never write internal notes to a name that does not match `_*.md`, and never put them in a scratch directory outside the repository.
* **Plan documents** follow `_plan_<week>.<manual>_<descriptive_snake_case>.md` and live in the week folder they belong to, next to the notebook they plan. Current examples: [book/manuals/week5/_plan_5.2_wheatstone_bridge.md](book/manuals/week5/_plan_5.2_wheatstone_bridge.md) and [book/manuals/week6/_plan_6.1_relaxation_oscillator.md](book/manuals/week6/_plan_6.1_relaxation_oscillator.md). For internal files that are not tied to one manual, still lead with the underscore, e.g. `_notes_bom_week7.md`.
* **Manual titles**: keep the H1 short and concrete, similar to week 1 and week 2 titles.
* **Task labels** (MyST anchors): `(Task_<Section><N>_<Week>_<Manual>)=` placed on a line of its own immediately before the task heading. Sections are `A`, `S`, `I`, `C`, `B`. So Task A2 of week 4 manual 1 is `(Task_A2_4_1)=`.
* **Cross-references between tasks** use the inline link form: `[Task A1](Task_A1_4_1)`.
* **Figure names** use kebab-case with a topical prefix: `name: fig-non-inverting-amp`, `name: fig-tl072-pinout`. Always include a `height:` (typically 300 to 400 px) and a one-line caption underneath the YAML block.

## 6. Style conventions

### Voice and tone

* Second-person, present tense, instructional. "You wire pin 4 to the negative rail" rather than "the student wires pin 4".
* Short sentences, one idea per sentence. Stacked clauses make it harder both to read and to avoid the forbidden dashes (see section 11).
* Each cell either teaches one idea, asks one question, or scaffolds one measurement. Do not pile.

### Math

* Inline math uses single dollars: `$U_{out}$`, `$R_1 = 100\,\Omega$`.
* Display math uses double dollars on their own lines.
* Units always go in `\,\mathrm{...}` with a thin space: `5\,\mathrm{V}`, `1\,\mathrm{k}\Omega`, `100\,\mathrm{Hz}`, `0.5\,\mathrm{V/\mu s}`. Do not write `5V` or `5 V` in math.
* Use `U` for voltage symbols and `I` for currents (matching the textbook), with subscripts for context: `$U_{in}$`, `$U_{out}$`, `$U_{rms}$`, `$I_{bias}$`.

### Figures

````markdown
```{figure} images/<descriptive>.svg
---
name: fig-<descriptive>
height: 320px
---
One-line caption that names the parts students need to find.
```
````

* SVG when the source is a schematic (allows dark-mode inversion); PNG or AVIF for photos. Photos must add `class: no-invert` so dark mode does not invert them.
* Reference figures with `` {numref}`fig-...` `` for "Fig. 3" style numbering.

### Admonitions used in this book

These are documented in [book/miscellaneous/admonitions.md](book/miscellaneous/admonitions.md) and styled in [book/static/global.css](book/static/global.css). Use them, do not invent new admonition classes ad hoc.

| Class | Purpose |
| --- | --- |
| `important` | The "How To Work" box at the top of each manual. |
| `tip` | Preparation lists, optional dropdowns of advice. |
| `attention` | Safety or hardware caveats (supply polarity, scope range). |
| `note no-content` | Cross-reference back to earlier tasks in a Compare task. |
| `answer dropdown` | "Check your answer" boxes after a numerical Anticipate task. |
| `hint dropdown` | One-step nudge for stuck students. |
| `estimated-time no-content` | First admonition under each task heading: `Estimated time: 15 min`. Required on every numbered task. |
| `deep-dive dropdown` | Extended exploration at the end of a manual. **Not optional**: every student must complete and have a TA check off **3 to 5 deep dives across the course** to pass. Each manual should ship with two or three deep dives so students can pick the ones that interest them. Do not write "Deep dive (optional)" in titles. |

### Inline TODO flag (vibrant magenta)

When a manual references something that is not yet final (a textbook anchor, a missing figure, a datasheet link, a hardware photo for the new ALPACA), embed a vibrant inline TODO so authors can spot every loose end at a glance. The pattern is a single inline `<span>`, never an admonition:

```html
<span style="background:#ff1493;color:#fff;padding:2px 8px;border-radius:4px;
             font-weight:700;font-size:0.85em;
             box-shadow:0 0 6px rgba(255,20,147,0.6);">&#x1F6A9; TODO: &lt;one-line description&gt;</span>
```

Place it on a line of its own, immediately after the broken or placeholder reference. Examples in the wild: [4.1_opamp_basics.ipynb](book/manuals/week4/4.1_opamp_basics.ipynb), [4.2_real_opamps.ipynb](book/manuals/week4/4.2_real_opamps.ipynb).

## 7. When the textbook covers a concept

The lab manuals are not the place to teach theory. The textbook source under [helpers/theory_part/](helpers/theory_part/) is.

* Refer the student to the textbook for derivations and proofs.
* Re-explain a concept in the manual only when (a) students reliably trip on it, or (b) the manual is doing something the textbook does not cover (real chip pinouts, decoupling, a closed-loop bandwidth formula the textbook simplifies, single-supply operation, scope hygiene).
* Always provide a real link, not just a phrase like "see chapter 7". If the published textbook URL is not yet known, use a relative path as a placeholder and add a TODO flag (section 6) on the next line.

## 8. Build and preview

```bash
./run_book_server.sh           # full clean rebuild + serve at http://localhost:8000
jupyter-book build book/       # rebuild without serving
```

A clean build must succeed. Warnings about missing images or out-of-book cross-references are acceptable only when each one is paired with a TODO flag (section 6) inside the manual, so it is visible to the next editor.

## 9. Cross-cutting reference material

* [book/_toc.yml](book/_toc.yml): table of contents. Every new manual must be added here under the right week's `sections:` list, otherwise it is invisible.
* [book/_config.yml](book/_config.yml): build settings, MyST extensions, theme.
* [book/static/global.css](book/static/global.css): admonition colour palette and dark-mode overrides. Do not duplicate styling here; if a new admonition needs a colour, add a single block.
* [book/miscellaneous/intro.md](book/miscellaneous/intro.md): the book landing page; describes the BASIC format to students. Keep the manual structure consistent with what this page promises.
* [book/miscellaneous/admonitions.md](book/miscellaneous/admonitions.md): the canonical gallery of admonitions in use. Update when you add a new one.

---

## 10. Punctuation: no em or en dashes

**Do not use em dashes (`—`, U+2014) or en dashes (`–`, U+2013) anywhere in prose.**

When you would naturally reach for one, choose one of:

1. A comma, when the inserted clause is parenthetical.
2. A colon, when introducing a list, definition, or explanation.
3. A semicolon, when joining two related independent clauses.
4. A period, splitting into two sentences.
5. Parentheses, for asides.

**Do not substitute a regular hyphen (`-`) for an em or en dash either.** A hyphen is only correct in:

* Compound modifiers and compound nouns: `current-correct`, `voltage-correct`, `2-wire`, `5-1/2-digit`, `BNC-to-banana`, `Y-Δ`, `cross-check`.
* Markdown bullet lists (`- item`, also valid as `* item`).
* Markdown horizontal rules (`---`).
* YAML separators inside MyST/Jupyter Book figure directives (`---`).
* Math expressions and identifiers (minus signs, negative exponents).

### Replacements for common dash idioms

| Dash usage | Replace with |
| --- | --- |
| `1–2 %`, `Tasks I1–I5`, `pages 10–14` | `1 to 2 %`, `Tasks I1 to I5`, `pages 10 to 14` |
| `voltmeter–ammeter`, `series–parallel` | `voltmeter and ammeter`, `series-parallel` (regular hyphen, since these are compound modifiers) |
| `... briefly — keep ...` | `... briefly. Keep ...` |
| `... node N — having a name ...` | `... node N. Having a name ...` |
| `e.g. — about 0.43 V` | `e.g., about 0.43 V` |

### Quick self-check before saving

Before writing or committing a file, search your output for the literal characters `—` and `–`. If either appears outside of a code block, math, or a quoted external source, rewrite that sentence.

## 11. Other writing conventions

* Use straight quotes (`"`, `'`), not typographic quotes (`"`, `"`, `'`, `'`).
* Use `e.g.` and `i.e.` followed by a comma.
* Prefer short sentences over long ones connected by stacked clauses; this also makes it easier to avoid dashes.
* In notebooks, keep the existing voice: instructional, second-person ("you"), present tense.

## 12. Scope

These rules govern *all* prose in the repository. They do require rewriting historical content the user has not asked to keep. If you are already editing a paragraph, fix any dashes you encounter in it. Only leave these untouched if the user strictly requested that.
