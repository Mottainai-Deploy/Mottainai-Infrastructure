# AWS demo readiness checklist

**Purpose:** prepare the November 6 demonstration deployment without starting an AWS Academy lab or creating AWS resources during repository preparation.
**Repository evidence reviewed:** default branches only, 2026-11-02. Changes in open PRs are excluded until merged.

## Agreed guardrails

- Use the designated test account for deployment and integration testing.
- Publish to the official account only after the exact artifact passes in test; do not run functional tests or test data in official.
- Publish the approved release to official, then leave runtime stopped until the demonstration window.
- Keep Motta Hub on Render.
- Keep BI on Databricks and RPA on GitHub Actions unless a verified constraint requires a change.
- Keep the Windows POS frontend and local backend on the POS device.
- Do not create AWS resources until the demo scope, allowed services/region, account policy, data isolation, cost and teardown are reviewed.
- Do not store account IDs, credentials, tokens or production data in Git.

## Preparation status

- [x] Separate Terraform roots exist for test and official.
- [x] Terraform currently validates identity/region context only and creates no cloud resources.
- [x] Motta Hub is live on Render; the owner confirmed `/healthz` returned `{"ok":true}`.
- [x] Frontend/API integration PR #28 is merged; its default branch now describes configured API-backed routes and includes a QA container with `/healthz`.
- [x] POS product search PR #25 is merged; the POS API is still documented as a local Windows service.
- [ ] Confirm AWS Academy restrictions, allowed regions/services, quotas, credit balance/expiry and lab duration in the lab Readme.
- [ ] Select and document the exact November 6 user journey and map every action to its client, API route and dependency.
- [ ] Confirm isolated test and official data stores and credentials for each retained service.
- [ ] Confirm frontend build-time Firebase/API configuration and test-account access.
- [ ] Confirm health routes, startup commands, container build contexts, CPU/memory and startup latency for each selected runtime.
- [ ] Confirm who owns each account and can configure least-privilege, short-lived deployment access.

## Merged source changes reviewed

| Repository PR | Merge commit | Effect used in this inventory |
|---|---|---|
| [Frontend #28](https://github.com/Mottainai-One/Mottainai-Frontend/pull/28) | `cede09ace5a2dca97e07639e0b6ca4741f49db85` | Web frontend now integrates API-backed routes and documents its container and required configuration. |
| [POS backend #25](https://github.com/Mottainai-One/Mottainai-POS_back/pull/25) | `6dbe102336e9f0aeb797187324054f6cbf310f59` | Product search contract is in main; keep POS backend local and verify remaining login flow separately. |
## Current placement from default branches

| Component | Current decision | Blocker/gate |
|---|---|---|
| Motta Hub | Render only | None for AWS; keep excluded |
| RPA | GitHub Actions | Confirm schedule/network access is sufficient; do not duplicate |
| BI | Databricks | Confirm source data refresh aligns with demo |
| Admin web frontend | Conditional AWS candidate | Include only for a web-panel demo; configure Firebase/API at build time and validate routes/auth against the operational API |
| Operational SQL API | AWS candidate only | Confirm selected flow, external database, Firebase and secrets; PR #73 and #7 remain open |
| AI API | Conditional candidate | Confirm demo need and memory/startup/cost profile |
| MongoDB/Redis APIs | Conditional candidates | Include only if selected routes consume them and isolated stores exist |
| Windows POS frontend/backend | Local POS device | PR #25 is merged; verify local backend-to-operational API integration. PR #26 login change remains open and excluded |
| Customer SQL API | Excluded for now | Main branch is a starter without implemented service contracts |

## Open PRs excluded from this inventory

The following PR content is intentionally not used until merged:

- [POS backend #26](https://github.com/Mottainai-One/Mottainai-POS_back/pull/26) — login/terminal route contract.
- [Operational API #73](https://github.com/Mottainai-One/Mottainai-Api-SQL-Operacional/pull/73) — POS approvals/audit flow.
- [Operational API #7](https://github.com/Mottainai-One/Mottainai-Api-SQL-Operacional/pull/7) — CI pipeline.
- [BI #5](https://github.com/Mottainai-One/Mottainai-BI/pull/5) — KPI and inventory decisions.

Recheck each PR only after it closes. A closed PR is not automatically merged; use the resulting default-branch code and merge SHA as the source of truth. Also check any other newly opened PRs for retained repositories before preparing deployment.

## Release gates before AWS allocation

- [ ] Freeze the minimal service list from the verified demo journey.
- [ ] Check the Academy lab Readme for allowed services, regions and restrictions.
- [ ] Estimate full credit use: runtime, storage, public IPv4, network, logs, image registry, secrets and persistent databases.
- [ ] Define test/official separation, data retention and cleanup for every stateful dependency.
- [ ] Deploy and validate only in the test account. Record commit SHA, image digest, checks, acceptance evidence and teardown result.
- [ ] Promote the exact same digest to official, with isolated configuration; do not rebuild or run functional tests there.
- [ ] Keep official runtime stopped between publication and the event.
- [ ] After test, remove chargeable runtime and ephemeral network resources and inspect the billing console for residue.

## Service record template

Complete one record for each service included in the live demo:

- Repository, default branch, merge/release SHA, owner and demo responsibility.
- User journey and exact routes called; caller/callee dependencies and acceptance evidence.
- Build context and command, start command, port, CPU/memory, startup duration and stateless/stateful behavior.
- Readiness/health route and confirmation it is read-only and safe for official startup.
- External data stores, schema, required roles, network access and secret variable names (names only).
- Test/official isolation owner, expected concurrency/volume, runtime window, logs/retention and teardown.
- Test validation result, image digest, approval, official publication and rollback target.
