# Service deployment matrix

| Component | Current location / role | Proposed target | Decision and readiness |
|---|---|---|---|
| Motta Hub | Project hub and Agile/DevOps evidence | Render | Render-only. Keep outside AWS. Render connection still needs authorization to complete; blueprint exists in the Hub repository. |
| Chatbot API (`Mottainai-IA`) | FastAPI; uses PostgreSQL, MongoDB, Redis, LLM provider, Open-Meteo, and Gemini for image analysis | AWS candidate, conditional | Include only if chat, predictive, or shelf-analysis paths are in the demonstration. Container exists; integration, secrets, data sources, and memory/cost profile need validation. |
| Operational SQL API | Employee, store, inventory, and sales operations | AWS candidate, conditional | Likely required for live operational mobile flows. Dockerfile and API docs exist; validate auth, DB, Firebase, and exact routes with the mobile app before selecting it. |
| MongoDB API | Exposes selected conversations, metrics, memories, and RAG data | AWS candidate, conditional | Only if a demo consumer calls these routes. Mobile consumption is described as planned, not yet confirmed. |
| Redis API | Notification reads and read-state updates | AWS candidate, conditional | Only if the demonstration includes live notifications. Confirm mobile contract, JWT compatibility, and Redis queue behavior. |
| PostgreSQL / MongoDB / Redis | Persistent/temporary dependencies | Managed/external services, isolated per environment | Do not run as disposable containers. Decide on managed or approved vendor services after checking account credit, data needs, and persistence. Test and official must never share credentials or mutable test data. |
| Mobile Operational / Mobile Client | Client applications installed on devices | No server hosting | Build and configure against the selected API endpoints; mobile apps themselves do not run on Render/AWS. |
| Admin Web Frontend | Current README describes mock/local data and no HTTP API calls | No production deployment yet | Treat as prototype. Do not present as an integrated production UI until API integration is implemented and verified. |
| API SQL Client | Main branch reportedly has starter structure; client routes may remain in operational API | No deployment until scope is resolved | Do not deploy a separate service until the API contract and ownership of routes are confirmed. |
| RPA | Scheduled scripts/workflows, no HTTP API identified | GitHub Actions for now | Keep there if permissions and schedules meet the demo need; deploy to AWS only if execution limits or private networking require it. |
| BI / Databricks | Data pipeline, job, and dashboard | Databricks | Keep on its existing platform; no AWS move identified as necessary. Validate dashboard and data refresh separately. |

## Proposed AWS demo minimum

1. Operational SQL API, if the demo includes live stock operations.
2. Chatbot API, only for the chatbot/prediction/image paths actually demonstrated.
3. Mongo/Redis APIs only when the selected mobile/demo path consumes them.
4. Required isolated persistence and secrets for the selected APIs.

The minimum cannot be frozen until the actual demo journey and endpoint calls are reviewed. Avoid deploying every repository by default.
