resource "azurerm_role_definition" "rad_security" {
  name        = var.rad_security_role_name
  description = "Allow Rad Security read access to your cloud account"
  scope       = local.subscriptions_list[0]

  permissions {
    actions = [
      "Microsoft.ContainerService/managedClusters/upgradeProfiles/read",
      "Microsoft.ContainerService/managedClusters/read",
      "Microsoft.ContainerService/managedClusters/listClusterUserCredential/action",
    ]
    not_actions = []
  }

  assignable_scopes = local.subscriptions_list
}

resource "azurerm_role_assignment" "rad_security" {
  count = length(local.subscriptions_list)

  scope              = local.subscriptions_list[count.index]
  role_definition_id = azurerm_role_definition.rad_security.role_definition_resource_id
  principal_id       = var.azure_service_principal_id == "" ? azuread_service_principal.rad_security[0].object_id : var.azure_service_principal_id
}
