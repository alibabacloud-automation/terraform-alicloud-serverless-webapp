# RAM variables
ram_role_description = "update-tf-testacc-ram-role-description"
ram_role_force       = true
ram_policy_force     = true

# FC variables
fc_runtime = "python3"

# API variables
group_name                    = "update_tf_testacc_group"
api_gateway_group_description = "update-tf-testacc-group-description"
api_name                      = "update_tf_testacc_api"
api_gateway_api_description   = "update-tf-testacc-api-description"
api_auth_type                 = "ANONYMOUS"
api_request_config = [
  {
    protocol = "HTTPS"
    method   = "GET"
    path     = "/test/path"
    mode     = "MAPPING"
  },
]
timeout = 20
api_stage_name = [
  "RELEASE",
  "PRE",
  "TEST",
]
app_name                    = "update_tf_testacc_app"
api_gateway_app_description = "update-tf-testacc-app-description"