variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
  default = ""
}

variable "code_engine_build_output_secret" {
  description = "The secret that is required to access the image registry. Make sure that the secret is granted with push permissions towards the specified container registry namespace."
  type        = string
  default     = "ce-auto-icr-private-us-south"
}

variable "namespace_name" {
  type = string
  default = "my_springboot_namespace_1"
}

variable "application_name" {
  type = string
  default = "springboot-app14"
}

variable "imageURLRegistry" {
  type = string
  default = "private.us.icr.io"
}

variable "authRegitry" {
  type = string
  default = "us.icr.io"
}

variable "projectName" {
  type = string
  default = "Springboot-CE17"
}
