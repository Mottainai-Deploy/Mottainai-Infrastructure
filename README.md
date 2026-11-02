# Mottainai Infrastructure

Infrastructure as code, deployment documentation, and operational runbooks for the Mottainai project.

## Scope

- Render: Motta Hub only, as the Agile/DevOps delivery surface. The Hub is not part of the AWS workload.
- AWS: runtime components that are required by the approved demonstration flow, isolated between test and official accounts.
- Source code remains in each service repository. This repository contains deployment definitions and operational documentation, not copies of application code.

## Current status

The service allocation is provisional until the mobile-to-API flows, external data services, and demo journey are confirmed. See the [deployment matrix](docs/deployment-matrix.md) and [AWS demo readiness checklist](docs/aws-demo-readiness.md). No AWS resources or credentials are configured here.

## Layout

- `docs/`: service allocation, architecture, and runbooks.
- `infra/aws/environments/test/`: test-account deployment entry point.
- `infra/aws/environments/official/`: official-account deployment entry point, used only after the test artifact is approved.
- `infra/aws/modules/`: reusable infrastructure modules, added after the runtime architecture is validated.
- `.github/workflows/`: CI and controlled deployment workflows.

The AWS Terraform entry points currently validate account and region selection only; they do not create resources. See [`infra/aws/README.md`](infra/aws/README.md) for safeguards and initialization guidance.

## Guardrails

- Do not commit credentials, `.env` files, account IDs, state files, or customer data.
- Keep test and official account credentials and state isolated.
- Never run test workflows against the official account.
- Promote the exact approved artifact from test to official; do not rebuild a different revision for the official account.
- Keep stateful data services outside ephemeral application containers.
- Start the official runtime only for the demonstration window unless the owner approves a different schedule.
