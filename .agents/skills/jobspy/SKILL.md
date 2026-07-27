---
name: jobspy
description: |
  Run python-jobspy searches from this repo to find roles matching the CV
  variants, then tailor a CV in cv/ for the chosen posting. Use when the user
  asks to search jobs, scrape job boards, find roles, or use JobSpy.
disable-model-invocation: false
---

# JobSpy — job-board search reference

`python-jobspy` (PyPI: `python-jobspy`, import `jobspy`) is a job-board scraper
that aggregates postings from LinkedIn, Indeed, Glassdoor, Google,
ZipRecruiter, Bayt, Naukri, and Bdjobs into a single pandas DataFrame. This
repo uses it via `scripts/search_jobs.py` (a thin CLI wrapper) plus a Zed task
with the user's default search.

## Installation (this environment)

JobSpy is already installed system-wide: `python3 -c "import jobspy"` works on
Python 3.12. Do not reinstall unless `pip install -U python-jobspy` is
explicitly requested. Outside this environment: `pip install -U python-jobspy`
(requires Python >= 3.10).

## Running a search

Prefer the wrapper script over calling `scrape_jobs()` directly — it handles
output paths, timestamps, and the gitignored `jobs/` folder.

```bash
# Default search (the Zed task "JobSpy: Default search" runs this)
python3 scripts/search_jobs.py

# Custom search — see --help for all flags
python3 scripts/search_jobs.py --search-term "Unity C# mobile engineer" \
  --location "Remote" --site indeed --results 20 --hours-old 72 --remote

# Multiple sites
python3 scripts/search_jobs.py --site indeed --site linkedin --site google

# Save full job descriptions (slower, more requests)
python3 scripts/search_jobs.py --fetch-description
```

Output lands at `jobs/jobs_<YYYYMMDD_HHMMSS>.csv` (gitignored). The script also
prints a short summary table (title, company, location, url) to stdout.

## scrape_jobs() parameters (when scripting directly)

| Parameter | Type | Notes |
|---|---|---|
| `site_name` | list\|str | `linkedin`, `zip_recruiter`, `indeed`, `glassdoor`, `google`, `bayt`, `naukri`, `bdjobs` |
| `search_term` | str | Free-text query; supports boolean (see below) |
| `google_search_term` | str | Google Jobs only — copy exactly what the Google Jobs UI shows |
| `location` | str | LinkedIn & ZipRecruiter use only this; Indeed/Glassdoor pair it with `country_indeed` |
| `distance` | int | Radius in miles (default 50) |
| `job_type` | str | `fulltime`, `parttime`, `internship`, `contract` |
| `is_remote` | bool | Remote-only filter |
| `results_wanted` | int | Per site (default ~15) |
| `hours_old` | int | Filter by hours since posted (Indeed/LinkedIn: only one of `hours_old`/`easy_apply` may be set) |
| `easy_apply` | bool | LinkedIn easy-apply filter no longer works |
| `country_indeed` | str | Required for Indeed/Glassdoor — see country list in upstream README |
| `description_format` | str | `markdown` (default) or `html` |
| `linkedin_fetch_description` | bool | Fetch full LinkedIn descriptions + direct URLs (slower, O(n) extra requests) |
| `proxies` | list | `["user:pass@host:port", ..."]` — round-robinned per scraper |
| `verbose` | int | 0 = errors only, 1 = +warnings, 2 = all logs (default) |
| `enforce_annual_salary` | bool | Convert wages to annual |
| `offset` | int | Start from the Nth result |

Full signature: <https://github.com/speedyapply/JobSpy#parameters-for-scrape_jobs>

## Search-term syntax (Indeed especially)

Indeed searches the **description** as well as the title, so unspecific
queries return noise. Use boolean operators:

- `"exact phrase"` — quote for exact match
- `-word` — exclude (e.g. `-tax -marketing`)
- `(java OR python OR c++)` — any of these
- Bare words — all must appear

Good example from the upstream README:

```
search_term='"engineering intern" software summer (java OR python OR c++) 2025 -tax -marketing'
```

Requires: `software`, `summer`, `2025`, one of the languages, the exact phrase
`engineering intern`; excludes `tax` and `marketing`.

Google Jobs is even stricter — `google_search_term` must match what appears in
the Google Jobs UI after applying filters. If Google returns no results, the
query syntax is wrong, not JobSpy.

## Limitations (per site)

- **Indeed**: only ONE of these may be used per search: `hours_old`, OR
  (`job_type` & `is_remote`), OR `easy_apply`.
- **LinkedIn**: only ONE of `hours_old` OR `easy_apply` may be used per search.
- **All boards**: capped at ~1000 results per search.
- **LinkedIn**: rate-limits around the 10th page per IP — proxies are basically
  required for serious LinkedIn use.
- **Indeed**: best scraper currently, no rate limiting.

## HTTP 429 (rate-limited)

You've been blocked for too many requests. Recovery:
- Wait between scrapes (site-dependent).
- Use the `proxies` parameter to rotate IPs.
- Reduce `results_wanted` or scope to one site.

## Workflow after a search

1. Run the JobSpy task → scan `jobs/jobs_*.csv`.
2. Pick a posting.
3. Copy the closest CV variant: `cp cv/Jalen_Jackson_CV_SWE.yaml cv/Jalen_Jackson_CV_<Company>.yaml`.
4. Edit `headline`, `summary`, and relevant bullets to match the JD.
5. Render: `rendercv render cv/Jalen_Jackson_CV_<Company>.yaml --output-folder "$PWD/build/<Company>"` (or use a per-variant Zed task).
6. Apply.

JobSpy finds roles; it does **not** tailor the CV or fetch a single URL — for
a specific posting you already have, copy the JD text into `jobs/<company>.md`
manually. See the repo's `AGENTS.md` for the CV-authoring loop.
