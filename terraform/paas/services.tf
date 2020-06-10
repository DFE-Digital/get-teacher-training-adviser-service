data cloudfoundry_service redis {
    name = "redis"
}

resource "cloudfoundry_service_instance" "redis" {
  name = var.paas_redis_1_name
  space = data.cloudfoundry_space.space.id
  service_plan = data.cloudfoundry_service.redis.service_plans["tiny-3_2"]
}

data "cloudfoundry_user_provided_service" "logging" {
    name = var.paas_logging_name
    space = data.cloudfoundry_space.space.id
    count = var.logging
}
