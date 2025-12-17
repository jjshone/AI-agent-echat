#!/usr/bin/env bash
# Simple init script to wait for Weaviate readiness and create a sample schema
set -euo pipefail

WEAVIATE_URL=${WEAVIATE_URL:-http://localhost:8080}

echo "Waiting for Weaviate at $WEAVIATE_URL..."
for i in {1..30}; do
  if curl -fsS "$WEAVIATE_URL/v1/.well-known/ready" >/dev/null 2>&1; then
    echo "Weaviate is ready"
    break
  fi
  echo "Waiting... ($i)"
  sleep 2
done

# Example schema registration (product vector class)
cat <<'JSON' > /tmp/product_schema.json
{
  "class": "Product",
  "vectorizer": "none",
  "properties": [
    {"name": "productId", "dataType": ["string"]},
    {"name": "title", "dataType": ["text"]},
    {"name": "description", "dataType": ["text"]},
    {"name": "price", "dataType": ["number"]}
  ]
}
JSON

curl -s -X POST "$WEAVIATE_URL/v1/schema" \
  -H "Content-Type: application/json" \
  -d @/tmp/product_schema.json

echo "Schema created (if not existing)."
