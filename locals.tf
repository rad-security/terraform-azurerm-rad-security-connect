locals {
  subscriptions      = length(var.azure_subscriptions) == 0 ? toset([data.azurerm_subscription.primary.id]) : toset(var.azure_subscriptions)
  subscriptions_list = tolist(local.subscriptions)                               # Convert to list
  subscriptions_map  = { for idx, sub in local.subscriptions_list : idx => sub } # Convert list to map
}
