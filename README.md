# terraform-azurerm-rad-security

Allows Rad Security to connect to your Azure accounts to allow for AKS cluster discovery.

## Terraform Registry

This module is available in the [Terraform Registry](https://registry.terraform.io/) see [here](https://registry.terraform.io/modules/rad-security/rad-security-connect/azurerm/latest).

## Contributing

The most important thing to be aware of when contributing is that we leverage the [Semantic Release Action](https://github.com/cycjimmy/semantic-release-action) to automate our changelog, see [here](CHANGELOG.md).

This requires us to use [conventional git commits](https://www.conventionalcommits.org/en/v1.0.0/) when committing to this repository.

Each PR merge into the `main` branch will execute the release process defined [here](.github/workflows/release.yml).

## Usage

During the sign-up process, you will need to execute this module to allow KSOC to discovery AKS clusters and perform monitoring.

Use the following to configure the Azure Terraform provider:

```hcl
provider "azuread" {

}

provider "azurerm" {

}

provider "rad-security" {
    access_key_id = "KSOC_ACCESS_KEY"
    secret_key    = "KSOC_SECRET_KEY"
}
```

```hcl
module "rad-security-connect" {
  source  = "rad-security/rad-security-connect/azurerm"
  version = "<version>"
}
```

Once applied, Rad Security will start synchronizing your resources with our platform.

## Providing a Service Principal

If you already have a Service Principal that you want to use, you can provide the `azure_service_principal_id` input variable.

```hcl
module "rad-security-connect" {
  source  = "rad-security/rad-security-connect/azurerm"
  version = "<version>"
  azure_service_principal_id = "YOUR_SERVICE_PRINCIPAL_ID"
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
