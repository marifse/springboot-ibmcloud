variable "ibmcloud_api_key" {
  type        = string
  description = "The IAM API Key for IBM Cloud access (https://cloud.ibm.com/iam/apikeys)"
  default = ""
}

variable "resource_group" {
  type        = string
  description = "Resource group name where the toolchain should be created (`ibmcloud resource groups`)"
  default = "Default"
}

variable "cluster_name" {
  type        = string
  description = "Name of new Kubernetes cluster to create"
  default = "mycluster-free"
}

variable "machine_type" {
  default     = "free"
  description = "Name of machine type from `ibmcloud ks flavors --zone <ZONE>`"
}
variable "hardware" {
  default     = "shared"
  description = "The level of hardware isolation for your worker node. Use 'dedicated' to have available physical resources dedicated to you only, or 'shared' to allow physical resources to be shared with other IBM customers. For IBM Cloud Public accounts, the default value is shared. For IBM Cloud Dedicated accounts, dedicated is the only available option."
}

variable "datacenter" {
  type        = string
  description = "Zone from `ibmcloud ks zones --provider classic`"
  default = "sjc04"
}

variable "default_pool_size" {
  default     = "1"
  description = "Number of worker nodes for the new Kubernetes cluster"
}

variable "private_vlan_num" {
  type        = string
  description = "Number for private VLAN from `ibmcloud ks vlans --zone <ZONE>`"
  default = "2108609"
}

variable "public_vlan_num" {
  type        = string
  description = "Number for public VLAN from `ibmcloud ks vlans --zone <ZONE>`"
  default = "2108607"
}

variable "kube_version" {
  default     = "1.24.7"
  description = "Version of Kubernetes to apply to the new Kubernetes cluster"
}

variable "cluster_namespace" {
  type        = string
  description = "Kubernetes namespace to deploy into. NOTE: If the namespace does not exist, it will be created."
  default = "default"
}

variable "container_registry_namespace" {
  type        = string
  description = "IBM Container Registry namespace to save image into. NOTE: If the namespace does not exist, it will be created."
  default = "arif3-test"
}

variable "app_repo" {
  type        = string
  description = "Repository url for the repository containing application source code."
  default     = "https://github.com/marifse/springboot-ibmcloud.git"
}

variable "pipeline_repo" {
  type        = string
  description = "Repository url for the repository containing pipeline source code."
  default     = "https://us-south.git.cloud.ibm.com/open-toolchain/simple-helm-toolchain.git"
}

variable "tekton_tasks_catalog_repo" {
  type        = string
  description = "Repository url for the repository containing commonly used tekton tasks."
  default     = "https://us-south.git.cloud.ibm.com/open-toolchain/tekton-catalog.git"
}

variable "repositories_prefix" {
  type        = string
  description = "Repository url for the repository containing application source code."
  default     = "app-name"
}

variable "app_name" {
  type        = string
  description = "Name of the application."
  default     = "simple-helm-app"
}

variable "app_image_name" {
  type        = string
  description = "Name of the application image."
  default     = "simple-helm-app"
}

variable "region" {
  type        = string
  description = "IBM Cloud region where your toolchain will be created"
  default     = "us-south"
}

variable "cluster_region" {
  type        = string
  description = "Region of the kubernetes cluster where the application will be deployed."
  default     = "ibm:yp1:us-south"
}

variable "kp_name" {
  type        = string
  description = "Name of the Key Protect Instance to store the secrets."
  default     = "Key Protect Service"
}

variable "kp_region" {
  type        = string
  description = "IBM Cloud Region where the Key Protect Instance is created."
  default     = "ibm:yp1:us-south"
}

variable "ibm_cloud_api" {
  type        = string
  description = "IBM Cloud API Endpoint"
  default     = "https://cloud.ibm.com"
}

