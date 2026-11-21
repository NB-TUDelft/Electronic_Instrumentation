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
