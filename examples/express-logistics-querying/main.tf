// This is a example show how to create a serverless webapp, product details reference: https://market.aliyun.com/products/56928004/cmapi021863.html

variable "express_number" {
  description = "The express number which will be inquired."
  type        = string
  default     = ""
}
variable "wait_for_timeout" {
  description = "The timeout in second used to wait for the app is ready."
  type        = number
  default     = 300
}

variable "has_purchased" {
  description = "If you have not purchased this product, please set `false`, if you have already purchased this product, please set `true`"
  type        = bool
  default     = true
}

data "alicloud_api_gateway_apps" "this" {
  name_regex = "^云市场.*"
}

resource "alicloud_market_order" "this" {
  count           = var.has_purchased ? 0 : 1
  product_code    = "cmapi021863"
  pay_type        = "PrePaid"
  pricing_cycle   = "Year"
  package_version = "yuncode1586300000"
}

locals {
  request_config_protocol = "HTTP"
  request_config_path     = "/kdi"
  request_parameter_name  = "number"

  this_webapp_url = format("%s://%s%s?%s=%s",
    lower(local.request_config_protocol),
    module.express_logistics_querying.this_api_gateway_group_sub_domain,
    local.request_config_path,
    local.request_parameter_name,
  var.express_number)
}

module "express_logistics_querying" {
  source                   = "../../"
  api_auth_type            = "ANONYMOUS"
  create_api_gateway_group = true
  api_request_parameters = [
    {
      name          = "appcode"
      type          = "STRING"
      required      = "OPTIONAL"
      in            = "QUERY"
      in_service    = "QUERY"
      name_service  = "appcode"
      default_value = data.alicloud_api_gateway_apps.this.apps.0.app_code
    },
    {
      name          = local.request_parameter_name
      type          = "STRING"
      required      = "REQUIRED"
      in            = "QUERY"
      in_service    = "QUERY"
      name_service  = local.request_parameter_name
      default_value = var.express_number
    },
  ]
  api_request_config = [{
    protocol = local.request_config_protocol
    method   = "GET"
    path     = local.request_config_path
    mode     = "MAPPING"
  }]
}

resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "bash ${path.module}/wait.sh ${local.this_webapp_url} ${var.wait_for_timeout}"
  }
}