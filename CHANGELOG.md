# GCPy Changelog

All notable changes to geos-chem-cloud will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] - TBD
### Added
- Added separate folders `docs/source/gcclassic-on-aws` and `docs/source/gchp-on-aws` so as to keep GC-Classic and GCHP documentation for AWS separate
- Added `.readthedocs.yaml` to the root folder
- Added the "Help & Reference" section (Contributing guidelines, Support Guidelines, Editing these docs, Key References)
- Added "View related documentation"
- Added `the-basics/getting-started.rst` page with documentation links
  to AWS cloud
- Added `.gitignore` in the root-level folder
- Added `docs/source/gcclassic-on-gcp/gcc-GCP.rst`: running GEOS-Chem
  Classic on Google Cloud (single-node, OpenMP, one Compute Engine VM)
- Added Google Cloud account-setup links (account creation, IAM, gcloud
  CLI, Compute Engine, billing) to `the-basics/getting-started.rst`
- Added a GCP benchmark figure and expanded the "Measured performance"
  section on `docs/source/gchp-on-gcp/falcon-rdma-image.rst`

### Changed
- Updated `AUTHORS.txt` and `LICENSE.txt` as of Feb 2026 (GEOS-Chem 14.7.0)
- Updated `index.rst`
- Updated `environment.yml` and `requirements.rst` with the same Python packages as used by other GC repos
- Added formatting updates and new content about spot instances to the GC-Classic guide
- Added formatting updates (and other updates for consistency) to the GCHP guide

### Removed
- Removed all previous documentation pages, as they are out of date
