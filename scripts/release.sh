#!/usr/bin/env bash
set -euo pipefail

VERSION=${1:-}
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version> (e.g., 0.1.0)"
  exit 1
fi
TAG=v${VERSION}

echo "Creating annotated tag $TAG"
git tag -a "$TAG" -m "Release $TAG"
git push origin "$TAG"

echo "Tag pushed: $TAG"

echo "Create a GitHub release (if release workflow runs on tag pushes, it will create the release automatically)."