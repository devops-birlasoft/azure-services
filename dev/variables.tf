variable "subscriptions" {

}

variable "vnets" {
  description = "Azure virtual networks"
  type = list(object({
    name                = string
    address_space       = list(string)
    resource_group_name = string
  }))
}

variable "resource_groups" {
  description = "Azure resource group"
  type = list(object({
    rg_name  = string
    location = string
  }))
}

variable "subnets" {
  description = "Azure Subnets"
  type = list(object({
    name                 = string
    virtual_network_name = string
    address_prefixes     = list(string)
    resource_group_name  = string
  }))
}

variable "nsg" {
  description = "Azure Network Security Group"
  type = list(object({
    name           = string
    resource_group = string
    subnet         = string
    vnet_name      = string
  }))

}

variable "nsg_rules" {
  description = "Azure network security group rules"
  type = list(object({
    name                       = string
    access                     = string
    protocol                   = string
    direction                  = string
    source_port_range          = string
    destination_port_range     = string
    priority                   = string
    source_address_prefix      = string
    destination_address_prefix = string
    nsg_name                   = string
    resource_group             = string
  }))
}

variable "common_tags" {
  description = "List of tags for lennar"
  type        = map(string)
}


variable "route_tables" {
  
}