# AI-agent-echat

Enterprise AI platform for an action-oriented ecommerce assistant.

Quick links:
- Architecture: `docs/architecture/ARCHITECTURE.md`
- Roadmap: `ROADMAP.md`
- Local setup: `LOCAL_SETUP.md`
- Production deployment guide: `PRODUCTION_DEPLOYMENT.md`
- Weaviate notes: `docs/implementation/WEAVIATE_README.md`

Getting started:
1. Copy `.env.example` to `.env` and configure required values.
2. Run `make up` to start local development environment.
3. Run `./scripts/init_weaviate.sh` to initialize vector schema.
4. Run `make test` to run unit & integration checks.
