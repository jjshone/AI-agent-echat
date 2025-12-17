#!/usr/bin/env bash
set -euo pipefail

# Run pytest across the repo
python -m pip install -r requirements.txt || true
pytest -q
