resource "azurerm_role_definition" "rad_security" {
  name        = var.rad_security_role_name
  description = "Allow Rad Security read access to your cloud account"
  scope       = local.subscriptions_list[0]

  permissions {
    actions = [
      "Microsoft.ContainerService/managedClusters/upgradeProfiles/read",
      "Microsoft.ContainerService/managedClusters/read",
      "Microsoft.ContainerService/managedClusters/listClusterUserCredential/action",
      "Microsoft.Sql/instancePools/read",
      "Microsoft.Sql/instancePools/operations/read",
      "Microsoft.Sql/servers/databases/read",
      "Microsoft.Sql/managedInstances/encryptionProtector/read",
      "Microsoft.Sql/managedInstances/read",
      "Microsoft.Sql/servers/databases/read",
      "Microsoft.Sql/servers/encryptionProtector/read",
      "Microsoft.Sql/servers/firewallRules/read",
      "Microsoft.Sql/servers/securityAlertPolicies/read",
      "Microsoft.Sql/servers/virtualNetworkRules/read",
      "Microsoft.Sql/servers/read",
      "Microsoft.Sql/managedInstances/databases/transparentDataEncryption/read",
      "Microsoft.Sql/managedInstances/databases/transparentDataEncryption/read",
      "Microsoft.Sql/servers/databases/transparentDataEncryption/read",
      "Microsoft.Storage/storageAccounts/read",
      "Microsoft.Storage/storageAccounts/blobServices/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Storage/storageAccounts/fileServices/shares/read",
      "Microsoft.Storage/storageAccounts/queueServices/read",
      "Microsoft.Storage/storageAccounts/queueServices/queues/read",
      "Microsoft.Storage/storageAccounts/tableServices/read",
      "Microsoft.Compute/images/read",
      "Microsoft.Compute/restorePointCollections/read",
      "Microsoft.Compute/skus/read",
      "Microsoft.Compute/snapshots/read",
      "Microsoft.Compute/sshPublicKeys/read",
      "Microsoft.Compute/virtualMachines/extensions/read",
      "Microsoft.Compute/virtualMachineScaleSets/read",
      "Microsoft.Compute/virtualMachineScaleSets/virtualMachines/read",
      "Microsoft.Compute/virtualMachineScaleSets/extensions/read",
      "Microsoft.Compute/virtualMachineScaleSets/networkInterfaces/read",
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.Network/VirtualNetworkgateways/read",
      "Microsoft.Network/virtualWans/read",
      "Microsoft.Network/privateEndpoints/read",
      "Microsoft.Network/routeTables/read",
      "Microsoft.Network/customIpPrefixes/read",
      "Microsoft.Network/networkVirtualAppliances/read",
      "Microsoft.Network/networkWatchers/read",
      "Microsoft.Network/networkWatchers/flowLogs/read",
      "Microsoft.Network/azurefirewalls/read",
      "Microsoft.Network/virtualRouters/read",
      "Microsoft.Network/bastionHosts/read",
      "Microsoft.Network/serviceEndpointPolicies/read",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/subnets/read",
      "Microsoft.Network/publicIPAddresses/read",
      "Microsoft.Network/applicationSecurityGroups/read",
      "Microsoft.Network/virtualNetworkTaps/read",
      "Microsoft.Network/vpnServerConfigurations/read",
      "Microsoft.Network/ipGroups/read",
      "Microsoft.Network/networkSecurityGroups/read",
      "Microsoft.Network/virtualHubs/read",
      "Microsoft.Network/firewallPolicies/read",
      "Microsoft.Network/networkInterfaces/read",
      "Microsoft.network/virtualnetworkgateways/connections/read",
      "Microsoft.Network/applicationGateways/read",
      "Microsoft.Network/routeFilters/read",
      "Microsoft.Network/routeFilters/routeFilterRules/read",
      "Microsoft.Network/vpnGateways/read",
      "Microsoft.Network/ipAllocations/read",
      "Microsoft.Network/networkInterfaces/read",
      "Microsoft.Network/loadBalancers/read",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/publicIPPrefixes/read",
      "Microsoft.Network/networkProfiles/read",
      "Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies/read"
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
