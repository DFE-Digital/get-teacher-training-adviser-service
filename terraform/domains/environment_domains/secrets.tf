module "infrastructure_secrets" {
  source = "./vendor/modules/domains//aks/secrets"

  azure_resource_prefix = var.azure_resource_prefix
  service_short         = var.service_short
  config_short          = var.config_short
}
