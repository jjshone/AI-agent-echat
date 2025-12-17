#!/usr/bin/env bash
set -euo pipefail

# Bring up services (build images)
docker compose up -d --build

# Wait for backend readiness
for i in {1..30}; do
  if curl -fsS http://localhost:8000/health >/dev/null 2>&1; then
    echo "Backend ready"; break
  fi
  echo "Waiting for backend... ($i)"
  sleep 2
done

# Run backend tests inside container
if docker compose exec -T backend pytest -q; then
  echo "Backend tests passed"
else
  echo "Backend tests failed"
  docker compose logs backend --tail=200
  exit 1
fi

# Run frontend tests via local npm (we install dev deps)
pushd frontend >/dev/null
npm ci --silent || npm i --silent
npm test --silent || (echo "Frontend tests failed" && exit 1)
popd

echo "Integration tests completed."
