output "this_api_gateway_group_id" {
  description = "The id of the api gateway group"
  value       = module.cell_phone_number_querying.this_api_gateway_group_id
}

output "this_api_gateway_group_name" {
  description = "The name of the api gateway group"
  value       = module.cell_phone_number_querying.this_api_gateway_group_name
}

output "this_api_gateway_group_domain" {
  description = "The sub domain of the api gateway group"
  value       = module.cell_phone_number_querying.this_api_gateway_group_sub_domain
}

output "this_api_gateway_api_id" {
  description = "The id of the api gateway api"
  value       = module.cell_phone_number_querying.this_api_gateway_api_id
}

output "this_api_gateway_api_name" {
  description = "The name of the api gateway api"
  value       = module.cell_phone_number_querying.this_api_gateway_api_name
}

output "this_fc_service_id" {
  description = "The id of the fc service"
  value       = module.cell_phone_number_querying.this_fc_service_id
}

output "this_fc_service_name" {
  description = "The id of the fc service"
  value       = module.cell_phone_number_querying.this_fc_service_name
}

output "this_fc_function_id" {
  description = "The id of the fc function"
  value       = module.cell_phone_number_querying.this_fc_function_id
}

output "this_fc_function_name" {
  description = "The id of the fc function"
  value       = module.cell_phone_number_querying.this_fc_function_name
}

output "this_request_parameters" {
  description = "The request parameters of the api gateway api"
  value       = module.cell_phone_number_querying.this_request_parameters
}

output "this_request_config" {
  description = "The request config of the api gateway api"
  value       = module.cell_phone_number_querying.this_request_config
}

output "this_fc_service_config" {
  description = "The fc service config of the api gateway api"
  value       = module.cell_phone_number_querying.this_fc_service_config
}

output "this_webapp_url" {
  description = "The url of this app."
  value       = local.this_webapp_url
}