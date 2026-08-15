# Resume — Jalen Jackson CV (RenderCV)

This repository renders Jalen Jackson's resume via RenderCV v2.8. One YAML
file at the repo root produces PDF, PNG, HTML, Markdown, and Typst output.
Edits target `Jalen_Jackson_CV.yaml` only; files under `rendercv_output/` are
regenerated.

## Repository Layout

```
Jalen_Jackson_CV.yaml            # Source (content + design). The only file to edit.
Jalen_Jackson_CV_<Company>.yaml  # Local apply-time tailored CVs (gitignored; not pushed)
rendercv_output/                 # Generated output. Tracked. Never hand-edited.
.github/workflows/render.yml     # Auto-render on push to main
requirements.txt                 # Python deps: rendercv[full]==2.8
.venv/                           # Local virtualenv (gitignored). Recreate from requirements.txt
.vscode/tasks.json               # Cursor/VS Code tasks for rendering
.agents/skills/rendercv/         # Local RenderCV skill (schema, CLI reference, theme examples)
references/                      # Internal work reference docs. Gitignored.
```

## Setup

Python packages live in a repo-local virtualenv (not system-wide):

```bash
python3 -m venv .venv
.venv/bin/pip install -U pip
.venv/bin/pip install -r requirements.txt
.venv/bin/rendercv --version   # expect RenderCV v2.8
```

Activate with `source .venv/bin/activate` for interactive shells, or call
`.venv/bin/rendercv` directly. Cursor tasks already use
`${workspaceFolder}/.venv/bin/rendercv`.

## Development Commands

From the repo root:

```bash
.venv/bin/rendercv render Jalen_Jackson_CV.yaml
.venv/bin/rendercv render Jalen_Jackson_CV.yaml --watch
```

Output lands in `rendercv_output/` next to the YAML file. Cursor/VS Code tasks
`RenderCV: Render CV` and `RenderCV: Watch CV` pass an absolute
`--output-folder` (`${workspaceFolder}/rendercv_output`).

A relative `--output-folder` is resolved relative to the YAML file, not the
current working directory. Prefer omitting it (defaults are correct for a
root-level YAML) or passing an absolute path.

GitHub Actions re-renders on push to `main` when `Jalen_Jackson_CV.yaml`
changes and commits `rendercv_output/`.

## Editing the CV

- Edit only `Jalen_Jackson_CV.yaml`. Never hand-edit files under
  `rendercv_output/` — they are regenerated.
- Keep the `# yaml-language-server: $schema=…v2.8…` directive at the top of
  the YAML file.
- Highlights are plain strings. Avoid YAML special characters at the start of a
  value (e.g. `:`, `-`, `{`, `[`, `&`, `*`, `#`, `?`, `|`, `>`, `%`, `@`, `` ` ``)
  without quoting the string. When in doubt, double-quote. See the
  `rendercv` skill (`YAML-quoting` section) for details.
- Dates use `YYYY-MM` format (e.g. `2023-01`). Use `present` (unquoted) for
  ongoing roles.

## Validation

After editing, render and confirm the PDF/PNG generate without errors.
RenderCV exits non-zero on schema or Typst errors, which is the primary
validation gate. There is no test suite.

Because `rendercv_output/` is tracked, commit the regenerated outputs
alongside YAML source changes (or rely on the GitHub Actions commit).

```bash
.venv/bin/rendercv render Jalen_Jackson_CV.yaml && echo OK
```

## Known Gotchas

- `rendercv_output/` is tracked so GitHub can serve the latest PDF/PNG. Always
  re-render after YAML edits if you are not waiting for Actions.
- Bullets use `●` for both `bullet` and `nested_bullet` in the current `design`
  block; nested highlights will render with the same marker as top-level ones.

## Workflow

- Autonomous edits to YAML content, design tuning, and re-rendering do not
  require confirmation.
- Ask before renaming `Jalen_Jackson_CV.yaml` (tasks, the GitHub Actions
  workflow, and README links depend on it).
- Ask before introducing a new **public** CV variant or a new theme.
- Company-tailored CVs (`Jalen_Jackson_CV_<Company>.yaml`) are local-only and
  gitignored — never commit or push them.
