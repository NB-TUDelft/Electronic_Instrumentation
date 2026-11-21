---
summary: >-
  The table of contents, build config, global CSS, book landing page, and
  admonition gallery, and what to update when a manual or admonition is
  added. AGENTS.md section 9 before the split.
---

# Cross-cutting reference material

* [book/_toc.yml](../../../book/_toc.yml): table of contents. Every new manual must be added here under the right week's `sections:` list, otherwise it is invisible.
* [book/_config.yml](../../../book/_config.yml): build settings, MyST extensions, theme.
* [book/static/global.css](../../../book/static/global.css): admonition colour palette and dark-mode overrides. Do not duplicate styling here; if a new admonition needs a colour, add a single block.
* [book/miscellaneous/intro.md](../../../book/miscellaneous/intro.md): the book landing page; describes the BASIC format to students. Keep the manual structure consistent with what this page promises.
* [book/miscellaneous/admonitions.md](../../../book/miscellaneous/admonitions.md): the canonical gallery of admonitions in use. Update when you add a new one.
