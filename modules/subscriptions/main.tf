
data "azurerm_billing_enrollment_account_scope" "example" {
  billing_account_name    = "bd02df81-4cf7-42dd-846d-5ae843c9ca51"
  enrollment_account_name = "bd02df81-4cf7-42dd-846d-5ae843c9ca51"
}

resource "azurerm_subscription" "example" {
  subscription_name = "My Example EA Subscription"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.example.id
}

data "azurerm_subscription" "current" {
}

resource "azurerm_management_group" "parent" {
  display_name = "ParentGroup"

  subscription_ids = [
    data.azurerm_subscription.current.subscription_id
  ]
}