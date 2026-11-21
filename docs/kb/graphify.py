"""Knowledge-base edges for the graphify code graph (graphify-out/graph.json).

graphify already reads every section file: `graphify update .` gives each one a node, its
headings, and a `references` edge for every Markdown link, so the index in README.md links all
sections. What it cannot see is the structure of the knowledge base, nor which code a section
talks about, because it ignores links to anything but documents. This module adds both:

- `contains` edges from the index to each group, from each group to its sections, and from each
  section to its subsections;
- `mentions` edges from a section to the code it names in inline backticks: a path that matches
  exactly one file in the graph (`EXTRACTED`), or a code-shaped name (camelCase, PascalCase or
  snake_case, four characters or more) that matches one to three symbols (`INFERRED`).

Every edge it writes carries `"_origin": "kb"` and the section file as its `source_file`, the
provenance graphify gives its own non-AST edges. `graphify update` therefore keeps them as long
as both ends exist, and drops them with their section file. Each run first removes all `kb`
edges, so running it again is idempotent.

graph.json is written by Python's `json.dumps(indent=2, ensure_ascii=True)`. The file is parsed
keeping each float's source text and written back the same way, and nothing is written unless
that reproduces the file byte for byte, so a run changes only the edges it owns.

Ported from `docs/kb/graphify.mjs` in git-graph-libre. The code-path extensions also cover the
file kinds this book repository names (`.ipynb`, `.typ`).
"""

import json
import re
from pathlib import Path

ORIGIN = "kb"
MAX_SYMBOL_MATCHES = 3
CODE_PATH = re.compile(r"\.(?:ts|js|mjs|cjs|rs|json|jsonc|css|ya?ml|toml|sh|py|ipynb|typ|html|md)$")
NAME = re.compile(r"^[A-Za-z_$][\w$]*(?:(?:::|\.|#)[A-Za-z_$][\w$]*)*(?:\(\))?$", re.ASCII)


class RawNumber:
    """A float exactly as it was written in the file, so `1.0` stays `1.0`."""

    def __init__(self, raw):
        self.raw = raw

    def __repr__(self):
        return f"RawNumber({self.raw!r})"


def parse_graph(text):
    return json.loads(text, parse_float=RawNumber)


def serialize_graph(value, indent=""):
    """Serialize the way Python's `json.dumps(value, indent=2, ensure_ascii=True)` does."""
    if isinstance(value, RawNumber):
        return value.raw
    if isinstance(value, str):
        return json.dumps(value, ensure_ascii=True)
    if value is None:
        return "null"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, (int, float)):
        return json.dumps(value)
    inner = indent + "  "
    if isinstance(value, list):
        if not value:
            return "[]"
        elements = [inner + serialize_graph(item, inner) for item in value]
        return "[\n" + ",\n".join(elements) + "\n" + indent + "]"
    if not value:
        return "{}"
    items = [
        f"{inner}{json.dumps(key, ensure_ascii=True)}: {serialize_graph(item, inner)}"
        for key, item in value.items()
    ]
    return "{\n" + ",\n".join(items) + "\n" + indent + "}"


def file_nodes(nodes):
    """The file node of each source file: the shortest id among the nodes it produced."""
    by_file = {}
    for node in nodes:
        file = node.get("source_file")
        if not file:
            continue
        current = by_file.get(file)
        if current is None or len(node["id"]) < len(current):
            by_file[file] = node["id"]
    return by_file


def symbol_key(label):
    if label.startswith("."):
        label = label[1:]
    if label.endswith("()"):
        label = label[:-2]
    return label


def code_targets(nodes, files, kb_prefix):
    """The code the knowledge base can point at: files by path, and symbols by name."""
    file_ids = set(files.values())
    symbols = {}
    for node in nodes:
        file = node.get("source_file")
        if not file or file.startswith(kb_prefix + "/") or node["id"] in file_ids:
            continue
        if node.get("file_type") != "code":
            continue
        label = node.get("label")
        if not label:
            continue
        key = symbol_key(label)
        symbols.setdefault(key, []).append(node["id"])
    paths = [(file, node_id) for file, node_id in files.items()
             if not file.startswith(kb_prefix + "/")]
    return {"paths": paths, "symbols": symbols}


def inline_code(text):
    """Inline code spans outside fenced blocks, with their 1-based line numbers."""
    spans = []
    in_fence = False
    for index, line in enumerate(text.split("\n")):
        if line.lstrip().startswith("```"):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        for match in re.finditer(r"`([^`\n]+)`", line):
            spans.append({"token": match.group(1).strip(), "line": index + 1})
    return spans


