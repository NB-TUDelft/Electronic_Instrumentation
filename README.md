# EI Manuals

This repository contains the Jupyter Book source for the **NB2420 Electronic Instrumentation** manuals. The content is organised as a teaching manual rather than as a generic software template: the book combines introductory equipment guides, week-based practicum manuals, shared assets, and build configuration for publishing the material as a website.

## Purpose

Use this repository to:

- write and maintain practicum manuals in a consistent format;
- keep notebooks, images, and shared assets in predictable locations;
- publish the manuals as a Jupyter Book;
- preserve a writing style.

## Project structure

```text
.
├── book/
│   ├── _config.yml                 # Jupyter Book configuration
│   ├── _toc.yml                    # Table of contents / publication order
│   ├── intro.md                    # Book landing page
│   ├── credits.md                  # Credits page
│   ├── references.bib              # Shared bibliography
│   ├── static/                     # Global static assets (CSS, JS, icons, downloads)
│   ├── images/                     # Book-level shared images
│   └── manuals/
│       ├── intros/                 # Introductory equipment and tooling manuals
│       │   ├── EI_manual_intros.md
│       │   ├── *.ipynb
│       │   └── images/
│       └── week1/                  # Week-specific manuals and their local assets
│           ├── _summary.ipynb
│           ├── 1.1_voltage_divider.ipynb
│           ├── 1.2_intro_to_oscilloscope_and_filters.ipynb
│           └── images/
├── old/                            # Legacy material kept for reference/migration
├── pyproject.toml                  # Python project metadata and dependencies
├── requirements.txt                # Dependency export / compatibility file
├── uv.lock                         # Locked dependency versions
└── README.md
```

## Folder responsibilities

### `book/`

This is the only directory that should contain publishable book content and assets that are part of the current book build.

### `book/manuals/intros/`

Place introductory manuals here when they teach equipment, software, or workflows that will be reused across multiple weeks. Examples in this repository include the DMM, scope, LTspice, ALPACA, breadboard, and test-board introductions.

### `book/manuals/weekX/`

Create one folder per teaching week or module. Each week folder should contain:

- a `_summary.ipynb` page that introduces the week;
- the numbered manuals for that week, for example `1.1_voltage_divider.ipynb`;
- an `images/` folder for assets that are only used by that week.

### `book/static/`

Use this for assets that are global to the whole book and not tied to a single manual, such as:

- CSS overrides;
- JavaScript helpers;
- icons and favicons;
- downloadable files used across multiple pages.

### `book/images/`

Use this only for images reused at book level. If an image belongs to one manual or one week only, store it closer to that content instead.

### `old/`

Keep legacy notebooks and source material here only as reference. Do not treat `old/` as the source of truth for current published content. If material is revived from `old/`, move or rewrite it into `book/` and adapt it to the current style.

## File distribution guidelines

To keep the repository understandable, distribute files by scope:

- **Single-manual assets** go next to that manual, usually in the local `images/` folder for the same week or intro.
- **Week-wide assets** stay inside that specific `book/manuals/weekX/` folder.
- **Cross-book assets** go in `book/static/` or `book/images/`, depending on whether they are functional assets or shared figures.
- **Current teaching content** belongs in `book/`.
- **Archived or historical content** belongs in `old/`.

A good rule is: store files as close as possible to the content that owns them, but no closer than necessary.

## Writing and style guidelines

### 1. Organise each manual around the learning workflow

- **Preparatory Homework** for individual pre-lab thinking:
  - **Background** for background reading and preparation;
  - **Anticipate** for preparing for the lab;
  - **Simulate** for model building or LTspice work when relevant;
- **Practicum** for lab execution in pairs:
  - **Implement and investigate** for lab execution in pairs;
  - **Compare and conclude** for reflection, comparison, and conclusions.

If a section is not relevant, adapt the structure sensibly rather than forcing it. The main goal is that students can clearly see what to do before, during, and after the lab.

### 2. Write task instructions clearly and directly

Task prompts should:

- start with an action verb such as *calculate*, *measure*, *build*, *compare*, or *explain*;
- be specific about what students should record;
- avoid vague placeholders and template wording;
- tell students why keeping notes matters, without over-referencing future tasks.

Prefer wording like:

- “Record this clearly in your notepad, because it will make later comparison easier.”

Avoid wording like:

- “Note this for Task C1.”

The first version encourages good practice; the second feels like a bookkeeping reminder.

### 3. Match the tone of manuals

Aim for a tone that is:

- supportive, but not overly chatty;
- practical and instructional;
- precise about measurements, units, and expected outputs;
- encouraging about note-taking, checking, and comparing results.

### 4. Use consistent notebook structure

Inside notebooks:

- use clear heading levels in order;
- keep one main purpose per task;
- group figures close to the task that uses them;
- use admonitions for preparation notes, important workflow notes, answers, and warnings;
- keep tables and comparison prompts easy to copy into a notebook or report.

### 5. Be explicit about collaboration

When a practicum is done in pairs, say so clearly and give practical examples of how students can split the work fairly, as Manual 1.1 does.

### 6. Prefer explanation over cross-referencing

If students should keep a result for later, encourage them to keep a clear record because they will compare or use it later. Do not overfill the text with forward references unless the exact task link is genuinely necessary for navigation.

### 7. Keep formatting and terminology consistent

- Use numbered manual filenames such as `1.1_voltage_divider.ipynb`.
- Keep units formatted consistently.
- Use the same names for recurring phases and task labels.
- Reuse existing terminology for equipment and course components.

## Adding or revising a manual

Recommended workflow:

1. Decide whether the content belongs in `intros/` or in a specific `weekX/` folder.
2. Create or update the notebook in the correct folder.
3. Add only the assets that notebook needs, ideally in the nearest scoped `images/` folder.
4. Update `book/_toc.yml` so the manual appears in the published book.
5. Build the book locally before merging.

## Build and development

Install dependencies with your preferred Python environment manager. This repository already defines the project metadata in `pyproject.toml` and keeps a lockfile in `uv.lock`.

Typical local workflow:

```bash
uv sync
uv run jupyter-book build book
```

If you use a different environment manager, install the dependencies from `pyproject.toml` or `requirements.txt` and then run the Jupyter Book build command.

## Maintenance notes

- Keep `book/_toc.yml` aligned with the actual folder structure.
- Remove or rename throwaway files before merging.
- Treat this README as the repository-specific guide, not as a generic template file.
