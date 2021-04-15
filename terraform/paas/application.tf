locals {
  environment_map = { HTTPAUTH_PASSWORD = data.azurerm_key_vault_secret.http_password.value, HTTPAUTH_USERNAME = data.azurerm_key_vault_secret.http_username.value }
}

resource "cloudfoundry_app" "adviser_application" {
  name         = var.paas_adviser_application_name
  space        = data.cloudfoundry_space.space.id
  docker_image = var.paas_adviser_docker_image
  stopped      = var.application_stopped
  strategy     = var.strategy
  memory       = 1024
  timeout      = 1000
  instances    = var.instances

  dynamic "service_binding" {
    for_each = data.cloudfoundry_service_instance.linked
    content {
      service_instance = service_binding.value["id"]
    }
  }

  dynamic "service_binding" {
    for_each = data.cloudfoundry_user_provided_service.logging
    content {
      service_instance = service_binding.value["id"]
    }
  }

  dynamic "routes" {
    for_each = data.cloudfoundry_route.app_route_internet
    content {
      route = routes.value["id"]
    }
  }

  docker_credentials = {
    username = data.azurerm_key_vault_secret.docker_username.value
    password = data.azurerm_key_vault_secret.docker_password.value
  }

  routes {
    route = cloudfoundry_route.adviser_route.id
  }

  routes {
    route = cloudfoundry_route.app_route_internal.id
  }

  environment = merge(local.application_secrets, local.environment_map)
}


