Alibaba Cloud Serverless Webapp Terraform Module  
terraform-alicloud-serverless-webapp
=====================================================================

本 Module 用于在阿里云上基于函数计算服务和API Gateway快速部署Serverless应用。 

本 Module 支持创建以下资源:

* [API Gateway API](https://www.terraform.io/docs/providers/alicloud/r/api_gateway_api.html)
* [API Gateway APP](https://www.terraform.io/docs/providers/alicloud/r/api_gateway_app.html)
* [API Gateway Group](https://www.terraform.io/docs/providers/alicloud/r/api_gateway_group.html)
* [Function Computing Module](https://registry.terraform.io/modules/terraform-alicloud-modules/fc/alicloud)

## 用法

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

## 示例

* [手机号码归属地查询示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-serverless-webapp/tree/master/examples/cell-phone-number-querying)

## 注意事项
本Module从版本v1.2.0开始已经移除掉如下的 provider 的显示设置：

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/serverless-webapp"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.1.0:

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

如果你想对正在使用中的Module升级到 1.2.0 或者更高的版本，那么你可以在模板中显示定义一个系统过Region的provider：
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
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显示指定这个provider：

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

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)