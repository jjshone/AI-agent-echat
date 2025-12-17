# Production Deployment Guide

This document outlines the recommended approach for deploying the platform to production.

Key Principles
- Immutable infrastructure and IaC (Terraform / CloudFormation). Do not rely on ad-hoc changes in the cluster.
- Use managed services where practical (managed DBs, managed vector store or dedicated Weaviate cluster) for availability and compliance.
- Secrets must be managed via a secure vault (HashiCorp Vault, cloud provider KMS) and injected via the orchestrator.
- Per-tenant keys: use tenant key-wrapping or dedicated keys where required by tenant policy.

Environments
- dev, test, staging, prod (optionally prod-isolated per top-tier tenants).

Deployment Patterns
- Build artifacts in CI and publish to an internal registry.
- Use blue/green or canary deployments with automated health checks and rollback.
- Migrate data using migration jobs with careful monitoring and rollback plans.

Operational Considerations
- Observability: central logs, metrics, traces, and audit streams routed to a secure, WORM-capable storage.
- Backups: regular backups of DBs, vector store snapshots, and audit logs; test restoration periodically.
- Security: runtime policies, network segmentation, and emergency access procedures.

Compliance
- Define retention and legal hold policy for audit artifacts and conversation data.
- Threat model and data classification must be validated prior to accepting regulated tenants.

Weaviate Recommendations
- Use a managed Weaviate offering or run Weaviate with k8s StatefulSets and PVCs, with OIDC or API-key-based auth; disable anonymous access.
- Set up multi-tenancy isolation via namespacing or separate Weaviate instances for high-security tenants.

CI/CD & Releases
- All changes must pass CI (unit, integration, security scans) and PR reviews.
- Use Git tag-based releases for production promotions and keep a release changelog.

Rollbacks
- Maintain DB migration compatibility and rolling migrations; ensure quick rollback playbooks and backups before schema changes.

Security & Incident Response
- Maintain runbooks for common incidents (data leakage, credential compromise). Ensure an audit trail for any emergency admin actions.
