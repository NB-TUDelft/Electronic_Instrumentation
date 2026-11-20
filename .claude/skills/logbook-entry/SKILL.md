---
name: logbook-entry
description: Write, change or review a log book entry for an NB2420 manual (book/manuals/weekN/<n.m>_<Title>_logbook.typ, the Typst file behind "Entry X.Y" in the Log book menu). Use this whenever someone adds a new entry, changes the tables, fields, prompts or image boxes of one, asks where a plot or photo should go, renames or renumbers an entry, or edits book/manuals/logbook_common.typ, even if they only say "log book", "logbook", "the entry" or "the PDF students fill in". It covers naming, the Typst building blocks, images, field ids, and how to check the entry the way the logbook site will build it.
---

# Log book entries

Each manual has one log book entry: a Typst file that becomes a fillable form.
Students fill it in on the logbook site (https://nb-tudelft.github.io/EI_Logbooks/),
which copies every entry from this repository, at least hourly. The book's own
Log book menu links to that site (`book/logbook_site.py`). So an entry has two
readers: this book's build, and the site's build. Both must work.

AGENTS.md section 12 has the background and the rules; read it first. This
skill is the working order.

## 1. Before writing

- **Read the manual's Compare and Conclude section.** The entry exists to
  collect those tables, so its middle mirrors them. A generic predicted /
  simulated / measured grid misses the point.
- List what the manual asks students to record: numbers, short answers,
  plots, screenshots, photos. Each needs a place in the entry.
- Respect what the manual has. No Simulate task means no simulated column.
  A cell the manual marks "not built" is fixed text, not a field.

## 2. The file

- Path: `book/manuals/weekN/<n.m>_<Title_with_underscores>_logbook.typ`,
  directly in the week folder of its number (3.2 goes in `week3/`). No spaces.
  The site rejects anything else, and the number is how students' saved work
  is found, so renumbering needs an alias in EI_Logbooks first.
- One entry per number.
- First lines:

```typ
#import "../logbook_common.typ": *
#show: logbook.with(
  title: "Log Book Entry 3.2",
  subtitle: "NB2420 Electronic Instrumentation " + sym.dot.c + " Manual 3.2 " + sym.dot.c + " Active filters",
)
```

- Import nothing else and read no other files (no `image("...")`): the site
  only has `logbook_common.typ`.
- The manual's notebook needs the block that adds it to the menu, in the How
  To Work cell:

````markdown
```{typst} 3.2_Active_filters_logbook.typ
:label: Entry 3.2
:fillable:
```
````

## 3. Building blocks

| Write | You get |
|---|---|
| `section("TITLE", note: "Tasks A1, I2")` | a heading band; also how the site tags images |
| `prompt[...]`, `hint[...]` | instruction text (content in `[...]`, not `"..."`, so math renders) |
| `line_field("id")` | one-line answer box |
| `area("id", height: 60pt)` | multi-line answer box |
| `check("id")` | checkbox |
| `field_row([Label:], line_field("a"), ...)` | label and box pairs |
| `table(..., line_field("x"), ...)` | a table of answer boxes |
| `sketchbox("id", height: 150pt)` | a place for a plot, photo or sketch |
| `closing(graph_prompt: [...], graph_height: 120pt)` | Reflection and TA check-off, with one graph box; `graph: false` leaves the box out |

Size everything in `pt`, never in percent. Keep the entry to 2 or 3 A4 sides.

## 4. Images

Every plot, screenshot, photo or sketch the manual asks for gets its own
`sketchbox`, never an `area`. In the book's PDF it is a drawing area with a
"Photo or file reference" line. On the site it becomes an image box that
students insert a picture into, and the page layout never shifts.

- Put a `prompt` above it saying what goes in: which plot, which axes and
  units, what to mark.
- Keep heading, prompt and box on one page:

```typ
#block(breakable: false)[
  *Square wave spectrum* #h(6pt) #hint[Task I2]
  #v(3pt)
  #prompt[Add the frequency-domain plot of your sampled 100 Hz square wave. Label each peak with its frequency and mark $f_N$.]
  #sketchbox("i2_spectrum", height: 150pt)
]
```

- Place it in the `section` of its task. The site tags each image with the
  last section that starts on or before its page.
- 150 to 200 pt suits a graph. One end-of-entry graph: use the closing graph box.
- Do not write `image_slot`. Only the site's copy of `logbook_common.typ` has
  it, so the book build would fail.

## 5. Field ids

Ids are a data schema: the submissions table has one column per id.

- Lowercase, task-prefixed, unique in the entry: `i2_meas`, `c47_fc`.
- Keep them stable. Renaming one breaks comparing years and reading old
  submissions.
- Don't start ids with `img_` (the site uses that), and leave `name`,
  `partner`, `date`, `group` to the shared parts.

## 6. Check

Run the bundled check from the repository root:

```bash
python .claude/skills/logbook-entry/scripts/check_entry.py book/manuals/week3/3.2_Active_filters_logbook.typ
```

It runs the site's own check (name, folder, duplicate numbers, imports) and
compiles the entry with this book's `logbook_common.typ` and with the site's,
then reports pages, fields and image boxes for each. Both must compile, and
the page counts should match. Then look at the PDFs it leaves in
`book/_build/logbook-check/`: no heading alone at the bottom of a page.

For the manual pages, a clean book build (`rm -rf book/_build && teachbooks build book/`)
shows the menu; incremental builds can show stale entries.

## 7. Wording and hand-off

- Student-facing text (prompts, hints, headings) follows AGENTS.md: second
  person, short sentences, straight quotes, and no em or en dashes.
- Show the person you work for every new or changed student-facing sentence,
  before and after, and get their OK before committing.
- Work on a branch and open a pull request; mention @zamkorus, who maintains
  AGENTS.md and these conventions. Once merged, the site copies the entry at
  its next check. Students who already started that entry keep their saved
  version until they choose Start fresh, so say so in the PR when a change
  matters for them.
