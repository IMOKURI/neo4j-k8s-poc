.DEFAULT_GOAL := help

export
NOW = $(shell date '+%Y%m%d-%H%M%S')
RELEASE_NAME = "genai-studio"


.PHONY: add-repo
add-repo: ## Add helm repository
	helm repo add neo4j https://helm.neo4j.com/neo4j
	helm repo update

.PHONY: install
install: ## Install neo4j
	helm upgrade $(RELEASE_NAME) neo4j/neo4j -f values.yaml --install

.PHONY: uninstall
uninstall: ## Uninstall neo4j
	helm uninstall $(RELEASE_NAME)

.PHONY: delete-pvc
delete-pvc: ## Delete neo4j pvc
	kubectl delete pvc data-$(RELEASE_NAME)-0

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / \
		{printf "\033[38;2;98;209;150m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
