
## Resource Groups
resource_groups = [
  {
    rg_name  = "LennarAzureLZ-RG-01",
    location = "South India"
  },
  {
    rg_name  = "LennarAzureLZ-RG-02",
    location = "West Europe"
  }
]

## Vnets
vnets = [
  {
    name                = "LEN-LZ-VNET-01"
    address_space       = ["10.2.0.0/16"]
    resource_group_name = "LennarAzureLZ-RG-01"
  }
]

## Subnets
subnets = [
  {
    name                 = "LEN-LZ-SNET-01"
    virtual_network_name = "LEN-LZ-VNET-01"
    address_prefixes     = ["10.2.1.0/24"]
    resource_group_name  = "LennarAzureLZ-RG-01"
  },
  {
    name                 = "LEN-LZ-SNET-02"
    virtual_network_name = "LEN-LZ-VNET-01"
    address_prefixes     = ["10.2.2.0/24"]
    resource_group_name  = "LennarAzureLZ-RG-01"
  }
]

## nsg
nsg = [
  {
    name           = "LEN-NSG-DEV-001",
    resource_group = "LennarAzureLZ-RG-01",
    subnet         = "LEN-LZ-SNET-01"
    vnet_name      = "LEN-LZ-VNET-01"
  },
  {
    name           = "LEN-NSG-DEV-002",
    resource_group = "LennarAzureLZ-RG-01",
    subnet         = "LEN-LZ-SNET-02"
    vnet_name      = "LEN-LZ-VNET-01"
  }
]

nsg_rules = [
  {
    name                       = "NSG-RULE-01"
    access                     = "Allow",
    protocol                   = "Tcp",
    direction                  = "Inbound",
    source_port_range          = "*",
    destination_port_range     = "*",
    priority                   = "110",
    source_address_prefix      = "*",
    destination_address_prefix = "*",
    nsg_name                   = "LEN-NSG-DEV-001"
    resource_group             = "LennarAzureLZ-RG-01"
  },
  {
    name                       = "NSG-RULE-02"
    access                     = "Allow",
    protocol                   = "Tcp",
    direction                  = "Inbound",
    source_port_range          = "*",
    destination_port_range     = "*",
    priority                   = "115",
    source_address_prefix      = "*",
    destination_address_prefix = "*",
    nsg_name                   = "LEN-NSG-DEV-002"
    resource_group             = "LennarAzureLZ-RG-01"
  }
]

## Route Table

route_tables=[
  {
    name = "LEN-RT-DEV-01"
    resource_group_name = "LennarAzureLZ-RG-01"
    disable_bgp_route_propagation = false
    subnet         = "LEN-LZ-SNET-02"
    vnet_name      = "LEN-LZ-VNET-01"
    routes = [
      {
        name                   = "example"
        address_prefix         = "10.100.0.0/14"
        next_hop_type          = "VirtualAppliance"
        next_hop_in_ip_address = "10.10.1.1"
      }
    ]
  }
]