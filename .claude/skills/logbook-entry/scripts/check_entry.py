"""Check log book entries the way the book and the logbook site build them.

Usage, from the repository root:
    python .claude/skills/logbook-entry/scripts/check_entry.py [entry.typ ...]
With no entries, it checks every book/manuals/week*/*_logbook.typ.

1. Runs the site's own check (EI_Logbooks tools/sync_templates.py --check):
   names, week folders, duplicate numbers, imports.
2. Compiles each entry as a fillable PDF twice: with book/manuals/logbook_common.typ
   (the book) and with the site's templates/logbook_common.typ. Reports pages,
   answer fields and image boxes, and saves both PDFs in book/_build/logbook-check/.

Needs sphinx-typst-render (in requirements.txt) and internet access to
raw.githubusercontent.com. Exits with an error if anything fails.
"""
import shutil
import subprocess
import sys
import tempfile
import urllib.request
from pathlib import Path

RAW = 'https://raw.githubusercontent.com/NB-TUDelft/EI_Logbooks/main/'
REPO = Path.cwd()
MANUALS = REPO / 'book' / 'manuals'
OUT = REPO / 'book' / '_build' / 'logbook-check'


def fetch(path):
    with urllib.request.urlopen(RAW + path, timeout=30) as r:
        return r.read().decode('utf-8')


def site_check(tmp):
    """The site's name/folder/import check, or None when it isn't available."""
    script = tmp / 'sync_templates.py'
    script.write_text(fetch('tools/sync_templates.py'), encoding='utf-8')
    if 'def check(' not in script.read_text(encoding='utf-8'):
        print('site check: not available yet in EI_Logbooks; skipped')
        return None
    run = subprocess.run([sys.executable, str(script), '--check', str(REPO)],
                         capture_output=True, text=True)
    print('site check:', (run.stdout + run.stderr).strip())
    return run.returncode == 0


def compile_with(entry, common, root, cache):
    """Compile entry against one logbook_common.typ; return (pdf path, summary)."""
    from sphinx_typst_render._compile import RenderRequest, render, stage_field_library
    week = root / entry.parent.name
    week.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(common, root / 'logbook_common.typ')
    src = week / entry.name
    shutil.copyfile(entry, src)
    stage_field_library(root)
    res = render(RenderRequest(source=src, root=root, preview='none', fillable=True), cache)
    from pypdf import PdfReader                     # comes with sphinx-typst-render
    reader = PdfReader(res.pdf)
    names = list(reader.get_fields() or {})
    images = sorted(n for n in names if n.startswith('img_') or n.endswith('_ref'))
    return Path(res.pdf), len(reader.pages), len(names), images


def main():
    entries = [Path(a).resolve() for a in sys.argv[1:]] or sorted(MANUALS.glob('week*/*_logbook.typ'))
    OUT.mkdir(parents=True, exist_ok=True)
    ok = True
    with tempfile.TemporaryDirectory() as t:
        tmp = Path(t)
        try:
            ok = site_check(tmp) is not False
        except OSError as error:
            print('site check: could not fetch it:', error)
        site_common = tmp / 'site_common.typ'
        site_common.write_text(fetch('templates/logbook_common.typ'), encoding='utf-8')
        for entry in entries:
            print(f'\n{entry.relative_to(REPO)}')
            pages = {}
            for label, common in (('book', MANUALS / 'logbook_common.typ'), ('site', site_common)):
                try:
                    pdf, n, fields, images = compile_with(entry, common, tmp / label, tmp / f'cache-{label}')
                except Exception as error:
                    print(f'  {label}: DOES NOT COMPILE: {error}')
                    ok = False
                    continue
                dest = OUT / f'{entry.stem}.{label}.pdf'
                shutil.copyfile(pdf, dest)
                pages[label] = n
                print(f'  {label}: {n} pages, {fields} fields, image boxes: {", ".join(images) or "none"}'
                      f'  ({dest.relative_to(REPO)})')
            if len(set(pages.values())) > 1:
                print('  note: the page counts differ between the book and the site')
            if pages and max(pages.values()) > 3:
                print('  note: more than 3 pages; aim for 2 or 3')
    sys.exit(0 if ok else 1)


if __name__ == '__main__':
    main()
