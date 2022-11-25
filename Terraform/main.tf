terraform {
  required_version = ">= 0.12"
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.48.0-beta0"
    }
  }
}

resource "random_string" "random" {
  length = 4
  min_lower = 4
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}

provider "ibm" {
  ibmcloud_api_key   = var.ibmcloud_api_key
}

#resource "ibm_container_cluster" "cluster" {
#  name              = var.cluster_name
#  datacenter        = var.datacenter
#  default_pool_size = var.default_pool_size
#  machine_type      = var.machine_type
#  hardware          = var.hardware
#  kube_version      = var.kube_version
#  #public_vlan_id    = var.public_vlan_num
#  #private_vlan_id   = var.private_vlan_num
#  resource_group_id = data.ibm_resource_group.group.id
#}

resource "ibm_resource_instance" "cd_instance_1" {
  name              = "cloudant-terraform-service-node-${random_string.random.result}"
  service           = "continuous-delivery"
  plan              = "lite" 
  location          = var.region 
  resource_group_id = data.ibm_resource_group.group.id

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "ibm_cd_toolchain" "toolchain_instance" {
  name        = "cloudant-terraform-toolchain-node-${random_string.random.result}"
  description = "A sample toolchain to test the API"
  resource_group_id = data.ibm_resource_group.group.id
}

module "repositories" {
  source                          = "./repositories"
  toolchain_id                    = ibm_cd_toolchain.toolchain_instance.id
  resource_group                  = data.ibm_resource_group.group.id
  ibm_cloud_api_key               = var.ibmcloud_api_key
  region                          = var.region  
  app_repo                        = var.app_repo
  pipeline_repo                   = var.pipeline_repo
  tekton_tasks_catalog_repo       = var.tekton_tasks_catalog_repo
  repositories_prefix             = random_string.random.result
}

resource "ibm_cd_toolchain_tool_pipeline" "ci_pipeline" {
  toolchain_id = ibm_cd_toolchain.toolchain_instance.id
  parameters {
    name = "ci-pipeline"
    #type = "tekton"
  }
}

module "pipeline-ci" {
  source                    = "./pipeline-ci"
  depends_on                = [ module.repositories ]
  ibm_cloud_api_key         = var.ibmcloud_api_key
  region                    = var.region
  pipeline_id               = split("/", ibm_cd_toolchain_tool_pipeline.ci_pipeline.id)[1]
  resource_group            = var.resource_group
  app_name                  = var.app_name
  app_image_name            = var.app_image_name  
  cluster_name              = var.cluster_name
  cluster_namespace         = var.cluster_namespace
  cluster_region            = var.cluster_region
  registry_namespace        = var.container_registry_namespace
  registry_region           = var.cluster_region
  app_repo                  = module.repositories.app_repo_url 
  pipeline_repo             = module.repositories.pipeline_repo_url
  tekton_tasks_catalog_repo = module.repositories.tekton_tasks_catalog_repo_url
  kp_integration_name       = var.ibmcloud_api_key
}

resource "null_resource" "trigger_pipeline" {
provisioner "local-exec" {
command = <<EOT

JSON_TOKEN=$(curl --location --request POST 'https://iam.cloud.ibm.com/identity/token' --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' --data-urlencode 'grant_type=urn:ibm:params:oauth:grant-type:apikey' --data-urlencode 'apikey=${var.ibmcloud_api_key}')

ACCESS_TOKEN=$(echo $JSON_TOKEN | jq -j '.access_token')

curl -X POST --location --header "Authorization: Bearer $ACCESS_TOKEN" \
--header "Accept: application/json" --header "Content-Type: application/json" \
--data '{ "trigger_name": "manual-run", "trigger_properties": { "pipeline-debug": "false" }, "secure_trigger_properties": { "secure-property-key": "secure value" }, "trigger_headers": { "source": "api" }, "trigger_body": { "message": "hello world", "enable": "true", "detail": { "name": "example" } } }' \
"https://api.us-south.devops.cloud.ibm.com/v2/tekton_pipelines/${module.pipeline-ci.pipeline_id}/pipeline_runs"
EOT
}
depends_on = [
module.pipeline-ci,
#ibm_container_cluster.cluster,
ibm_resource_instance.cd_instance_1,
#ibm_resource_instance.cloudant
]
}
