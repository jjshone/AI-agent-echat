# Weaviate Adoption Notes

Decision: Use **Weaviate** as the canonical vector store for day-one development and validations.

Rationale:
- Easy to run locally via Docker for developer experience.
- Rich query semantics and production-grade clustering options.
- Supports schema-based classes and namespacing useful for multi-tenant setups.

What changed:
- `docker-compose.yml`: replaced Milvus with Weaviate service and added volume `weaviate-data`.
- `.env.example`: `VECTOR_STORE_TYPE=weaviate`; Weaviate connection env vars added.
- `scripts/init_weaviate.sh`: bootstrap script that waits for readiness and registers a sample `Product` schema.
- `docs/implementation/WEAVIATE_README.md`: adapter contract and testing notes.
- `ARCHITECTURE.md` and `ROADMAP.md`: updated to reflect day-one selection and guidance.
- CI: added integration job to run Weaviate for adapter integration tests.

Operational notes:
- In production, disable anonymous access and configure auth for Weaviate (API keys or OIDC).
- Use per-tenant namespaces (class naming or separate clusters) and tenant-specific key wrapping where required.

Rollback path:
- Adapters are still required to implement generic contracts (index/query/delete). If a different vector store is selected later, change `VECTOR_STORE_TYPE` and run adapter compatibility tests in CI.
