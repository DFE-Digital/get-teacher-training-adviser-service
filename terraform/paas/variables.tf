# These settings are for the sandbox and should mainly be overriden by TF_VARS 
# or set with environment variables TF_VAR_xxxx


variable api_url {
     default = "https://api.london.cloud.service.gov.uk"
}

variable user {}
variable password {}


variable "paas_space" {
   default = "sandbox"
}

variable "paas_org_name" {
   default = "dfe-teacher-services"
}

variable "paas_adviser_application_name" {
   default = "dfe-teacher-services-api"
}

variable "paas_adviser_docker_image" {
   default = "dfedigital/get-teacher-training-adviser-service:latest"
}

variable "paas_adviser_route_name" {
   default = "dfe-teacher-services-sb-api"
}

variable    "HTTPAUTH_PASSWORD"  {}
variable    "HTTPAUTH_USERNAME"  {}
variable    "SECRET_KEY_BASE"    {}
variable    "RAILS_ENV" {}
variable    "RAILS_MASTER_KEY" {}

