# Release Process

This repository follows a tag-driven release process and uses Release Drafter to generate draft releases.

Process
1. Prepare changes on a feature branch and open a PR with appropriate labels (feature, bug, infra, test).
2. Merge PRs to `main` after code review and CI passing.
3. Release Drafter drafts a release on merges (detailed in `.github/release-drafter.yml`).
4. Create an annotated tag to trigger an automated release workflow (example):
   - `scripts/release.sh 0.1.0` (creates and pushes `v0.1.0` tag)
5. On tag push (pattern `v*`), `.github/workflows/release.yml` runs tests and creates a GitHub Release.

Notes
- The release workflow runs tests; failing tests will block release creation.
- For complex releases, create the tag after the release candidate is validated in staging.
- For emergency fixes, follow the emergency release runbook in `PRODUCTION_DEPLOYMENT.md`.
