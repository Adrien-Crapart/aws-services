include .env

# Useful link:
# https://github.com/localstack-samples/localstack-pro-samples/tree/master

.PHONY: start run-localstack deploy run-minio stop

start: run-localstack deploy run-minio

run-localstack:
	@echo "Starting Localstack"
	-@docker container rm -f $(DOCKER_NAME) 2>/dev/null
	@docker-compose -f docker-compose.yml up -d localstack serverless

deploy:
	@echo "Deploying or redeploy changes on Serverless to Localstack"
	-@docker container rm -f serverless 2>/dev/null
	@docker-compose -f docker-compose.yml up -d serverless

run-minio:
	@echo "Starting Minio"
	@docker-compose -f docker-compose.yml up -d minio

stop:
	@echo "Stopping all services on Localstack and minio"
	@docker-compose -f docker-compose.yml down