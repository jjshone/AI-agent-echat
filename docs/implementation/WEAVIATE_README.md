# Weaviate Adapter & Local Weaviate Notes

This document provides guidance for using Weaviate as the default vector store for the platform.

- Default: `VECTOR_STORE_TYPE=weaviate`
- Local dev: docker-compose launches Weaviate at `http://vector-db:8080` mapped to host `localhost:8080`.
- Init script: `scripts/init_weaviate.sh` registers a sample `Product` schema and waits for readiness.
- Adapter contract: the adapter must accept env-driven endpoint and auth settings, provide `index`, `query`, `delete` primitives, and return provenance metadata for hits.
- Security: in production disable anonymous access and configure auth (API keys or OIDC); configure per-tenant namespaces and KMS wrapping where required.

Testing notes:
- Provide unit tests that mock Weaviate client and integration tests that run against a local Weaviate container.
