resource "cloudfoundry_app" "adviser_application" {
    name =  var.paas_adviser_application_name
    space = data.cloudfoundry_space.space.id
    docker_image = var.paas_adviser_docker_image
    stopped      = var.application_stopped
    strategy     = "blue-green-v2"
    service_binding  {
            service_instance = cloudfoundry_service_instance.redis.id
    }
    dynamic "service_binding" {
      for_each = data.cloudfoundry_user_provided_service.logging
      content {
        service_instance = service_binding.value["id"]
      }
    }
    routes {
        route = cloudfoundry_route.adviser_route.id
    }    
    environment = {
       HTTPAUTH_PASSWORD = var.HTTPAUTH_PASSWORD
       HTTPAUTH_USERNAME = var.HTTPAUTH_USERNAME
       SECRET_KEY_BASE   = var.SECRET_KEY_BASE
       RAILS_ENV         = var.RAILS_ENV
       RAILS_MASTER_KEY  = var.RAILS_MASTER_KEY
    }    
}

resource "cloudfoundry_route" "adviser_route" {
    domain = data.cloudfoundry_domain.cloudapps.id
    space = data.cloudfoundry_space.space.id
    hostname =  var.paas_adviser_route_name
}
