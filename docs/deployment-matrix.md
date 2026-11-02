# Service deployment matrix

This matrix reflects default-branch code reviewed on 2026-11-02. Open PR changes remain excluded until merged.

| Component | Repository / current role | Placement | Readiness and decision |
|---|---|---|---|
| Motta Hub | `Mottainai-motta-hub`; project coordination and evidence | Render | The owner confirmed the live `/healthz` response as `{"ok":true}`. Keep outside AWS. |
| Admin web frontend | `Mottainai-Frontend`; React/TypeScript SPA connected to operational API | AWS candidate, conditional | PR #28 is merged. Main includes a Node 22 build, Nginx 1.27 image, port 8080 and read-only `/healthz`. Include only if the demo uses the web panel; configure `VITE_API_BASE_URL` and Firebase settings at build time and verify active test account/API compatibility. Some areas intentionally have no API-backed data/features. |
| Operational SQL API | `Mottainai-Api-SQL-Operacional`; Spring Boot API, port 8080, external PostgreSQL and Firebase/JWT auth | AWS candidate, conditional | Main has a Dockerfile and CI. Requires isolated PostgreSQL, Firebase configuration, secrets and route-by-route end-to-end verification. Open PR #73 and #7 remain excluded. |
| AI API | `Mottainai-IA`; FastAPI/LangGraph on port 8000 | AWS candidate, conditional | Main has a Dockerfile with a large ML runtime/model and multiple stores/providers. Include only if the exact demo journey needs it; measure startup, memory and cost first. |
| MongoDB API | `Mottainai-Api-NoSQL`; Spring API for AI conversations, memory and RAG | AWS candidate, conditional | Main documents JWT validation, PostgreSQL session checks and MongoDB access. Deploy only when a required demo consumer calls these routes and both stores are isolated. |
| Redis API | `Mottainai-Redis-Api`; Spring API for notifications, port 8080 | AWS candidate, conditional | Main documents `/livez` and Redis-backed `/readyz`, plus JWT and Redis requirements. Include only if notifications are part of the verified journey. |
| Customer SQL API | `Mottainai-Api-SQL-Cliente`; Spring Boot starter | Excluded until implementation is merged | Main has no implemented API contracts, runtime configuration or integration verification. Do not deploy based on documentation in another branch. |
| POS backend | `Mottainai-POS_back`; local ASP.NET Core service for desktop POS, loopback URL and SQLite queue | Local POS device | PR #25 (product search contract) is merged. Main documents local Windows use and syncs to the operational API. Keep on the POS device by default. Open PR #26 (login/terminal contract) remains excluded and blocks treating the complete login path as validated. |
| POS frontend | `mottainai-POS_front`; Windows WPF desktop client | Local POS device | Install alongside the local POS backend. Verify integration using merged revisions; the pending POS login change is still excluded. |
| Operational mobile app | `Mottainai-Mobile-Operacional`; Android client | No server hosting | Client app; configure it to call only the services selected for the demo. |
| Customer mobile app | `Mottainai-Mobile-Cliente`; Android client | No server hosting | Client app; API availability and end-to-end integration must be confirmed before including its journey. |
| RPA / ETL | `Mottanai-RPA`; scheduled Python data movement and reconciliation | GitHub Actions | Keep scheduled runs there if they satisfy simulation timing and network access. Avoid adding a duplicate AWS scheduler/runtime. |
| BI | `Mottainai-BI`; Databricks bundle, ETL and dashboard | Databricks | Keep on Databricks. Open PR #5 remains excluded until merged and re-reviewed. |
| PostgreSQL / MongoDB / Redis | Persistent application dependencies, hosted separately from application repos | Existing approved provider, isolated per environment | Confirm provider, owner, backup/retention, TLS, access and distinct QA/official data before use. Do not assume these databases belong in AWS. |

## Candidate AWS demo minimum

The service list is not yet frozen. Select only components called by the demonstrated user journey:

1. Admin web frontend, if the live demonstration uses the web panel.
2. Operational SQL API, if the demo exercises live operational routes.
3. AI API, only for a demonstrated AI interaction.
4. MongoDB and Redis APIs only when the selected flow calls them.
5. Required persistent stores, only after confirming approved isolated test and official instances.

The desktop POS backend is local by design. The Motta Hub, mobile apps, RPA scheduler and BI dashboard are not default AWS workloads. Do not copy application source into this infrastructure repository; deploy versioned images/artifacts from their owning repositories.
