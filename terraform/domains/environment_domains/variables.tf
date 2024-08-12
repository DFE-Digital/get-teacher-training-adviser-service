variable "hosted_zone" {
  type    = map(any)
  default = {}
}

variable "statuscake_contact_groups" {
  default     = [185037, 282453]
  description = "ID of the contact group in statuscake web UI"
}
variable "enable_monitoring" {
  default     = false
  description = "Enable monitoring and alerting"
}
variable "external_url" {
  description = "URL monitored by StatusCake"
}
variable "azure_resource_prefix" {
  description = "Standard resource prefix. Usually s189t01 (test) or s189p01 (production)"
}
variable "service_short" {
  description = "Short name to identify the service. Up to 6 charcters."
}
variable "config_short" {
  description = "Short name of the environment configuration, e.g. dv, st, dom..."
}
