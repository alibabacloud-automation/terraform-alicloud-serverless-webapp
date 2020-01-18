output "this_api_gateway_group_id" {
  description = "The id of the api gateway group"
  value       = compact(concat([var.group_id], alicloud_api_gateway_group.this.*.id))[0]
}

output "this_api_gateway_group_name" {
  description = "The name of the api gateway group"
  value       = concat(alicloud_api_gateway_group.this.*.name, [""])[0]
}

output "this_api_gateway_group_sub_domain" {
  description = "The public sub domain of the api gateway group"
  value       = concat(alicloud_api_gateway_group.this.*.sub_domain, [""])[0]
}

output "this_api_gateway_group_vpc_domain" {
  description = "The vpc sub domain of the api gateway group"
  value       = concat(alicloud_api_gateway_group.this.*.vpc_domain, [""])[0]
}

output "this_api_gateway_api_id" {
  description = "The id of the api gateway api"
  value       = concat(alicloud_api_gateway_api.this.*.api_id, [""])[0]
}

output "this_api_gateway_api_name" {
  description = "The name of the api gateway api"
  value       = concat(alicloud_api_gateway_api.this.*.name, [""])[0]
}

output "this_fc_service_id" {
  description = "The id of the fc service"
  value       = module.fc.this_service_id
}

output "this_fc_service_name" {
  description = "The id of the fc service"
  value       = module.fc.this_service_name
}

output "this_fc_function_id" {
  description = "The id of the fc function"
  value       = module.fc.this_http_function_id
}

output "this_fc_function_name" {
  description = "The id of the fc function"
  value       = module.fc.this_http_function_name
}

output "this_request_parameters" {
  description = "The request parameters of the api gateway api"
  value       = alicloud_api_gateway_api.this.*.request_parameters
}

output "this_request_config" {
  description = "The request config of the api gateway api"
  value       = alicloud_api_gateway_api.this.*.request_config
}

output "this_fc_service_config" {
  description = "The fc service config of the api gateway api"
  value       = alicloud_api_gateway_api.this.*.fc_service_config
}