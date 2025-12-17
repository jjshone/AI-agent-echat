# Repository & Deployment Configuration

This document explains the repository conventions, environment config, Docker Compose layout, and CI/CD guidance for the platform.

## Repo Layout (recommended)
- services/
  - conversation-manager/
  - ai-orchestrator/
  - rag-engine/
  - action-executor/
  - auth-service/
  - gateway/
- scripts/
  - run_tests.sh
  - run_linters.sh
- infra/
  - terraform/ (or other IaC)
  - k8s/ (helm charts/operators)
- docs/
  - architecture/
  - implementation/

## Environment & Secrets
- Use `.env.example` for local development variables.
- In production, use a secrets manager (HashiCorp Vault, cloud KMS) and inject secrets via CI/CD or orchestration.
- NEVER check secrets into source control.

## Docker Compose
- `docker-compose.yml` is a development scaffold. It launches core services and default stateful stores (Postgres, Redis, MinIO, vector-db).
- Use `docker-compose.override.yml` for local development mounts.
- For production, package services into container images and deploy via orchestration (Kubernetes, ECS, or other).

## Vector Store & LLM Provider Abstraction
- The platform uses adapters for vector stores and LLMs; set `VECTOR_STORE_TYPE` and `LLM_PROVIDER` via env vars. For day-one, we recommend **Weaviate** as the canonical vector store for local and early-stage deployments; adapters must support Weaviate and at least one alternative for vendor escape.
- Adapters should be testable with a mock implementation for CI.

## CI/CD Notes
- `.github/workflows/ci.yml` runs linters and basic tests. Extend with security scans (SAST/DAST), IaC scanning, and policy linting.
- All changes to `ARCHITECTURE.md`, policy definition files, and prompts should require approvals from Security/Product/Legal as applicable.

## Local Dev Quickstart
- Copy `.env.example` to `.env` and fill secrets.
- `make up` to build and run services locally.
- `make logs` to tail logs.

## Production & Release
- Use environment-specific configuration via CI pipelines and IaC templates.
- Use canaries and blue/green or rolling deployments with automated health checks and rollback.

## Observability & Audit
- Integrate logs, metrics, and traces with the platform-level observability stack.
- Audit logs must be shipped to an immutable store with retention and e-discovery capabilities.

---

If you want, I can now produce a sample helm chart or k8s manifests for the production topology, and a more detailed CI gating checklist. Confirm next step.