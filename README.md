# terraform-azurerm-rad-security

Allows RAD Security to connect to your Azure accounts to allow for AKS Cluster Discovery, and Cloud Resource Discovery. The terraform module will create a custom role, service principal, app role assignment, and will assign the custom role to the service principal in each subscription. Once the role is assigned in the subscription, the azure_register resource will then register the subscription and tenant with RAD Security. The module is configured to use an Azure Enterprise Application to avoid storing credentials within RAD. There is a workaround to use Service Principal ids and secrets if that method is preferred.

## Terraform Registry

This module is available in the [Terraform Registry](https://registry.terraform.io/) see [here](https://registry.terraform.io/modules/rad-security/rad-security-connect/azurerm/latest).


## Usage

To register your Azure accounts with RAD Security, you will need to execute this module.

The following providers need to be configured. There are a number of ways to configure the azurerm and azuread providers. Select the one that best fits your environment. The rad-security provider needs a pair of access and secret keys to function correctly.

```hcl
provider "azuread" {

}

provider "azurerm" {

}

provider "rad-security" {
    access_key_id = "RAD_ACCESS_KEY"
    secret_key    = "RAD_SECRET_KEY"
}
```

```hcl
module "rad-security-connect" {
  source  = "rad-security/rad-security-connect/azurerm"
  version = "<version>"
}
```

Once applied, Rad Security will start synchronizing your resources with our platform.

## Using an Existing Service Principal

It is possible to use an existing Service Principal that has the necessary permissions. To do this, you can register the Azure Subscription and Tenant by creating a `azure_register` resource with the rad-security provider. There is no need to use this module. The Service Principal ID and Secret will be securely stored in the RAD Security platform. A new resource has to be created for each Azure Subscription and Tenant you wish to connect to RAD Security.

```hcl
provider "rad-security" {
    access_key_id = "RAD_ACCESS_KEY"
    secret_key    = "RAD_SECRET_KEY"
}

resource "rad-security_azure_register" "azure_connection" {
  subscription_id                = "your-azure-subscription-id"
  tenant_id                      = "your-azure-tenant-id"
  service_principal_token_id     = "your-service-principal-token-id"
  service_principal_token_secret = "your-service-principal-token-secret"
}
```

## Registering Multiple Azure Subscriptions

You can register multiple Azure Subscriptions by passing them into the `azure_subscriptions` input variable. They have to be in the format `/subscriptions/$SUBSCRIPTION_ID`. This will assign the custom role to the Service Principal in each subscription.

```hcl
module "rad-security-connect" {
  source  = "rad-security/rad-security-connect/azurerm"
  version = "<version>"
  azure_subscriptions = ["/subscriptions/1234567890", "/subscriptions/1234567891"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.8 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.38.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.54.0 |
| <a name="requirement_rad-security"></a> [rad-security](#requirement\_rad-security) | >= 1.0.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.38.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.54.0 |
| <a name="provider_rad-security"></a> [rad-security](#provider\_rad-security) | >= 1.0.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_app_role_assignment.rad_security](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/app_role_assignment) | resource |
| [azuread_service_principal.rad_security](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.rad_security](https://registry.terraform.io/providers/hashicorp/azurerm/3.54.0/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.rad_security](https://registry.terraform.io/providers/hashicorp/azurerm/3.54.0/docs/resources/role_definition) | resource |
| [rad-security_azure_register.this](https://registry.terraform.io/providers/rad-security/rad-security/latest/docs/resources/azure_register) | resource |
| [azurerm_subscription.primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.54.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_service_principal_id"></a> [azure\_service\_principal\_id](#input\_azure\_service\_principal\_id) | If the Service Principal is already created, specify the id here | `string` | `""` | no |
| <a name="input_azure_subscriptions"></a> [azure\_subscriptions](#input\_azure\_subscriptions) | List of Azure subscriptions to connect to Rad Security. Subscriptions must be passed in the form /subscriptions/$SUBSCIRPTION\_ID | `list(string)` | `[]` | no |
| <a name="input_rad_security_app_id"></a> [rad\_security\_app\_id](#input\_rad\_security\_app\_id) | The ID of the Rad Security Azure application. | `string` | `"55bd48fb-0aea-469d-b464-b5aa1490941d"` | no |
| <a name="input_rad_security_role_name"></a> [rad\_security\_role\_name](#input\_rad\_security\_role\_name) | Name of custom role to assume | `string` | `"rad-security-connect"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License
Apache 2 Licensed. See [LICENSE](LICENSE) for full details.
