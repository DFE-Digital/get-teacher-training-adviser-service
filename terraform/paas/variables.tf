# These settings are for the sandbox and should mainly be overriden by TF_VARS 
# or set with environment variables TF_VAR_xxxx


variable api_url {
  default = "https://api.london.cloud.service.gov.uk"
}

variable AZURE_CREDENTIALS {}
variable azure_key_vault {}
variable azure_resource_group {}

variable "application_stopped" {
  default = false
}

variable "logging" {
  default = "0"
}

variable "additional_routes" {
  default = 0
}

variable "strategy" {
  default = "blue-green"
}

variable "instances" {
  default = 1
}

variable "paas_logging_name" {
  default = "logit-ssl-drain"
}

variable "paas_logging_endpoint_port" {
  default = ""
}

variable "paas_redis_1_name" {
  default = "get-into-teaching-dev-redis-svc"
}

variable "paas_space" {
  default = "sandbox"
}

variable "paas_org_name" {
  default = "dfe"
}

variable "paas_adviser_application_name" {
  default = "dfe-teacher-services-tta"
}

variable "paas_adviser_docker_image" {
  default = "dfedigital/get-teacher-training-adviser-service:latest"
}

variable "paas_adviser_route_name" {
  default = "dfe-teacher-services-sb-tta"
}

variable "paas_additional_route_name" {
  default = ""
}

variable "alerts" {
  type = map
}
