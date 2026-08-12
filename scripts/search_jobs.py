#!/usr/bin/env python3
"""Thin CLI wrapper around python-jobspy's scrape_jobs().

Writes results to jobs/jobs_<YYYYMMDD_HHMMSS>.csv (gitignored) and prints a
short summary table to stdout. Defaults target Unity/Unreal engineering roles (boolean query with
light noise exclusions), remote, Indeed+LinkedIn, last 7 days.

See .agents/skills/jobspy/SKILL.md for the full scrape_jobs() reference.
"""
from __future__ import annotations

import argparse
import csv
import sys
from datetime import datetime
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
DEFAULT_OUTPUT_DIR = REPO_ROOT / "jobs"


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(
        description="Search job boards via python-jobspy. Output: jobs/jobs_<timestamp>.csv",
    )
    p.add_argument(
        "--search-term",
        default=(
            '("Unity" OR Unreal) (engineer OR developer) '
            "(mobile OR iOS OR Android OR gameplay OR C# OR C++) -QA -marketing"
        ),
        help="Job search query (supports boolean: \"exact\" -exclude (a OR b))",
    )
    p.add_argument("--location", default="Remote", help="Job location")
    p.add_argument(
        "--site",
        action="append",
        default=None,
        choices=["linkedin", "indeed", "glassdoor", "google", "zip_recruiter", "bayt", "naukri", "bdjobs"],
        help="Job site(s) to search. Repeatable. Default: indeed, linkedin",
    )
    p.add_argument("--results", type=int, default=25, help="Results per site (default 25)")
    p.add_argument("--hours-old", type=int, default=168, help="Hours since posted (default 168 = 7 days)")
    p.add_argument("--remote", action="store_true", default=True, help="Remote-only (default True)")
    p.add_argument("--no-remote", dest="remote", action="store_false", help="Include non-remote roles")
    p.add_argument("--country-indeed", default="USA", help="Indeed/Glassdoor country (default USA)")
    p.add_argument(
        "--fetch-description",
        action="store_true",
        help="Fetch full job descriptions (slower; LinkedIn: linkedin_fetch_description=True)",
    )
    p.add_argument("--job-type", default=None, choices=["fulltime", "parttime", "internship", "contract"])
    p.add_argument("--distance", type=int, default=50, help="Radius in miles (default 50)")
    p.add_argument(
        "--output-dir",
        default=str(DEFAULT_OUTPUT_DIR),
        help=f"Output directory (default {DEFAULT_OUTPUT_DIR})",
    )
    return p.parse_args()


def main() -> int:
    args = parse_args()

    # Import lazily so --help works without jobspy installed.
    try:
        from jobspy import scrape_jobs
    except ImportError:
        print(
            "python-jobspy not installed. From the repo root, run:\n"
            "  python3 -m venv .venv && .venv/bin/pip install -r requirements.txt\n"
            "Then use .venv/bin/python (Cursor tasks already do).",
            file=sys.stderr,
        )
        return 1

    sites = args.site or ["indeed", "linkedin"]
    if isinstance(sites, str):
        sites = [sites]

    print(f"Searching {', '.join(sites)} for '{args.search_term}' in '{args.location}'...", file=sys.stderr)

    jobs = scrape_jobs(
        site_name=sites,
        search_term=args.search_term,
        location=args.location,
        distance=args.distance,
        is_remote=args.remote,
        results_wanted=args.results,
        hours_old=args.hours_old,
        country_indeed=args.country_indeed,
        job_type=args.job_type,
        linkedin_fetch_description=args.fetch_description,
        description_format="markdown",
    )

    if jobs.empty:
        print("No jobs found. Try broadening the search (more sites, larger --distance, fewer filters).", file=sys.stderr)
        return 0

    # Write CSV
    out_dir = Path(args.output_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    csv_path = out_dir / f"jobs_{stamp}.csv"
    jobs.to_csv(csv_path, index=False, quoting=csv.QUOTE_NONNUMERIC)
    print(f"\nWrote {len(jobs)} jobs to {csv_path}", file=sys.stderr)

    # Print a short summary table to stdout (uppercase headers for readability)
    cols = ["title", "company", "location", "job_url"]
    available = [c for c in cols if c in jobs.columns]
    summary = jobs[available].copy()
    if "job_url" in summary.columns:
        summary["job_url"] = summary["job_url"].astype(str).str.slice(0, 80)
    summary.columns = [c.upper() for c in available]
    with pd_option_context():
        print(summary.to_string(index=False))
    return 0


def pd_option_context():
    import pandas as pd
    return pd.option_context("display.max_rows", None, "display.max_columns", None,
                             "display.width", None, "display.max_colwidth", 80)


if __name__ == "__main__":
    raise SystemExit(main())
