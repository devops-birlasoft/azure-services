
## Common Tags

common_tags = {
  "Environment"   = "DEV"
  "AutoUpdate"    = "Yes"
  "ApplicationId" = "LEN0013"
  "Project"       = "Lennar"
}

## Subscriptions
subscriptions = [
  {

  }
]

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
    dns_servers         = ["10.7.7.7"]
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

route_tables = [
  {
    name                          = "LEN-RT-DEV-01"
    resource_group_name           = "LennarAzureLZ-RG-01"
    disable_bgp_route_propagation = false
    subnet                        = "LEN-LZ-SNET-02"
    vnet_name                     = "LEN-LZ-VNET-01"
    routes = [
      {
        name           = "route1"
        address_prefix = "10.2.0.0/16"
        next_hop_type  = "VnetLocal"
      }
    ]
  }
]


## Budget

budget_details = [
  {
    name          = "Lennar-Monthly-Budget"
    budget_amount = 1000
    time_grain    = "Monthly"
    start_date    = "2024-09-01T00:00:00Z"
    end_date      = "2024-10-01T00:00:00Z"

    notifications = [
      {
        threshold      = 80.0 # 80% usage
        operator       = "GreaterThan"
        contact_emails = ["jitenderyadavofc@gmail.com"]
        contact_roles  = ["Owner", "Contributor"]
        threshold_type = "Forecasted"
        enabled        = true
      },
      {
        threshold      = 100.0 # 80% usage
        operator       = "GreaterThan"
        contact_emails = ["jitenderyadavofc@gmail.com"]
        contact_roles  = ["Owner", "Contributor"]
        threshold_type = "Forecasted"
        enabled        = true
      }
    ]
  }
]

### RBAC Roles

role_definitions = [
  {
    role_definition_name = "00000000-0000-0000-0000-000000000001"
    scope                = "/subscriptions/731257cc-4ff2-4612-b6b0-3463b086522f"
    actions              = ["*"]
    not_actions          = ["*"]
    assignable_scopes    = ["/subscriptions/731257cc-4ff2-4612-b6b0-3463b086522f"]
  }
]

role_assignments = [
  { name                   = "00000000-0000-0000-0000-000000000003"
    role_definition_name   = "00000000-0000-0000-0000-000000000001"
    principal_id           = "429a5f5f-5764-4031-a7f4-a0a499fc3c52"
    scope                  = "/subscriptions/731257cc-4ff2-4612-b6b0-3463b086522f"
    custom_role_definition = true
  },
  { name                   = "00000000-0000-0000-0000-000000000004"
    role_definition_name   = "Reader"
    principal_id           = "429a5f5f-5764-4031-a7f4-a0a499fc3c52"
    scope                  = "/subscriptions/731257cc-4ff2-4612-b6b0-3463b086522f"
    custom_role_definition = false
  }
]