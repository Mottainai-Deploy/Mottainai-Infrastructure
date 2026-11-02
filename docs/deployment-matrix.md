# Service deployment matrix

This matrix reflects the default branches reviewed on 2026-11-02. Open PR changes are excluded until they are merged and reviewed.

| Component | Repository / current role | Placement | Readiness and decision |
|---|---|---|---|
| Motta Hub | `Mottainai-motta-hub`; project coordination and evidence | Render | The owner confirmed the live `/healthz` response as `{"ok":true}`. Keep outside AWS. |
| Operational SQL API | `Mottainai-Api-SQL-Operacional`; Spring Boot API, port 8080, external PostgreSQL and Firebase/JWT auth | AWS candidate, conditional | Main has a Dockerfile and CI. Requires isolated PostgreSQL, Firebase configuration, secrets and end-to-end verification. Open PR #73 and #7 are excluded. |
| AI API | `Mottainai-IA`; FastAPI/LangGraph on port 8000 | AWS candidate, conditional | Main has a Dockerfile, but includes a large ML runtime/model and multiple stores/providers. Include only if the exact demo journey needs it; measure startup, memory and cost first. |
| MongoDB API | `Mottainai-Api-NoSQL`; Spring API for AI conversations, memory and RAG | AWS candidate, conditional | Main documents JWT validation, PostgreSQL session checks and MongoDB access. Deploy only when a required demo consumer calls these routes and both stores are isolated. |
| Redis API | `Mottainai-Redis-Api`; Spring API for notifications, port 8080 | AWS candidate, conditional | Main documents `/livez` and Redis-backed `/readyz`, plus JWT and Redis requirements. Include only if notifications are part of the verified journey. |
| Customer SQL API | `Mottainai-Api-SQL-Cliente`; Spring Boot starter | Excluded until implementation is merged | Main has no implemented API contracts, runtime configuration or integration verification. Do not deploy based on documentation in another branch. |
| POS backend | `Mottainai-POS_back`; local ASP.NET Core service for desktop POS, loopback URL and SQLite queue | Local POS device | It is designed to run beside the Windows POS and synchronize with the operational API. No cloud hosting by default. Open PR #26 is excluded. |
| POS frontend | `mottainai-POS_front`; Windows WPF desktop client | Local POS device | Install alongside the local POS backend. Verify integration on the merged revisions. |
| Operational mobile app | `Mottainai-Mobile-Operacional`; Android client | No server hosting | Client app; configure it to call only the services selected for the demo. |
| Customer mobile app | `Mottainai-Mobile-Cliente`; Android client | No server hosting | Client app; API availability and end-to-end integration must be confirmed before including its journey. |
| Admin web frontend | `Mottainai-Frontend`; React prototype with local/mock data on main | Excluded from live integrated demo | Main README reports no HTTP API calls and production authentication is not configured. Open PR #28 is excluded until merged and then must be re-evaluated. |
| RPA / ETL | `Mottanai-RPA`; scheduled Python data movement and reconciliation | GitHub Actions | Keep scheduled runs there if they satisfy simulation timing and network access. Avoid adding a duplicate AWS scheduler/runtime. |
| BI | `Mottainai-BI`; Databricks bundle, ETL and dashboard | Databricks | Keep on Databricks. Open PR #5 is excluded until merged and re-reviewed. |
| PostgreSQL / MongoDB / Redis | Persistent application dependencies, hosted separately from application repos | Existing approved provider, isolated per environment | Confirm provider, owner, backup/retention, TLS, access and distinct QA/official data before use. Do not assume these databases belong in AWS. |

## Candidate AWS demo minimum

The service list is not yet frozen. Select only services called by the demonstrated user journey:

1. Operational SQL API, if the demo exercises live operational routes.
2. AI API, only for a demonstrated AI interaction.
3. MongoDB and Redis APIs only when the selected flow calls them.
4. Required persistent stores, only after confirming approved isolated test and official instances.

The desktop POS backend is local by design. The Motta Hub, mobile apps, RPA scheduler, BI dashboard and admin prototype are not default AWS workloads. Do not copy application source into this infrastructure repository; deploy versioned images/artifacts from their owning repositories.
