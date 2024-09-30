resource "azurerm_dns_zone" "dns_zone" {
  name                = var.dns_name
  resource_group_name = var.resource_group_name

}

data "azurerm_virtual_network" "az_vnet" {
  for_each            = { for vnets in var.virtual_networks : vnets.vnet_name => vnets }
  name                = each.key
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  for_each              = { for vnets in var.virtual_networks : vnets.vnet_name => vnets }
  name                  = "${var.dns_name}-${each.value.vnet_name}"
  resource_group_name   = each.value.resource_group_name
  virtual_network_id    = data.azurerm_virtual_network.az_vnet[each.key].id
  private_dns_zone_name = var.dns_name

}