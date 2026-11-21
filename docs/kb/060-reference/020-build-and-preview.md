---
summary: >-
  Build and serve with run_book_server.sh or jupyter-book build book/; a
  clean build must succeed, and a warning is acceptable only beside a TODO
  flag. AGENTS.md section 8 before the split.
---

# Build and preview

```bash
./run_book_server.sh           # full clean rebuild + serve at http://localhost:8000
jupyter-book build book/       # rebuild without serving
```

A clean build must succeed. Warnings about missing images or out-of-book cross-references are acceptable only when each one is paired with a TODO flag (section 6) inside the manual, so it is visible to the next editor.

## Temporary local extension development

Install a local `sphinx-typst-render` checkout into the book's environment in
editable mode, replacing the example path with your checkout:

```bash
uv pip install --python .venv/bin/python --editable /path/to/sphinx-typst-render
uv run --no-sync ./run_book_server.sh
```

This changes only the installed package, leaving `pyproject.toml` and `uv.lock`
unchanged. Python edits in the extension checkout are picked up directly.
Rebuild its editor bundle there after changing editor sources, then cleanly
rebuild the book. Use `uv run --no-sync` while testing: a normal `uv run` or
`uv sync` can restore the locked release.

To end the temporary override and restore the locked environment:

```bash
uv sync --locked
```
