# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is a **documentation-only** repository (no application source code). It is
the Sphinx/reStructuredText user guide for **GEOS-Chem on cloud computing
platforms** (AWS and Google Cloud Platform), published to
[cloud-gc.readthedocs.io](http://cloud-gc.readthedocs.io). There is no code to
compile, lint, or unit-test — the only "build" is generating the HTML docs
with Sphinx, and the only correctness check is that the docs build without
Sphinx errors/warnings and render/link correctly.

## Building the docs locally

Dependencies are pinned in both `docs/environment.yml` (conda/mamba) and
`docs/requirements.txt` (pip) — keep them in sync if you change either.

```bash
# One-time setup (conda/mamba)
cd docs
conda env create -n rtd_env --file=environment.yml
conda activate rtd_env
```

```bash
# Live-reloading local preview (rebuilds on save, serves at localhost:8000)
cd docs
sphinx-autobuild source build/html

# One-shot build (equivalent to Makefile's default target routed through Sphinx "make mode")
cd docs
make html

# Clean generated output
cd docs
make clean
```

`docs/build/` is git-ignored local output — never hand-edit files there or
commit them; only `docs/source/` is version-controlled content.

ReadTheDocs itself builds via `.readthedocs.yaml` (Ubuntu 24.04, Python 3.12,
Sphinx config at `docs/source/conf.py`, deps from `docs/requirements.txt`) —
not the conda environment file.

## Structure

- `docs/source/index.rst` — the top-level `toctree`; every new `.rst` page
  must be added here under the appropriate `:caption:` section or it won't
  appear in the nav.
- `docs/source/the-basics/` — cloud account setup (AWS/GCP) prerequisites.
- `docs/source/gcclassic-on-aws/` — running GEOS-Chem Classic (single-node,
  OpenMP) on a plain AWS EC2 instance.
- `docs/source/gchp-on-aws/` — running GCHP (multi-node, MPI) on AWS
  ParallelCluster, split into a "Quickstart I" (environment prep), "Quickstart
  II" (cluster setup), and a terminology reference page.
- `docs/source/gchp-on-gcp/` — the GCP equivalent of the above: environment
  prep, Slurm cluster setup via Google's Cluster Toolkit, a page on the
  prebuilt `gchp1470-full-v2` compute image and Falcon RDMA, and a terminology
  reference page.
- `docs/source/reference/` — contributing/support docs (pulled in via
  `recommonmark` from the root `CONTRIBUTING.md`/`SUPPORT.md`), key
  references, related docs, and the "editing these docs" guide.
- `docs/source/reference/geos-chem-cloud.bib` — BibTeX source for citations
  used via `sphinxcontrib-bibtex`; add new citations here, not inline.
- `docs/source/_static/` — theme CSS overrides and images (logo, favicon,
  figures referenced from `.rst` pages).
- This site intentionally does **not** duplicate GEOS-Chem model
  configuration/compiling/science docs — those live in the separate GCHP and
  GEOS-Chem Classic ReadTheDocs manuals (cross-linked via `intersphinx` in
  `conf.py`). New content here should stay scoped to cloud infrastructure.

## Writing conventions (see `docs/source/reference/editing-these-docs.rst` for the full guide)

- Indentation in reST is **3 spaces**; separate block elements (lists,
  code-blocks) from preceding paragraphs with one blank line.
- Heading hierarchy is by underline/overline style, not size — reuse the
  existing pattern within a file rather than picking arbitrary characters:
  `#` overline+underline (page title) → `=` overline+underline (section) →
  `-` underline (sub-section) → `~` underline → `^` underline.
- Use semantic roles instead of raw formatting: `:file:`, `:program:`,
  `:envvar:`, `:code:`, `:ref:` (internal cross-refs), and
  ` .. code-block:: <language>` (`bash`, `python`, `Fortran`, `console`,
  `none`) for code/command snippets. Don't reach for bold/italics to fake
  these semantics.
- Update `CHANGELOG.md` (Keep a Changelog format) for any user-facing doc
  change, per `CONTRIBUTING.md`.
