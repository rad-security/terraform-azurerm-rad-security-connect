locals {
  subscriptions      = length(var.azure_subscriptions) == 0 ? toset([data.azurerm_subscription.primary.id]) : toset(var.azure_subscriptions)
  subscriptions_list = tolist(local.subscriptions) # Convert to list
}
