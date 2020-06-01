resource "cloudfoundry_app" "adviser_application" {
    name =  var.paas_adviser_application_name
    space = data.cloudfoundry_space.space.id
    docker_image = var.paas_adviser_docker_image
        route = cloudfoundry_route.adviser_route.id
    }    
    environment = {
       HTTPAUTH_PASSWORD = var.HTTPAUTH_PASSWORD
       HTTPAUTH_USERNAME = var.HTTPAUTH_USERNAME
       SECRET_KEY_BASE =   var.SECRET_KEY_BASE
    }    
}

resource "cloudfoundry_route" "adviser_route" {
    domain = data.cloudfoundry_domain.cloudapps.id
    space = data.cloudfoundry_space.space.id
    hostname =  var.paas_adviser_route_name
}



