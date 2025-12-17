#!/usr/bin/env bash
set -euo pipefail

# Use .env.example for tests if .env doesn't exist
if [ ! -f .env ]; then
  echo "No .env found; copying .env.example to .env for test run"
  cp .env.example .env
fi

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

# Wait for gateway readiness
for i in {1..30}; do
  if curl -fsS http://localhost:8082/health >/dev/null 2>&1; then
    echo "Gateway ready"; break
  fi
  echo "Waiting for gateway... ($i)"
  sleep 2
done

# Wait for Weaviate readiness
for i in {1..60}; do
  if curl -fsS http://localhost:8080/v1/.well-known/ready >/dev/null 2>&1; then
    echo "Weaviate ready"; break
  fi
  echo "Waiting for Weaviate... ($i)"
  sleep 2
done

# Run backend tests in ephemeral python container mounting backend sources
if docker run --rm -v "$PWD/backend":/src -w /src python:3.11-slim sh -lc "pip install -r requirements.txt && pytest -q"; then
  echo "Backend tests passed"
else
  echo "Backend tests failed"
  docker compose logs backend --tail=200
  exit 1
fi

# Run frontend tests in ephemeral node container
if docker run --rm -v "$PWD/frontend":/app -w /app node:20-alpine sh -lc "npm ci --silent || npm i --silent; npm test --silent"; then
  echo "Frontend tests passed"
else
  echo "Frontend tests failed"
  docker compose logs frontend --tail=200
  exit 1
fi

echo "Integration tests completed."
