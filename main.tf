data "azurerm_subscription" "primary" {}

resource "azuread_app_role_assignment" "rad_security" {
  app_role_id         = "00000000-0000-0000-0000-000000000000"
  principal_object_id = var.azure_service_principal_id == "" ? azuread_service_principal.rad_security[0].object_id : var.azure_service_principal_id
  resource_object_id  = var.azure_service_principal_id == "" ? azuread_service_principal.rad_security[0].object_id : var.azure_service_principal_id
}


resource "azuread_service_principal" "rad_security" {
  count                        = var.azure_service_principal_id == "" ? 1 : 0
  application_id               = var.rad_security_app_id
  app_role_assignment_required = true


  feature_tags {
    enterprise = true
    gallery    = true
  }
}

resource "rad-security_azure_register" "this" {
  for_each = local.subscriptions

  subscription_id = split("/", each.value)[2]
  tenant_id       = data.azurerm_subscription.primary.tenant_id

  depends_on = [
    azurerm_role_assignment.rad_security
  ]
}
