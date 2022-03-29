data "alicloud_api_gateway_apps" "default" {
}

module "example" {
  source = "../.."

  #archive_file
  archive_file_type        = "zip"
  archive_file_output_path = "index.zip"

  #RAM
  ram_role_description   = var.ram_role_description
  ram_role_force         = var.ram_role_force
  ram_policy_description = "tf-testacc-ram-policy-description"
  ram_policy_force       = var.ram_policy_force

  #FC
  create_service       = true
  fc_service_name      = "tf-testacc-fc-service"
  create_http_function = true
  fc_file_name         = "index.py"
  fc_runtime           = var.fc_runtime

  #alicloud_api_gateway_group
  create_api_gateway       = true
  create_api_gateway_group = true

  group_name                    = var.group_name
  api_gateway_group_description = var.api_gateway_group_description

  #alicloud_api_gateway_api
  api_name                    = var.api_name
  api_gateway_api_description = var.api_gateway_api_description
  api_auth_type               = var.api_auth_type
  api_request_config          = var.api_request_config
  timeout                     = var.timeout
  api_request_parameters = [
    {
      name          = "appcode"
      type          = "STRING"
      required      = "OPTIONAL"
      in            = "QUERY"
      in_service    = "QUERY"
      name_service  = "appcode"
      default_value = data.alicloud_api_gateway_apps.default.apps.0.app_code
    }
  ]
  api_stage_name = var.api_stage_name

  #alicloud_api_gateway_app
  app_name                    = var.app_name
  api_gateway_app_description = var.api_gateway_app_description

  #alicloud_api_gateway_app_attachment
  app_stage_name = "RELEASE"

}