"""Knowledge-base housekeeping: rebuild the index in `README.md` from the sections themselves.

  python3 docs/kb/housekeeping.py            rewrite the index between the markers in README.md
  python3 docs/kb/housekeeping.py --check    fail if the index is stale or a section breaks the layout rules
  python3 docs/kb/housekeeping.py --graph    refresh the knowledge base's edges in the graphify graph
  python3 docs/kb/housekeeping.py [--check | --graph [graph.json]] [--root <dir>]

`--graph` leaves README.md alone and rewrites only the knowledge base's own edges in
`graphify-out/graph.json` (see graphify.py); it needs a graph that already has the section files.

Every section is one Markdown file named `<NNN>-<slug>.md`. Its children, if it has any, live
in the directory of the same name beside it, and the three-digit prefix orders siblings. The
files directly in the root are the groups (Course, Rules, ... Reference). A section file starts
with front matter, then its one `# Title`:

  ---
  summary: >-
    What the index says about this section, wrapped over as many indented lines as needed.
  always_read: true
  ---

  # Title

`summary` is required and always written as a folded block (`>-`), which needs no quoting
whatever the text contains. `always_read` is optional and only ever `true`; it puts the section
on the always-read list and marks its entry *always read*.

Ported from `docs/kb/housekeeping.mjs` in git-graph-libre. Two adaptations follow this
repository's own rules: index entries join title and summary with a colon, because prose here
may not use an em dash (see Punctuation: no em or en dashes, under Authoring), and the stale
index message names this Python command instead of a pnpm script.
"""

import os
import re
import sys
from pathlib import Path

sys.dont_write_bytecode = True

from graphify import link_graph

INDEX_FILE = "README.md"
START_MARKER = "<!-- kb-index:start -->"
END_MARKER = "<!-- kb-index:end -->"
SECTION_NAME = re.compile(r"^\d{3}-[a-z0-9]+(?:-[a-z0-9]+)*\.md$")
DIRECTORY_NAME = re.compile(r"^\d{3}-[a-z0-9]+(?:-[a-z0-9]+)*$")


def parse_section(text, file, problems):
    """Read the supported front-matter subset: a folded `summary` and an optional `always_read`."""
    lines = text.split("\n")
    if lines[0] != "---":
        problems.append(f"{file}: does not start with front matter (---)")
        return None
    try:
        end = lines.index("---", 1)
    except ValueError:
        problems.append(f"{file}: front matter is never closed")
        return None
    meta = parse_front_matter(lines[1:end], file, problems)
    title = parse_title(lines[end + 1:], file, problems)
    if meta is None or title is None:
        return None
    return {"title": title, **meta}


def parse_front_matter(lines, file, problems):
    summary = ""
    is_always_read = False
    i = 0
    while i < len(lines):
        line = lines[i]
        if line == "summary: >-":
            folded = []
            while i + 1 < len(lines) and lines[i + 1].startswith("  "):
                i += 1
                folded.append(lines[i].strip())
            summary = " ".join(folded)
        elif line == "always_read: true":
            is_always_read = True
        else:
            problems.append(f'{file}: unsupported front matter line "{line}"')
            return None
        i += 1
    if summary == "":
        problems.append(f'{file}: no summary (write it as "summary: >-" and indented lines)')
        return None
    return {"summary": summary, "always_read": is_always_read}


def parse_title(lines, file, problems):
    first = next((line for line in lines if line.strip() != ""), None)
    if first is None or not first.startswith("# "):
        problems.append(f'{file}: the first line after the front matter must be its "# Title"')
        return None
    in_fence = False
    titles = 0
    for line in lines:
        if line.startswith("```"):
            in_fence = not in_fence
        elif not in_fence and line.startswith("# "):
            titles += 1
    if titles > 1:
        problems.append(f'{file}: has more than one "# " title; split it instead')
    return first[2:].strip()


def read_tree(root, directory, problems):
    """The sections of one directory, in prefix order, each with its children."""
    names = sorted(os.listdir(root / directory))
    sections = []
    prefixes = set()
    for name in names:
        rel = name if directory == "" else f"{directory}/{name}"
        if directory == "" and (name == INDEX_FILE or name.endswith(".py") or name == "__pycache__"):
            continue
        if (root / rel).is_dir():
            check_directory(names, name, rel, problems)
            continue
        if not SECTION_NAME.match(name):
            problems.append(f"{rel}: not a section name like 010-some-title.md")
            continue
        prefix = name[:3]
        if prefix in prefixes:
            problems.append(f"{rel}: prefix {prefix} is used twice here")
        prefixes.add(prefix)
        section = parse_section((root / rel).read_text(encoding="utf-8"), rel, problems)
        if section is None:
            continue
        children = read_tree(root, rel[:-3], problems) if name[:-3] in names else []
        sections.append({**section, "path": rel, "children": children})
    return sections


