
variable "dns_name" {
  description = "Private dns zone Name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "virtual_networks" {
  description = "Virtual Networks"
}

variable "records" {
  description = "DNS records"
}
