---
summary: >-
  One fillable log book entry per manual: where they live, how the typst
  block puts one in the download menu and integrated editor, how to write a
  new entry from the manual Compare and Conclude tasks, the field and image
  rules that are easy to get wrong, and clean-build plus CI artifact
  verification. AGENTS.md section 12 before the split.
---

# Log book entries

Every manual ships a **log book entry**: a fillable PDF that students complete as
they work and hand in via BrightSpace. One entry covers one manual. The
**Preparation** side is homework (BAS), the **Practicum** side is filled at the
bench (IC), matching the split in section 2.

## Where things live

| Path | What it is |
| --- | --- |
| `book/manuals/logbook_common.typ` | Shared scaffolding: field helpers, image boxes, the Preparation block, the closing block. |
| `book/manuals/weekX/<week>.<manual>_<snake>_logbook.typ` | One entry. Holds only the manual-specific middle. |
| `book/_build/typst-build/` | Compiled output and its cache. Never in the source tree, never committed. |

Entries are compiled at build time by
[sphinx-typst-render](https://github.com/NB-TUDelft/sphinx-typst-render), enabled
in `book/_config.yml`. The extension bundles the Typst compiler, so no `typst`
binary and no Rust toolchain are needed on the build machine.

## How an entry reaches the student

The block renders **nothing** into the page:

````markdown
```{typst} 1.1_voltage_divider_logbook.typ
:label: Entry 1.1
:fillable:
```
````

It adds the entry to the download menu in the article header, under a **Log
book** heading, beside the page's own `.ipynb` and `.pdf`: one link opens it in
the in-browser editor, the other downloads its `.typ` source. Put the block in
the same cell as the **How To Work** admonition, and reference the entry from
inside that admonition rather than adding a second admonition for it. These
config values in `book/_config.yml` control the menu:

```yaml
typst_render_source_label: Manual        # heading above the page's own downloads
typst_render_downloads_label: Log book   # heading above the entries
typst_render_open: [editor, raw]         # the editor and the .typ source, no plain PDF
typst_render_editor:                     # the editor's saves and wording
  storage: nb2420-logbooks               # stable browser-storage name for student saves
```

Every entry also appears on the **Log books** page
(`book/miscellaneous/logbooks.md`): its `{typst-overview}` directive lists all
entries by week, and each card opens one in the editor. A new entry shows up
there by itself.

## Highlighting the current week

The overview uses `sphinx-typst-render` 1.1.0's `:highlight-weekly:` option,
anchored to `Week 1, 2026-11-09`, with the heading `This week`. The browser
selects the current week's entries from its local date without a rebuild.
Each highlighted group lasts from Monday through Sunday.

The maintainer's `NB2420 EI block1 schedule.pdf`, `NB2420 EI block2 schedule.pdf`,
and `NB2420 EI block3 schedule.pdf` give this 2026/27 calendar:

| Course week | Monday |
| --- | --- |
| 1 | 2026-11-09 |
| 2 | 2026-11-16 |
| 3 | 2026-11-23 |
| 4 | 2026-11-30 |
| 5 | 2026-12-07 |
| 6 | 2026-12-14 |
| 7 | 2027-01-04 |
| 8 | 2027-01-11 |
| 9, repair session | 2027-01-18 |
| 10, case study | 2027-01-25 |

Currently only Weeks 1 through 6 have log book entries. The highlight therefore
ends on 2026-12-21, when the winter break starts. Weeks 7 and 8 have no entries
to highlight yet. Before adding their entries, replace the single weekly
sequence with scheduling that preserves the winter break and uses their
January dates. The package's weekly option advances through available groups
every seven days; it does not account for holidays or weeks without entries.

## Writing a new entry

Students fill in the entries in the editor built into this book. They open
an entry from its manual page or from the **Log books** page, and the editor
saves their work in the browser under the storage name and key pattern in
`book/_config.yml`. The same book build compiles every entry, generates the
overview, and copies the editor bundle into the HTML, so an entry only has
to work in this build.

1. **Read that manual's Compare and Conclude section first.** The middle of the
   entry must mirror its tables, because those tables are what the entry exists
   to collect. Do not paste a generic predicted / simulated / measured grid.
2. Keep to **2 or 3 A4 sides**. Three is the normal size.
3. Respect what the manual actually has. Manual 2.1 has no Simulate task, so it
   has no simulated column, and its C2 is a troubleshooting reflection rather
   than a data table. Where a manual marks a cell "not built" or "not
   simulated" (5.1), render fixed text, not a field, so it cannot be filled.
4. List what the manual asks students to record: numbers, short answers,
   plots, screenshots, photos. Each one needs its own place in the entry.
5. **Name and place the file exactly.** It is
   `book/manuals/weekN/<n.m>_<Title_with_underscores>_logbook.typ`, directly in
   the week folder of its number (3.2 goes in `week3/`), with no spaces, and
   one file per number. The integrated editor takes its save key from that
   number with `typst_render_editor.key_pattern`, and the build check refuses
   anything else. To renumber an entry that students have already started,
   add an old-to-new mapping under `typst_render_editor.aliases` first, so
   their saved work follows the entry.
6. Import the shared scaffolding and supply only the middle. The `logbook`
   wrapper adds the standard Preparation questions and one shared response box
   below the identity fields. Call `closing` for the standard Reflection
   questions and one shared response box:

```typ
#import "../logbook_common.typ": *
#show: logbook.with(title: "Log Book Entry X.Y", subtitle: "...")
// manual-specific tables here
#closing()
```

   Import nothing else and read no other files (no `image("...")`): each
   entry must stay complete with only `logbook_common.typ`, and student
   images belong in the editor image boxes.

## Rules that are easy to get wrong

* **Never size a form field with a percentage.** `capture_field`'s `text_field`
  sizes its widget with `measure()`, which cannot resolve a relative width, so a
  `width: 100%` box produces a 20pt interactive area inside a full width
  outline. Use `line_field` or `area` (both take the `fill_cell` path, which
  sees the real container width), or give `text_field` an absolute width.
* **Prompts are content, not strings.** Pass `[...]`, not `"..."`, or inline
  math renders as a literal `$-3$`.
* **Never hand-declare the page total.** The template uses `numbering: "1 / 1"`
  and Typst fills in the real total, so the footer cannot drift from reality.
* **Field names are a data schema.** Task-prefixed and stable, e.g. `p1_u_pred`,
  `i4_meas`, `mat0`. Renaming one breaks any later attempt to read submissions
  back programmatically.
* **PDF forms have no image field.** AcroForm defines only text, button, choice
  and signature, so a photo cannot be pasted into a field. Use `sketchbox()`
  (or `image_slot()`), which reserves a fixed-height box with a hidden text
  field `img_<name>` on top. The editor reads that field's position and draws
  the chosen photo or screenshot into the box; students can also draw in it.
  Keep the `img_` prefix: it is how the editor finds the box.

## Verifying a change

Incremental builds do not re-read a notebook that has not changed, so an edited
`.typ` or an extension change can show **stale results** in the download menu.
Always verify with a clean build:

```bash
./run_book_server.sh            # full clean rebuild + serve
rm -rf book/_build && jupyter-book build book/
```

Then check the sources and the generated editor output from the repository
root:

```bash
python .github/scripts/check_logbook_build.py --source-only
python .github/scripts/check_logbook_build.py
```

The checker requires `sphinx-typst-render` 1.0.0 or newer with its editor
bundle. It checks every entry's name, week folder, shared import, and
notebook block, and that no two entries share a number. After a build it
also checks the editor assets and settings, one compiled PDF and Typst
source per entry, and an editor link for every entry on both its manual page
and the **Log books** overview.

The book workflow (`.github/workflows/call-deploy-book.yml`) runs that
source check, builds the book with TeachBooks, and then runs the full
checker on pull requests and pushes that touch the book, its dependencies,
the checker, or the workflow. Its deployment job needs the build job and is
skipped for pull requests. There is no separate log book publication step:
the entries, overview, and editor all ship in the same book HTML.
