resource "azurerm_role_definition" "rad_security" {
  name        = var.rad_security_role_name
  description = "Allow Rad Security read access to your cloud account"
  scope       = local.subscriptions_list[0] # Use list indexing

  permissions {
    actions = [
      "Microsoft.ContainerService/managedClusters/upgradeProfiles/read",
      "Microsoft.ContainerService/managedClusters/read",
      "Microsoft.ContainerService/managedClusters/listClusterUserCredential/action",
    ]
    not_actions = []
  }

  assignable_scopes = local.subscriptions_list # Use list directly
}

resource "azurerm_role_assignment" "rad_security" {
  for_each = local.subscriptions_map

  scope              = each.value
  role_definition_id = azurerm_role_definition.rad_security.role_definition_resource_id
  principal_id       = azuread_service_principal.rad_security.object_id
}
