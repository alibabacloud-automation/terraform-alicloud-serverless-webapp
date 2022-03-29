variable "region" {
  description = "(Deprecated from version 1.2.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 1.2.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}

variable "shared_credentials_file" {
  description = "(Deprecated from version 1.2.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 1.2.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

# FILE variables
variable "archive_file_type" {
  description = "The type of archive file."
  type        = string
  default     = "zip"
}

variable "archive_file_output_path" {
  description = "The path of archive file."
  type        = string
  default     = "index.zip"
}

# RAM variables
variable "ram_role_description" {
  description = "Description of the RAM role."
  type        = string
  default     = ""
}

variable "ram_role_force" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = true
}

variable "ram_policy_description" {
  description = "Description of the RAM policy."
  type        = string
  default     = ""
}

variable "ram_policy_force" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = true
}

# FC variables
variable "create_service" {
  description = "Whether to create a new FC service. Default to true."
  type        = bool
  default     = true
}

variable "fc_service_name" {
  description = "The name of fc service."
  type        = string
  default     = ""
}

variable "create_http_function" {
  description = "Whether to create http function."
  type        = bool
  default     = true
}

variable "fc_file_name" {
  description = "The file name of fc function."
  type        = string
  default     = "index.py"
}

variable "fc_runtime" {
  description = "The runtime of fc function, its supports nodejs6, nodejs8, nodejs10, python2.7, python3, java8, php7.2 and dotnatcore2.1."
  type        = string
  default     = "python2.7"
}

# API variables
variable "create_api_gateway" {
  description = "Whether to create api gateway resources."
  type        = bool
  default     = true
}

variable "create_api_gateway_group" {
  description = "Whether to create an new api gateway group with Terraform."
  type        = bool
  default     = true
}

variable "group_name" {
  description = "The name of the api gateway group."
  type        = string
  default     = ""
}

variable "api_gateway_group_description" {
  description = "The description of the api gateway group. Defaults to null."
  type        = string
  default     = ""
}

variable "api_name" {
  description = "The name of the api gateway api."
  type        = string
  default     = ""
}

variable "group_id" {
  description = "The id of the api gateway group, if you set 'create_api_gateway_group' false, this field must be specified."
  type        = string
  default     = ""
}

variable "api_gateway_api_description" {
  description = "The description of the api. Defaults to null."
  type        = string
  default     = ""
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
  default = []
}

variable "timeout" {
  description = "Backend service time-out time. Unit: millisecond."
  type        = number
  default     = 10
}

variable "api_request_parameters" {
  description = "equest_parameters defines the request parameters of the api."
  type = list(object({
    name          = string
    type          = string
    required      = string
    in            = string
    in_service    = string
    name_service  = string
    default_value = string
  }))
  default = []
}

variable "api_stage_name" {
  description = "Stages that the api need to be deployed. Valid value: RELEASE | PRE | TEST."
  type        = list(string)
  default = [
    "RELEASE",
    "PRE",
    "TEST",
  ]
}

variable "app_name" {
  description = "The name of the api gateway app."
  type        = string
  default     = ""
}

variable "api_gateway_app_description" {
  description = "The description of the app. Defaults to null."
  type        = string
  default     = ""
}

variable "app_stage_name" {
  description = "Stage that the app apply to access."
  type        = string
  default     = "RELEASE"
}

variable "api_service_type" {
  description = "The type of backend service. Type including HTTP,VPC and MOCK."
  type        = string
  default     = "HTTP"
}

variable "api_http_service_config" {
  description = "http_service_config defines the config when service_type selected 'HTTP'."
  type = list(object({
    address   = string
    method    = string
    path      = string
    timeout   = number
    aone_name = string
  }))
  default = []
}