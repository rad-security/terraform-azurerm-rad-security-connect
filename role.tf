resource "azurerm_role_definition" "rad_security" {
  for_each = local.subscriptions

  name        = var.rad_security_role_name
  scope       = each.value
  description = "Allow Rad Security read access to your cloud account"

  permissions {
    actions = [
      "Microsoft.ContainerService/managedClusters/upgradeProfiles/read",
      "Microsoft.ContainerService/managedClusters/read",
      "Microsoft.ContainerService/managedClusters/listClusterUserCredential/action",
    ]
    not_actions = []
  }
}

resource "azurerm_role_assignment" "rad_security" {
  for_each = local.subscriptions

  scope              = each.value
  role_definition_id = azurerm_role_definition.rad_security[each.key].role_definition_resource_id
  principal_id       = azuread_service_principal.rad_security.object_id
}
