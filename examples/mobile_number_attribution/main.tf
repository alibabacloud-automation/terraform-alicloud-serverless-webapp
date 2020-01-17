// This is a example show how to create a serverless webapp, product details reference: https://market.aliyun.com/products/57002003/cmapi028134.html

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
  product_code    = "cmapi028134"
  pay_type        = "PrePaid"
  pricing_cycle   = "Year"
  package_version = "yuncode2213400000"
}

module "mobile_number_attribution" {
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
    path     = "/mobile/query"
    mode     = "MAPPING"
  }]
}