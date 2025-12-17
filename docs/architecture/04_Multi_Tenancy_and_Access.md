# Multi-Tenancy & Access Model (Summary)

- Tenant hierarchy: Org → Projects → Environments → Conversations
- Roles: Super-Admin, Org-Admin, Org-Owner, Support-Agent, Analyst, Developer, Auditor
- Data isolation: tenant-tagging, per-tenant stores or access filtering
- Super Admin has global powers (2-person approval for critical ops); Org Admin has tenant-scoped powers

(Full policies and cross-org rules in `ARCHITECTURE.md`.)