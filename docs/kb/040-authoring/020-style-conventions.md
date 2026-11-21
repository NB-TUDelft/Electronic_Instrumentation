---
summary: >-
  Voice and tone, math and units, figures, the admonitions used in this
  book, and the vibrant magenta inline TODO flag. AGENTS.md section 6 before
  the split.
always_read: true
---

# Style conventions

## Voice and tone

* Second-person, present tense, instructional. "You wire pin 4 to the negative rail" rather than "the student wires pin 4".
* Short sentences, one idea per sentence. Stacked clauses make it harder both to read and to avoid the forbidden dashes (see section 11).
* Each cell either teaches one idea, asks one question, or scaffolds one measurement. Do not pile.

## Math

* Inline math uses single dollars: `$U_{out}$`, `$R_1 = 100\,\Omega$`.
* Display math uses double dollars on their own lines.
* Units always go in `\,\mathrm{...}` with a thin space: `5\,\mathrm{V}`, `1\,\mathrm{k}\Omega`, `100\,\mathrm{Hz}`, `0.5\,\mathrm{V/\mu s}`. Do not write `5V` or `5 V` in math.
* Use `U` for voltage symbols and `I` for currents (matching the textbook), with subscripts for context: `$U_{in}$`, `$U_{out}$`, `$U_{rms}$`, `$I_{bias}$`.

## Figures

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

## Admonitions used in this book

These are documented in [book/miscellaneous/admonitions.md](../../../book/miscellaneous/admonitions.md) and styled in [book/static/global.css](../../../book/static/global.css). Use them, do not invent new admonition classes ad hoc.

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

## Inline TODO flag (vibrant magenta)

When a manual references something that is not yet final (a textbook anchor, a missing figure, a datasheet link, a hardware photo for the new ALPACA), embed a vibrant inline TODO so authors can spot every loose end at a glance. The pattern is a single inline `<span>`, never an admonition:

```html
<span style="background:#ff1493;color:#fff;padding:2px 8px;border-radius:4px;
             font-weight:700;font-size:0.85em;
             box-shadow:0 0 6px rgba(255,20,147,0.6);">&#x1F6A9; TODO: &lt;one-line description&gt;</span>
```

Place it on a line of its own, immediately after the broken or placeholder reference. Examples in the wild: [4.1_opamp_basics.ipynb](../../../book/manuals/week4/4.1_opamp_basics.ipynb), [4.2_real_opamps.ipynb](../../../book/manuals/week4/4.2_real_opamps.ipynb).
