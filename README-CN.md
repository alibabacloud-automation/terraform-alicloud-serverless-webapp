Alibaba Cloud Serverless Webapp Terraform Module  
terraform-alicloud-serverless-webapp
=====================================================================

本 Module 用于在阿里云上基于函数计算服务和API Gateway快速部署Serverless应用。 

本 Module 支持创建以下资源:

* [API Gateway API](https://www.terraform.io/docs/providers/alicloud/r/api_gateway_api.html)
* [API Gateway APP](https://www.terraform.io/docs/providers/alicloud/r/api_gateway_app.html)
* [API Gateway Group](https://www.terraform.io/docs/providers/alicloud/r/api_gateway_group.html)
* [Function Computing Module](https://registry.terraform.io/modules/terraform-alicloud-modules/fc/alicloud)


## Terraform 版本

本模板要求使用版本 Terraform 0.12.

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

* 本 Module 使用的 AccessKey 和 SecretKey 可以直接从 `profile` 和 `shared_credentials_file` 中获取。如果未设置，可通过下载安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 后进行配置.

作者
-------
Created and maintained by Wang li(@Lexsss, 13718193219@163.com) and He Guimin(@xiaozhu36, heguimin36@163.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)