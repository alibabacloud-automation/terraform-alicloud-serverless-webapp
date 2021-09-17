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

## Terraform versions

This module requires Terraform 0.12.

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

* This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)