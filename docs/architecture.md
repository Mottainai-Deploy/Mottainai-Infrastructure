# Deployment architecture

## Provider boundaries

- **Render:** Motta Hub only. The owner confirmed its live health endpoint. It remains the project coordination and evidence surface.
- **GitHub Actions:** RPA schedules and CI where the current workflows satisfy the simulation.
- **Databricks:** BI ETL and dashboard.
- **Local Windows POS:** POS frontend and local backend run together on the store/demo machine.
- **AWS:** only the minimum server-side APIs proven necessary by the November 6 user journey. Test and official accounts remain separate; publish the approved artifact to official and leave runtime stopped until the demonstration.

## Service flow

```text
Android clients ───────────────┐
                               ├─> selected APIs ──> isolated data stores/providers
Windows POS frontend -> local POS backend ──> operational API
RPA (GitHub Actions) ───────────────────────> database synchronization
BI (Databricks) <──────────────────────────── RPA/analytics data
Motta Hub (Render) ── project coordination and evidence only
```

This is a responsibility map, not an approved network design. Verify the actual demo path, APIs and database contracts against merged main branches before selecting AWS components. The admin web frontend on main is a mock-data prototype and is excluded from the live integrated path.

## Cost and runtime constraints

The two AWS Academy accounts each have US$50 total credit. This repository intentionally does not create compute, databases, networking or secrets. Academy service and region restrictions, account credits and quotas must be checked in the lab readme before a deployment design is selected.

Use the test account for experiments. Build once, validate the artifact and integrations in test, record its immutable image digest/revision, then publish that exact artifact to official. Do not run functional tests in official. Keep official runtime stopped until the event window and tear down chargeable test resources after the test session.

The current application dependencies include external PostgreSQL, MongoDB, Redis, Firebase, AI/weather providers and Databricks. Do not assume they should move into AWS. First confirm which are required by the exact journey and whether separate school-provided test and official instances already exist.

## Promotion sequence

1. Select the demo journey and map each action to a client, API route and dependency.
2. Confirm the selected service build, health route, resource profile and secret names from merged code.
3. Check AWS Academy allowed services/regions, quotas, credit and expiry.
4. Choose the smallest runtime supported by the Academy and estimate total cost including network, public IPv4, logs, images and any persistent data.
5. Deploy to test and validate end to end; save commit SHA, image digest, acceptance evidence and teardown result.
6. Publish the same artifact to official, with isolated official configuration, and keep runtime stopped until November 6.
7. At the event, start the approved runtime and use only a non-mutating health check; stop it after the demonstration.

## Decisions still required

- Which exact journey must work on November 6: Android operations, customer mobile, Windows POS, AI, notifications, or a subset?
- Which API routes are actually called by each client in the merged revisions?
- Are separate test and official databases already available, and who owns them?
- Which AWS services, regions and instance types are allowed by this specific Learner Lab?
- Who owns each account and can create short-lived least-privilege deployment credentials?
