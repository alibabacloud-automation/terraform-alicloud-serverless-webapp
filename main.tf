provider "alicloud" {
  version                 = ">=1.69.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/serverless-webapp/alicloud"
}

data "alicloud_regions" "this" {
  current = true
}

module "fc" {
  source                 = "terraform-alicloud-modules/fc/alicloud"
  create_service         = true
  service_name           = var.fc_service_name
  create_http_function   = true
  http_function_filename = "./${data.archive_file.zip.output_path}"
  http_function_runtime  = var.fc_runtime
}

resource "alicloud_api_gateway_group" "this" {
  count       = var.create_api_gateway ? var.create_api_gateway_group ? 1 : 0 : 0
  name        = var.group_name == "" ? "ServerlessWebGroup${random_integer.this.result}" : var.group_name
  description = "Create by modules/terraform-alicloud-serverless-webapp"
}

resource "alicloud_api_gateway_api" "this" {
  count       = var.create_api_gateway ? 1 : 0
  name        = var.api_name == "" ? "ServerlessWebApi${random_integer.this.result}" : var.api_name
  group_id    = compact(concat([var.group_id], alicloud_api_gateway_group.this.*.id))[0]
  description = "Create by modules/terraform-alicloud-serverless-webapp"
  auth_type   = var.api_auth_type
  dynamic "request_config" {
    for_each = var.api_request_config
    content {
      body_format = lookup(request_config.value, "body_format", null)
      method      = request_config.value.method
      mode        = request_config.value.mode
      path        = request_config.value.path
      protocol    = request_config.value.protocol
    }
  }
  service_type = "FunctionCompute"
  fc_service_config {
    region        = data.alicloud_regions.this.ids[0]
    function_name = module.fc.this_http_function_name
    service_name  = module.fc.this_service_name
    arn_role      = alicloud_ram_role.this.arn
    timeout       = 10
  }
  dynamic "request_parameters" {
    for_each = var.api_request_parameters
    content {
      default_value = request_parameters.value.default_value
      description   = lookup(request_parameters.value, "description", null)
      in            = request_parameters.value.in
      in_service    = request_parameters.value.in_service
      name          = request_parameters.value.name
      name_service  = request_parameters.value.name_service
      required      = request_parameters.value.required
      type          = request_parameters.value.type
    }
  }
  stage_names = var.api_stage_name
}

resource "alicloud_api_gateway_app" "this" {
  count       = var.create_api_gateway ? 1 : 0
  name        = var.app_name == "" ? "ServerlessWebApp${random_integer.this.result}" : var.app_name
  description = "Create by modules/terraform-alicloud-serverless-webapp"
}

resource "alicloud_api_gateway_app_attachment" "foo" {
  count      = var.create_api_gateway ? 1 : 0
  api_id     = concat(alicloud_api_gateway_api.this.*.api_id, [""])[0]
  group_id   = compact(concat([var.group_id], alicloud_api_gateway_group.this.*.id))[0]
  stage_name = "RELEASE"
  app_id     = concat(alicloud_api_gateway_app.this.*.id, [""])[0]
}
