# Orders Connector (scaffold)

This folder contains a scaffold for an Orders API connector. Implementations should follow the connector manifest and provide idempotent, auditable actions.

Expected files:
- `manifest.yaml` — declares capabilities, auth type, and schemas.
- `tests/` — integration tests against a sandbox or mock server.

Connector contract highlights:
- Methods: `getOrder(orderId)`, `createRefund(orderId, amount, reason)`, `listOrders(filters)`
- All mutating actions must return an `action_id` and be idempotent.
- Connectors must be sandbox-testable and implement an adapter interface used by the Action Executor.
