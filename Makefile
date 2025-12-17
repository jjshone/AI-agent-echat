# Makefile - common developer tasks

.PHONY: up down build logs test lint compose-up compose-down

up: compose-up

compose-up:
	docker compose up -d --build

compose-down:
	docker compose down -v

build:
	docker compose build --parallel

logs:
	docker compose logs -f

test:
	# Run unit tests across services. Each service provides `make test` target.
	# Add parallelization or matrixing as needed.
	./scripts/run_tests.sh

lint:
	./scripts/run_linters.sh

clean:
	docker compose down -v --remove-orphans
	rm -rf ./.venv

# Helpful aliases
restart: compose-down compose-up

