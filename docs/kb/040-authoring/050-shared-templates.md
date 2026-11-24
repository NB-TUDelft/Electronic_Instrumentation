---
summary: >-
  Shared templates live in book/manuals/tpl/: Markdown blocks pulled into
  manuals with the include directive, MyST substitutions for short repeated
  values, and Typst files imported by log book entries; the naming, label,
  and rebuild rules that keep them working.
---

# Shared templates

Write content that repeats across pages once, in `book/manuals/tpl/`, and
pull it in where it is used. Change the template, and every page that uses it
changes on the next build. Templates are not pages, so do not list them in
`book/_toc.yml`.

## Markdown templates in manuals

Put the block in a `.md` file in `tpl/` and include it from a markdown cell of
the notebook:

````markdown
```{include} ../tpl/how_to_work.md
```
````

* The path is relative to the notebook, so a week manual reaches the folder
  with `../tpl/`.
* A template can hold anything MyST renders: admonitions, lists, math,
  dropdowns. [how_to_work.md](../../../book/manuals/tpl/how_to_work.md) holds
  a complete How To Work admonition. Every manual includes it, in the same
  cell as its `{typst}` block, so the box reads the same everywhere.
* `only_build_toc_files` in `book/_config.yml` keeps a template from being
  built as a page of its own. The include still reads it.
* **Never start a template name with an underscore.** `_*.md` is gitignored
  (see Naming conventions), so the template would stay on your machine and
  every build elsewhere would fail.
* **Keep labels out of a template**: no task anchors such as
  `(Task_A1_4_1)=` and no figure `name:`. Every page that includes it would
  define the same label, and the build warns about the duplicates.
* A template takes no parameters. When manuals need different wording, keep
  the part that differs in the notebook, next to the include.

## Short repeated values: substitutions

For a short value that appears on many pages and changes in one go (a supply
voltage, a part number, a link), define a MyST substitution under `parse:` in
`book/_config.yml`:

```yaml
parse:
  myst_substitutions:
    supply: '$\pm 5\,\mathrm{V}$'
```

Write `{{ supply }}` wherever the value belongs. Use single quotes in the
YAML, so the backslashes in math survive. A notebook can define its own values
in its metadata under `myst.substitutions`.

## Typst templates in log book entries

A log book entry imports shared Typst from `tpl/` with a path relative to the
entry:

```typ
#import "../tpl/logbook_common.typ": *
```

`logbook_common.typ` is the scaffolding every entry uses (see Log book entries
under Log books). A new shared piece goes in its own `.typ` file in `tpl/` and
is imported the same way. Paths inside a template resolve from the template's
own folder. Paths that start with `/` resolve from `book/`, which is how
`logbook_common.typ` reaches `/_typst_lib/capture_field.typ`.

## Rebuilding after a template change

Sphinx tracks Markdown includes, so an incremental build re-reads every
notebook that includes an edited Markdown template.

`sphinx-typst-render` does not track Typst imports. Its cache hashes only the
`.typ` files in the entry's own folder, and a notebook is re-read only when
its own entry changes. After editing a Typst template, rebuild cleanly (see
Build and preview), or the download menu and the editor keep serving the old
PDFs.

The published book is not affected. The deploy workflow caches only
`book/_build/html`, under a key that changes with anything in `book/`, so a
template edit triggers a build from scratch.
