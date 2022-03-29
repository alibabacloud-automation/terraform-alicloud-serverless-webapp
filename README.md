Alibaba Cloud Serverless Webapp Terraform Module  
terraform-alicloud-serverless-webapp
=====================================================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-serverless-webapp/blob/master/README-CN.md)

This repository contains an opinionated Terraform module for deploying "serverless" web applications to Alibaba Cloud Function Computing and exposing them publicly using Alibaba Cloud API Gateway running in its proxy mode.

These types of resources are supported:

* [API Gateway API](https://www.terraform.io/docs/providers/alicloud/r/api_gateway_api.html)
* [API Gateway APP](https://www.terraform.io/docs/providers/alicloud/r/api_gateway_app.html)
* [API Gateway Group](https://www.terraform.io/docs/providers/alicloud/r/api_gateway_group.html)
* [Function Computing Module](https://registry.terraform.io/modules/terraform-alicloud-modules/fc/alicloud)

## Usage

```hcl

module "serverless-webapp" {
  source                   = "terraform-alicloud-modules/serverless-webapp/alicloud"
  
  ####
  #fc#
  ####
  fc_service_name          = "terraform-fc-service"
  fc_runtime               = "python2.7"
  fc_file_name             = "index.py"
  
  #############
  #api gateway#
  #############
  create_api_gateway       = true
  create_api_gateway_group = true
  group_name               = "TerraformApiGatewayGroup"
  api_name                 = "TerraformApiGatewayApi"
  api_auth_type            = "ANONYMOUS"
  api_service_type         = "HTTP"
  app_name                 = "TerraformApiGatewayApp"
  api_request_parameters = [
    {
      name          = "appcode"
      type          = "STRING"
      required      = "OPTIONAL"
      in            = "QUERY"
      in_service    = "QUERY"
      name_service  = "appcode"
      default_value = "your_appcode"
    },
    {
      name          = "mob"
      type          = "STRING"
      required      = "REQUIRED"
      in            = "QUERY"
      in_service    = "QUERY"
      name_service  = "mob"
      default_value = ""
    },
  ]
  api_request_config = [{
    protocol = "HTTP"
    method   = "GET"
    path     = "/getInfo"
    mode     = "MAPPING"
  }]
}
```

## Examples

* [Mobile Number Attribution example](https://github.com/terraform-alicloud-modules/terraform-alicloud-serverless-webapp/tree/master/examples/cell-phone-number-querying)

## Notes
From the version v1.2.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/serverless-webapp"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.1.0:

```hcl
module "serverless-webapp" {
  source          = "terraform-alicloud-modules/serverless-webapp/alicloud"
  version         = "1.1.0"
  region          = "cn-hangzhou"
  profile         = "Your-Profile-Name"
  fc_service_name = "terraform-fc-service"
  fc_runtime      = "python2.7"
  // ...
}
```

If you want to upgrade the module to 1.2.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
}
module "serverless-webapp" {
  source          = "terraform-alicloud-modules/serverless-webapp/alicloud"
  fc_service_name = "terraform-fc-service"
  fc_runtime      = "python2.7"
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  alias   = "hz"
}
module "serverless-webapp" {
  source          = "terraform-alicloud-modules/serverless-webapp/alicloud"
  providers = {
    alicloud = alicloud.hz
  }
  fc_service_name = "terraform-fc-service"
  fc_runtime      = "python2.7"
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)