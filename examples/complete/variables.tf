# RAM variables
variable "ram_role_description" {
  description = "Description of the RAM role."
  type        = string
  default     = "tf-testacc-ram-role-description"
}

variable "ram_role_force" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = false
}

variable "ram_policy_force" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = false
}

# FC variables
variable "fc_runtime" {
  description = "The runtime of fc function, its supports nodejs6, nodejs8, nodejs10, python2.7, python3, java8, php7.2 and dotnatcore2.1."
  type        = string
  default     = "python2.7"
}

# API variables
variable "group_name" {
  description = "The name of the api gateway group."
  type        = string
  default     = "tf_testacc_group"
}

variable "api_gateway_group_description" {
  description = "The description of the api gateway group. Defaults to null."
  type        = string
  default     = "tf-testacc-group-description"
}

variable "api_name" {
  description = "The name of the api gateway api."
  type        = string
  default     = "tf_testacc_api"
}

variable "api_gateway_api_description" {
  description = "The description of the api. Defaults to null."
  type        = string
  default     = "tf-testacc-api-description"
}

variable "api_auth_type" {
  description = "The authorization Type including APP and ANONYMOUS."
  type        = string
  default     = "APP"
}

variable "api_request_config" {
  description = "Request_config defines how users can send requests to your API."
  type = list(object({
    protocol = string
    method   = string
    path     = string
    mode     = string
  }))
  default = [
    {
      protocol = "HTTP"
      method   = "GET"
      path     = "/test/path"
      mode     = "MAPPING"
    },
  ]
}

variable "timeout" {
  description = "Backend service time-out time. Unit: millisecond."
  type        = number
  default     = 10
}

variable "api_stage_name" {
  description = "Stages that the api need to be deployed. Valid value: RELEASE | PRE | TEST."
  type        = list(string)
  default = [
    "RELEASE",
  ]
}

variable "app_name" {
  description = "The name of the api gateway app."
  type        = string
  default     = "tf_testacc_app"
}

variable "api_gateway_app_description" {
  description = "The description of the app. Defaults to null."
  type        = string
  default     = "tf-testacc-app-description"
}