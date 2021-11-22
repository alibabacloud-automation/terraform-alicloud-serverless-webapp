variable "region" {
  description = "(Deprecated from version 1.2.0) The region used to launch this module resources."
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 1.2.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = ""
}
variable "shared_credentials_file" {
  description = "(Deprecated from version 1.2.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 1.2.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  default     = false
}

// FC variables
variable "fc_service_name" {
  description = "The name of fc service"
  default     = "terraform-fc-service-for-serverless-webapp"
}

variable "fc_runtime" {
  description = "The runtime of fc function, its supports nodejs6, nodejs8, nodejs10, python2.7, python3, java8, php7.2 and dotnatcore2.1"
  default     = "python2.7"
}

variable "fc_file_name" {
  description = "The file name of fc function"
  default     = "index.py"
}

// API variables
variable "create_api_gateway" {
  description = "Whether to create api gateway resources"
  default     = true
}

variable "create_api_gateway_group" {
  description = "Whether to create an new api gateway group with Terraform"
  default     = true
}

variable "group_id" {
  description = "The id of the api gateway group, if you set 'create_api_gateway_group' false, this field must be specified"
  default     = ""
}

variable "group_name" {
  description = "The name of the api gateway group"
  default     = ""
}

variable "api_name" {
  description = "The name of the api gateway api"
  default     = ""
}

variable "api_auth_type" {
  description = "The authorization Type including APP and ANONYMOUS."
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
      path     = "/test/path1"
      mode     = "MAPPING"
    },
  ]
}


variable "api_service_type" {
  description = "The type of backend service. Type including HTTP,VPC and MOCK."
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
  default = [
    {
      address   = "http://apigateway-backend.alicloudapi.com:8080"
      method    = "GET"
      path      = "/web/cloudapi"
      timeout   = 12
      aone_name = "cloudapi-openapi"
    },
  ]
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
  default = [
    {
      name          = "test"
      type          = "STRING"
      required      = "REQUIRED"
      in            = "QUERY"
      in_service    = "QUERY"
      name_service  = "testparams"
      default_value = "testDefaultValue"
    },
  ]
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
  description = "The name of the api gateway app"
  default     = ""
}
