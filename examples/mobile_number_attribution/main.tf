data "alicloud_api_gateway_apps" "this" {
  name_regex = "^云市场.*"
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
    path     = "/getInfo"
    mode     = "MAPPING"
  }]
}