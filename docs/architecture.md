# Deployment architecture (initial)

## Provider boundaries

- **Render:** Motta Hub only. It remains the project coordination/evidence surface, not an application dependency for the business system and not an AWS workload.
- **AWS test account:** short-lived validation of the selected application runtime and integrations.
- **AWS official account:** isolated deployment of the approved release for the November 6 demonstration; do not use it for exploratory tests. Keep runtime stopped until the demonstration window.
- **External platforms:** Databricks remains BI; GitHub Actions remains the scheduled RPA runner unless validated constraints require a change.

## Candidate application topology

Clients (mobile devices) -> selected APIs -> isolated database/services. The chatbot may consume PostgreSQL, MongoDB, Redis and external AI/weather providers. The exact graph must be checked against source code and the demo flow before infrastructure is provisioned.

## Cost and reliability constraints

The AWS accounts have US$50 total credit each. This repository intentionally does not choose expensive managed database products or provision compute yet. First identify whether school-provided vendor services can safely provide isolated test/official data. If AWS persistence is required, price a minimal architecture before deployment. Use a small stateless runtime and explicit start/stop controls; do not introduce Kubernetes for this workload.

## Promotion

Build once, deploy to test, validate application and integration evidence, approve the exact image digest/revision, then deploy that same artifact to official. Keep official secrets and data isolated. Schedule runtime start/stop for the demo window.

## Open decisions

- Which user journey must work live on November 6?
- Which API endpoints do both mobile apps call in the selected journey?
- Which DBs are required, and are school-provided services available with separate test/official databases?
- Who owns the AWS accounts and creates least-privilege credentials?
- What exact Render service is expected for the Hub, and is the Render OAuth authorization complete?
