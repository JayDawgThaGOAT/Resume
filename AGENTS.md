# Resume — Jalen Jackson CV (RenderCV)

This repository renders Jalen Jackson's resume via RenderCV v2.8. Three
role-specific CV YAML files produce PDF, PNG, HTML, Markdown, and Typst output.
Edits target the YAML source files only; rendered artifacts under `build/` are
regenerated.

## Repository Layout

```
cv/                              # YAML sources (the only files to edit)
  Jalen_Jackson_CV_Game.yaml    # Unity/Unreal gameplay-engineer variant
  Jalen_Jackson_CV_Mobile.yaml  # Mobile SDK / authentication-systems variant
  Jalen_Jackson_CV_SWE.yaml     # Cross-platform software-engineer variant
  Jalen_Jackson_CV_<Company>.yaml  # Local apply-time tailored CVs (gitignored; not pushed)
build/                           # Generated output (per-variant subdirs). Game/Mobile/SWE tracked for agent reference; company subdirs gitignored. Never hand-edited.
jobs/                            # JobSpy scrape output (CSVs). Regenerated, gitignored.
references/                      # Internal work reference docs (progress docs, tech specs, 1-pagers). Gitignored to avoid leaking company specifics.
scripts/search_jobs.py          # Thin CLI wrapper around python-jobspy's scrape_jobs()
requirements.txt                 # Python deps: rendercv[full]==2.8, python-jobspy
.venv/                           # Local virtualenv (gitignored). Recreate from requirements.txt
.vscode/tasks.json               # Cursor/VS Code tasks for rendering CVs and running JobSpy
.agents/skills/rendercv/         # Local RenderCV skill (schema, CLI reference, theme examples)
.agents/skills/jobspy/          # Local JobSpy skill (search-term syntax, params, limitations)
```

All three YAML files share the same `design` block (`engineeringclassic` theme,
Raleway font, 0.5in margins, no footer/top-note) and the same experience +
education entries. They differ in `headline`, `summary`, and the `skills`
section labels/details tailored to each role.

## Setup

Python packages live in a repo-local virtualenv (not system-wide):

```bash
python3 -m venv .venv
.venv/bin/pip install -U pip
.venv/bin/pip install -r requirements.txt
.venv/bin/rendercv --version   # expect RenderCV v2.8
```

Activate with `source .venv/bin/activate` for interactive shells, or call
`.venv/bin/rendercv` / `.venv/bin/python` directly. Cursor tasks already use
the venv binaries via `${workspaceFolder}/.venv/bin/…`.

## Development Commands

YAML sources live in `cv/`. Each variant renders into its own `build/<Variant>/`
subdir so the three PDFs don't clobber each other (they share the output filename
`Jalen_Jackson_CV.pdf`). Always pass an **absolute** `--output-folder` — a
relative path resolves relative to the YAML file (so `--output-folder build/Game`
writes to `cv/build/Game/`, not `build/Game/`). From a repo-root shell use
`"$PWD/build/<Variant>"`; Cursor/VS Code tasks use `${workspaceFolder}/build/<Variant>`.

Render one CV (outputs to `build/<Variant>/`):

```bash
.venv/bin/rendercv render cv/Jalen_Jackson_CV_SWE.yaml --output-folder "$PWD/build/SWE"
.venv/bin/rendercv render cv/Jalen_Jackson_CV_Game.yaml --output-folder "$PWD/build/Game"
.venv/bin/rendercv render cv/Jalen_Jackson_CV_Mobile.yaml --output-folder "$PWD/build/Mobile"
```

Render all three:

```bash
.venv/bin/rendercv render cv/Jalen_Jackson_CV_Game.yaml --output-folder "$PWD/build/Game" && \
.venv/bin/rendercv render cv/Jalen_Jackson_CV_Mobile.yaml --output-folder "$PWD/build/Mobile" && \
.venv/bin/rendercv render cv/Jalen_Jackson_CV_SWE.yaml --output-folder "$PWD/build/SWE"
```