def check_directory(siblings, name, rel, problems):
    if not DIRECTORY_NAME.match(name):
        problems.append(f"{rel}/: not a section directory name")
    elif f"{name}.md" not in siblings:
        problems.append(f"{rel}/: has no {name}.md beside it")


def escape_link_text(text):
    return text.replace("[", "\\[").replace("]", "\\]")


def entry_lines(sections, depth):
    lines = []
    for section in sections:
        flag = " (*always read*)" if section["always_read"] else ""
        link = f"[{escape_link_text(section['title'])}]({section['path']})"
        lines.append(f"{'  ' * depth}- {link}{flag}: {section['summary']}")
        lines.extend(entry_lines(section["children"], depth + 1))
    return lines


def always_read(sections):
    found = []
    for section in sections:
        if section["always_read"]:
            found.append(section)
        found.extend(always_read(section["children"]))
    return found


def render_index(groups):
    """The generated part of README.md, markers included."""
    out = [START_MARKER, "", "**Always read**, in this order:", ""]
    for i, section in enumerate(always_read(groups)):
        out.append(f"{i + 1}. [{escape_link_text(section['title'])}]({section['path']})")
    for group in groups:
        out.extend(["", f"**{group['title']}**: {group['summary']}", ""])
        out.extend(entry_lines(group["children"], 0))
    out.extend(["", END_MARKER])
    return "\n".join(out)


def splice_index(readme, index):
    """Replace the marked region of `readme`, or return None when the markers are missing."""
    start = readme.find(START_MARKER)
    end = readme.find(END_MARKER)
    if start == -1 or end == -1 or end < start:
        return None
    return readme[:start] + index + readme[end + len(END_MARKER):]


def option_value(argv, flag):
    """The value after `flag`, or None when the flag is absent or has none."""
    if flag not in argv:
        return None
    at = argv.index(flag)
    value = argv[at + 1] if at + 1 < len(argv) else None
    return None if value is None or value.startswith("--") else value


def report(problems):
    for problem in problems:
        print(f"kb: {problem}", file=sys.stderr)
    return 1


def run_graph(argv, groups, root):
    """`--graph [graph.json]`: replace the knowledge base's edges in the graphify graph."""
    value = option_value(argv, "--graph")
    graph_path = (Path(value).resolve() if value is not None
                  else (root / ".." / ".." / "graphify-out" / "graph.json").resolve())
    result = link_graph(groups=groups, root=root, graph_path=graph_path)
    if result["problems"]:
        return report(result["problems"])
    print(f"kb: {os.path.relpath(graph_path)} linked")
    print(f"kb: {result['contains']} contains edges, {result['mentions']} mentions edges")
    return 0


def run(argv):
    check = "--check" in argv
    root_option = option_value(argv, "--root")
    root = (Path(root_option).resolve() if root_option is not None
            else Path(__file__).resolve().parent)
    problems = []
    groups = read_tree(root, "", problems)
    readme_path = root / INDEX_FILE
    readme = readme_path.read_text(encoding="utf-8")
    updated = splice_index(readme, render_index(groups))
    if updated is None:
        problems.append(f"{INDEX_FILE}: missing {START_MARKER} / {END_MARKER}")
    if problems:
        return report(problems)
    if "--graph" in argv:
        return run_graph(argv, groups, root)
    count = len(always_read(groups))
    if check:
        if updated == readme:
            return 0
        print(f"kb: {INDEX_FILE} is out of date; run python3 docs/kb/housekeeping.py",
              file=sys.stderr)
        return 1
    if updated != readme:
        readme_path.write_text(updated, encoding="utf-8")
    print(f"kb: {INDEX_FILE} {'already current' if updated == readme else 'rewritten'}")
    print(f"kb: {len(groups)} groups, {count} always-read sections")
    return 0


if __name__ == "__main__":
    sys.exit(run(sys.argv[1:]))

