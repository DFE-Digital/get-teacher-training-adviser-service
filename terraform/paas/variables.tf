# These settings are for the sandbox and should mainly be overriden by TF_VARS 
# or set with environment variables TF_VAR_xxxx

variable user {
    default = "get-into-teaching-tech@digital.education.gov.uk"
}

variable api_url {
     default = "https://api.london.cloud.service.gov.uk"
}

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
   default = "dfedigital/get-into-teaching-api:GITPB-149"
}

variable "paas_adviser_route_name" {
   default = "dfe-teacher-services-sb-api"
}

variable    "HTTPAUTH_PASSWORD"  {}
variable    "HTTPAUTH_USERNAME"  {}
variable    "SECRET_KEY_BASE"    {}