def is_code_shaped_name(name):
    return len(name) >= 4 and (re.search(r"[A-Z]", name[1:]) is not None or "_" in name)


def resolve_mention(token, targets):
    """What one inline code span refers to, as [id, confidence] pairs; empty when unclear."""
    cleaned = token[2:] if token.startswith("./") else token
    cleaned = re.sub(r":\d+$", "", cleaned)
    if re.search(r"[\s*]", cleaned):
        return []
    if "/" in cleaned or CODE_PATH.search(cleaned):
        hits = [(file, node_id) for file, node_id in targets["paths"]
                if file == cleaned or file.endswith("/" + cleaned)]
        return [[hits[0][1], "EXTRACTED"]] if len(hits) == 1 else []
    if not NAME.match(cleaned):
        return []
    name = symbol_key(re.split(r"::|\.|#", cleaned)[-1])
    if not is_code_shaped_name(name):
        return []
    ids = targets["symbols"].get(name, [])
    if 0 < len(ids) <= MAX_SYMBOL_MATCHES:
        return [[node_id, "INFERRED"] for node_id in ids]
    return []


def edge(source, target, relation, source_file, line, confidence):
    return {
        "relation": relation,
        "confidence": confidence,
        "source_file": source_file,
        "source_location": f"L{line}",
        "weight": RawNumber("1.0"),
        "_origin": ORIGIN,
        "source": source,
        "target": target,
        "confidence_score": RawNumber("1.0" if confidence == "EXTRACTED" else "0.8"),
    }


def mention_edges(section, node_id, root, kb_prefix, targets):
    seen = set()
    edges = []
    text = (root / section["path"]).read_text(encoding="utf-8")
    for span in inline_code(text):
        for target, confidence in resolve_mention(span["token"], targets):
            if target in seen:
                continue
            seen.add(target)
            edges.append(edge(node_id, target, "mentions",
                              f"{kb_prefix}/{section['path']}", span["line"], confidence))
    return edges


def knowledge_base_edges(groups, root, kb_prefix, nodes):
    """Every `kb` edge for the sections, or the section files the graph does not know yet."""
    files = file_nodes(nodes)
    targets = code_targets(nodes, files, kb_prefix)
    missing = []
    edges = []

    def id_of(rel):
        node_id = files.get(f"{kb_prefix}/{rel}")
        if node_id is None:
            missing.append(f"{kb_prefix}/{rel}")
        return node_id

    def visit(parent_rel, sections):
        parent_id = id_of(parent_rel)
        for section in sections:
            node_id = id_of(section["path"])
            if parent_id is not None and node_id is not None:
                edges.append(edge(parent_id, node_id, "contains",
                                  f"{kb_prefix}/{parent_rel}", 1, "EXTRACTED"))
            if node_id is not None:
                edges.extend(mention_edges(section, node_id, root, kb_prefix, targets))
            visit(section["path"], section["children"])

    visit("README.md", groups)
    return {"edges": edges, "missing": missing}


def link_graph(groups, root, graph_path):
    """Replace the `kb` edges of graph.json; returns a message per problem, or the counts."""
    text = Path(graph_path).read_text(encoding="utf-8")
    graph = parse_graph(text)
    if serialize_graph(graph) != text:
        return {"problems": [f"{graph_path}: not in the format graphify writes; nothing changed"]}
    repo_root = Path(graph_path).resolve().parent.parent
    kb_prefix = Path(root).resolve().relative_to(repo_root).as_posix()
    key = "links" if isinstance(graph.get("links"), list) else "edges"
    result = knowledge_base_edges(groups, Path(root), kb_prefix, graph["nodes"])
    if result["missing"]:
        sample = ", ".join(result["missing"][:3])
        count = len(result["missing"])
        return {"problems": [
            f"{graph_path} predates {count} knowledge-base file(s) ({sample}); "
            "run graphify update . first"
        ]}
    graph[key] = [item for item in graph[key] if item.get("_origin") != ORIGIN] + result["edges"]
    Path(graph_path).write_text(serialize_graph(graph), encoding="utf-8")
    mentions = sum(1 for item in result["edges"] if item["relation"] == "mentions")
    return {"problems": [], "contains": len(result["edges"]) - mentions, "mentions": mentions}

