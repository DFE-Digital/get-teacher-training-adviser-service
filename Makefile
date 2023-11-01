TERRAFILE_VERSION=0.8
ARM_TEMPLATE_TAG=1.1.10
RG_TAGS={"Product" : "Teacher services cloud"}
REGION=UK South
SERVICE_NAME=get-teacher-training-adviser
SERVICE_SHORT=tta

ifndef VERBOSE
.SILENT:
endif

APPLICATION_SECRETS=TTA-KEYS
INFRASTRUCTURE_SECRETS=INFRA-KEYS

.PHONY: local
local:
	$(eval export KEY_VAULT=s146d01-local2-kv)
	$(eval export AZURE_SUBSCRIPTION=s146-getintoteachingwebsite-development)

.PHONY: development
development:
	$(eval export DEPLOY_ENV=dev)
	$(eval export KEY_VAULT=s146d01-kv)
	$(eval export AZURE_SUBSCRIPTION=s146-getintoteachingwebsite-development)

.PHONY: review
review:
	$(if $(PR_NUMBER), , $(error Missing environment variable "PR_NUMBER", Please specify a pr number for your review app))
	$(eval export PR_NAME=review-teacher-training-adviser-${PR_NUMBER})
	$(eval export DEPLOY_ENV=review)
	$(eval export TF_VAR_paas_adviser_application_name=${PR_NAME})
	$(eval export KEY_VAULT=s146d01-kv)
	$(eval export AZURE_SUBSCRIPTION=s146-getintoteachingwebsite-development)
	$(eval BACKEND_KEY=-backend-config=key=${PR_NAME}.tfstate)
	$(eval export TF_VAR_paas_adviser_route_name=${PR_NAME})

.PHONY: test
test:
	$(eval export DEPLOY_ENV=test)
	$(eval export KEY_VAULT=s146t01-kv)
	$(eval export AZURE_SUBSCRIPTION=s146-getintoteachingwebsite-test)

.PHONY: production
production:
	$(eval export DEPLOY_ENV=production)
	$(eval export KEY_VAULT=s146p01-kv)
	$(eval export AZURE_SUBSCRIPTION=s146-getintoteachingwebsite-production)
	$(if $(or ${SKIP_CONFIRM}, ${CONFIRM_PRODUCTION}), , $(error Missing CONFIRM_PRODUCTION=yes))
	$(eval include global_config/production.sh)

staging:
	$(eval include global_config/staging.sh)

set-azure-account:
	[ "${SKIP_AZURE_LOGIN}" != "true" ] && az account set -s ${AZURE_SUBSCRIPTION} || true

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
	$(eval SKIP_AZURE_LOGIN=true)
	$(eval SKIP_CONFIRM=true)

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

help:
	@grep -E '^[a-zA-Z\._\-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

domains:
	$(eval include global_config/domains.sh)

composed-variables:
	$(eval RESOURCE_GROUP_NAME=${AZURE_RESOURCE_PREFIX}-${SERVICE_SHORT}-${CONFIG_SHORT}-rg)
	$(eval STORAGE_ACCOUNT_NAME=${AZURE_RESOURCE_PREFIX}${SERVICE_SHORT}${CONFIG_SHORT}tfsa)

bin/terrafile: ## Install terrafile to manage terraform modules
	curl -sL https://github.com/coretech/terrafile/releases/download/v${TERRAFILE_VERSION}/terrafile_${TERRAFILE_VERSION}_$$(uname)_x86_64.tar.gz \
		| tar xz -C ./bin terrafile

set-what-if:
	$(eval WHAT_IF=--what-if)

arm-deployment: composed-variables set-azure-account
	az deployment sub create --name "resourcedeploy-tsc-$(shell date +%Y%m%d%H%M%S)" \
		-l "${REGION}" --template-uri "https://raw.githubusercontent.com/DFE-Digital/tra-shared-services/${ARM_TEMPLATE_TAG}/azure/resourcedeploy.json" \
		--parameters "resourceGroupName=${RESOURCE_GROUP_NAME}" 'tags=${RG_TAGS}' \
		"tfStorageAccountName=${STORAGE_ACCOUNT_NAME}" "tfStorageContainerName=terraform-state" \
		"enableKVPurgeProtection=${KV_PURGE_PROTECTION}" \
		${WHAT_IF}

deploy-arm-resources: arm-deployment ## Validate ARM resource deployment. Usage: make domains validate-arm-resources

validate-arm-resources: set-what-if arm-deployment ## Validate ARM resource deployment. Usage: make domains validate-arm-resources

domains-infra-init: bin/terrafile domains composed-variables set-azure-account
	./bin/terrafile -p terraform/domains/infrastructure/vendor/modules -f terraform/domains/infrastructure/config/zones_Terrafile

	terraform -chdir=terraform/domains/infrastructure init -reconfigure -upgrade \
		-backend-config=resource_group_name=${RESOURCE_GROUP_NAME} \
		-backend-config=storage_account_name=${STORAGE_ACCOUNT_NAME} \
		-backend-config=key=domains_infrastructure.tfstate

domains-infra-plan: domains domains-infra-init  ## Terraform plan for DNS infrastructure (zone and front door. Usage: make domains-infra-plan
	terraform -chdir=terraform/domains/infrastructure plan -var-file config/zones.tfvars.json

domains-infra-apply: domains domains-infra-init  ## Terraform apply for DNS infrastructure (zone and front door). Usage: make domains-infra-apply
	terraform -chdir=terraform/domains/infrastructure apply -var-file config/zones.tfvars.json ${AUTO_APPROVE}

domains-init: bin/terrafile domains composed-variables set-azure-account
	./bin/terrafile -p terraform/domains/environment_domains/vendor/modules -f terraform/domains/environment_domains/config/${CONFIG}_Terrafile

	terraform -chdir=terraform/domains/environment_domains init -upgrade -reconfigure \
		-backend-config=resource_group_name=${RESOURCE_GROUP_NAME} \
		-backend-config=storage_account_name=${STORAGE_ACCOUNT_NAME} \
		-backend-config=key=${ENVIRONMENT}.tfstate

domains-plan: domains-init  ## Terraform plan for DNS environment domains. Usage: make development domains domains-plan
	terraform -chdir=terraform/domains/environment_domains plan -var-file config/${CONFIG}.tfvars.json

domains-apply: domains-init ## Terraform apply for DNS environment domains. Usage: make development domains domains-apply
	terraform -chdir=terraform/domains/environment_domains apply -var-file config/${CONFIG}.tfvars.json ${AUTO_APPROVE}
