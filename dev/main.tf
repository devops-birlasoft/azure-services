### Resource Groups

module "resource_groups" {
  source = "./modules/resource-groups"

  for_each = { for rg in var.resource_groups : rg.rg_name => rg }
  rg_name  = each.value.rg_name
  location = each.value.location
}

### Virtual Networks

module "vnets" {
  source = "./modules/virtual-networks"

  for_each            = { for vnets in var.vnets : vnets.name => vnets }
  name                = each.value.name
  address_space       = each.value.address_space
  resource_group_name = each.value.resource_group_name

  depends_on = [module.resource_groups]
}

### Subnets

module "subnets" {
  source = "./modules/subnets"

  for_each             = { for subnets in var.subnets : subnets.name => subnets }
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  resource_group_name  = each.value.resource_group_name

  depends_on = [module.vnets]
}

### Network Security Group / Rules

module "nsg" {
  source = "./modules/nsg"

  nsg_rules = var.nsg_rules
  nsg       = var.nsg

  depends_on = [module.resource_groups, module.vnets, module.subnets]
}

### Route Tables

module "route_tables" {
  source = "./modules/route-tables"

}