Watch a single CV for changes and re-render automatically (long-running):

```bash
.venv/bin/rendercv render cv/Jalen_Jackson_CV_SWE.yaml --output-folder "$PWD/build/SWE" --watch
```

In Cursor, prefer **Terminal → Run Task…** (`.vscode/tasks.json`) over retyping
these commands — `RenderCV: Render CV` / `Watch CV` prompt for the variant and
already pass absolute `${workspaceFolder}` paths.

## Editing the CVs

- Edit only the `cv/Jalen_Jackson_CV_*.yaml` source files. Never hand-edit
  files under `build/` — they are regenerated and any manual change is lost on
  the next render.
- Each YAML file starts with a `# yaml-language-server: $schema=…v2.8…` directive,
  so the editor validates against the RenderCV v2.8 schema. Keep this line.
- When updating experience or education, apply the change to **all three** YAML
  files unless the variant is intentionally divergent (e.g. role-specific
  `summary`, `headline`, or `skills`).
- Highlights are plain strings. Avoid YAML special characters at the start of a
  value (e.g. `:`, `-`, `{`, `[`, `&`, `*`, `#`, `?`, `|`, `>`, `%`, `@`, `` ` ``)
  without quoting the string. When in doubt, double-quote. See the
  `rendercv` skill (`YAML-quoting` section) for details.
- Dates use `YYYY-MM` format (e.g. `2023-01`). Use `present` (unquoted) for
  ongoing roles.

## Validation

After editing, render the affected variant(s) and confirm the PDF/PNG generate
without errors. RenderCV exits non-zero on schema or Typst errors, which is the
primary validation gate. There is no test suite.

Because `build/` is tracked for agent reference, commit the regenerated outputs
alongside the YAML source changes so the two stay in sync.

```bash
.venv/bin/rendercv render cv/Jalen_Jackson_CV_SWE.yaml --output-folder "$PWD/build/SWE" && echo OK
```

## Known Gotchas

- `build/` is tracked (not gitignored) so agents and GitHub can reference the
  latest `.md`/`.png`/`.pdf` renderings. Always re-render the affected variant(s)
  before committing after YAML edits; otherwise `build/` will contain stale output.
- RenderCV resolves a **relative** `--output-folder` relative to the YAML file,
  not the current working directory. `--output-folder build/SWE` from the repo
  root writes to `cv/build/SWE/`, not `build/SWE/`. Always pass an absolute path
  (e.g. `"$PWD/build/SWE"` or `${workspaceFolder}/build/SWE`) — the Cursor tasks
  already do this.
- RenderCV defaults to writing output next to the YAML file
  (`cv/rendercv_output/`) when `--output-folder` is not supplied.
- The three CVs share the output filename `Jalen_Jackson_CV.pdf`. Rendering all
  three into the same folder makes them clobber each other; render each into its
  own `build/<Variant>/` subdir (the Cursor tasks do this).
- The three CVs intentionally share most content. Diverging one variant's
  experience/education from the others is almost always unintended drift —
  confirm before doing it.
- Bullets use `●` for both `bullet` and `nested_bullet` in the current `design`
  block; nested highlights will render with the same marker as top-level ones.

## Workflow

- Autonomous edits to YAML content, design tuning, and re-rendering do not
  require confirmation.
- Running JobSpy searches (the Cursor task or `scripts/search_jobs.py`) is
  autonomous — output lands in gitignored `jobs/`.
- Ask before renaming or reorganizing the YAML files (the `.vscode/tasks.json`
  commands and any external references depend on the current filenames).
- Ask before introducing a new **role** CV variant (Game/Mobile/SWE) or a new
  theme; coordinate the filename, task entry, and `build/` subdir together.
- Company-tailored CVs (`cv/Jalen_Jackson_CV_<Company>.yaml` and
  `build/<Company>/`) are local-only and gitignored — never commit or push them.
