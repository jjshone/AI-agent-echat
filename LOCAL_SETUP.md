# Local Development Setup

This guide explains how to get the project running locally for development and testing.

Prerequisites
- Docker & Docker Compose (v2)
- Git
- Python 3.11 (optional for running tests locally)
- Make

Steps
1. Clone the repo
   git clone git@github.com:jjshone/AI-agent-echat.git
2. Copy and customize `.env`
   cp .env.example .env
   Update secrets and any host-specific values. Do NOT commit `.env`.
3. Build and run services
   make up
4. Initialize Weaviate schema (locally or in CI)
   ./scripts/init_weaviate.sh
5. Run tests
   make test
6. Tail logs
   make logs

Notes
- For rapid iteration, use `docker-compose.override.yml` which mounts local source into containers.
- Use the `Makefile` convenience commands for common tasks.
- Use the GitHub Actions CI for integration tests and security scans prior to PR merges.
