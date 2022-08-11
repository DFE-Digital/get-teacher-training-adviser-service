ifndef VERBOSE
.SILENT:
endif

help:
	echo "Secrets:"
	echo "  This makefile gives the user the ability to safely display and edit azure secrets which are used by this project. "
	echo ""
	echo "Commands:"
	echo "  edit-app-secrets  - Edit Application specific Secrets."
	echo "  print-app-secrets - Display Application specific Secrets."
	echo ""
	echo "Parameters:"
	echo "All commands take the parameter development|review|test|production"
	echo ""
	echo "Examples:"
	echo ""
	echo "To edit the Application secrets for Development"
	echo "        make  development edit-app-secrets"
	echo ""

APPLICATION_SECRETS=TTA-KEYS
INFRASTRUCTURE_SECRETS=INFRA-KEYS

.PHONY: local
local:
	$(eval export KEY_VAULT=s146d01-local2-kv)
	$(eval export AZ_SUBSCRIPTION=s146-getintoteachingwebsite-development)

.PHONY: development
development:
	$(eval export DEPLOY_ENV=dev)
	$(eval export KEY_VAULT=s146d01-kv)
	$(eval export AZ_SUBSCRIPTION=s146-getintoteachingwebsite-development)

.PHONY: review
review:
	$(if $(PR_NUMBER), , $(error Missing environment variable "PR_NUMBER", Please specify a pr number for your review app))
	$(eval export PR_NAME=review-teacher-training-adviser-${PR_NUMBER})
	$(eval export DEPLOY_ENV=review)
	$(eval export TF_VAR_paas_adviser_application_name=${PR_NAME})
	$(eval export KEY_VAULT=s146d01-kv)
	$(eval export AZ_SUBSCRIPTION=s146-getintoteachingwebsite-development)
	$(eval BACKEND_KEY=-backend-config=key=${PR_NAME}.tfstate)
	$(eval export TF_VAR_paas_adviser_route_name=${PR_NAME})

.PHONY: test
test:
	$(eval export DEPLOY_ENV=test)
	$(eval export KEY_VAULT=s146t01-kv)
	$(eval export AZ_SUBSCRIPTION=s146-getintoteachingwebsite-test)

.PHONY: production
production:
	$(eval export DEPLOY_ENV=production)
	$(eval export KEY_VAULT=s146p01-kv)
	$(eval export AZ_SUBSCRIPTION=s146-getintoteachingwebsite-production)

set-azure-account:
	az account set -s ${AZ_SUBSCRIPTION}

install-fetch-config:
	[ ! -f fetch_config.rb ]  \
	    && echo "Installing fetch_config.rb" \
	    && curl -s https://raw.githubusercontent.com/DFE-Digital/bat-platform-building-blocks/master/scripts/fetch_config/fetch_config.rb -o fetch_config.rb \
	    && chmod +x fetch_config.rb \
	    || true

edit-app-secrets: install-fetch-config set-azure-account
	./fetch_config.rb -s azure-key-vault-secret:${KEY_VAULT}/${APPLICATION_SECRETS} -e -d azure-key-vault-secret:${KEY_VAULT}/${APPLICATION_SECRETS} -f yaml -c

print-app-secrets: install-fetch-config set-azure-account
	./fetch_config.rb -s azure-key-vault-secret:${KEY_VAULT}/${APPLICATION_SECRETS}  -f yaml

edit-infra-secrets: install-fetch-config set-azure-account
	./fetch_config.rb -s azure-key-vault-secret:${KEY_VAULT}/${INFRASTRUCTURE_SECRETS} -e -d azure-key-vault-secret:${KEY_VAULT}/${INFRASTRUCTURE_SECRETS} -f yaml -c

print-infra-secrets: install-fetch-config set-azure-account
	./fetch_config.rb -s azure-key-vault-secret:${KEY_VAULT}/${INFRASTRUCTURE_SECRETS}  -f yaml

setup-local-env: install-fetch-config set-azure-account
	./fetch_config.rb -s yaml-file:.env.development.yml -s azure-key-vault-secret:s146d01-local2-kv/${APPLICATION_SECRETS} -f shell-env-var > .env.development

PHONY: ci
ci:
	$(eval AUTO_APPROVE=-auto-approve)

terraform-init: set-azure-account
	$(if $(or $(IMAGE_TAG), $(NO_IMAGE_TAG_DEFAULT)), , $(eval export IMAGE_TAG=master))
	$(if $(IMAGE_TAG), , $(error Missing environment variable "IMAGE_TAG"))
	$(eval export TF_VAR_paas_adviser_docker_image=ghcr.io/dfe-digital/get-teacher-training-adviser-service:$(IMAGE_TAG))

	terraform -chdir=terraform/paas init -reconfigure -backend-config=${DEPLOY_ENV}.bk.vars ${BACKEND_KEY}

terraform-plan: terraform-init
	terraform -chdir=terraform/paas plan -var-file=${DEPLOY_ENV}.env.tfvars

terraform: terraform-init
	terraform -chdir=terraform/paas apply -var-file=${DEPLOY_ENV}.env.tfvars ${AUTO_APPROVE}

terraform-destroy: terraform-init
	terraform -chdir=terraform/paas destroy -var-file=${DEPLOY_ENV}.env.tfvars ${AUTO_APPROVE}

delete-state-file:
	az storage blob delete --container-name pass-tfstate --delete-snapshots include --account-name s146d01sgtfstate -n ${PR_NAME}.tfstate
