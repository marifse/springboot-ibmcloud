data "ibm_resource_group" "rg" {
  name = "Default"
}
resource "ibm_cr_namespace" "rg_namespace" {
  name              = var.namespace_name
  resource_group_id = data.ibm_resource_group.rg.id

}

resource "docker_registry_image" "image-registry" {
  name          = docker_image.image.name
  keep_remotely = true
}

resource "docker_image" "image" {
  name = "${var.authRegitry}/${var.namespace_name}/${var.application_name}"
  build {
    context = "../"
    tag = ["${var.imageURLRegistry}/${var.namespace_name}/${var.application_name}:latest","${var.authRegitry}/${var.namespace_name}/${var.application_name}:latest"]
    
  }
}

resource "ibm_code_engine_project" "code_engine_project_instance" {
  name              = var.projectName
  resource_group_id = data.ibm_resource_group.rg.id
}

resource "ibm_code_engine_app" "code_engine_app_instance" {
  project_id      = ibm_code_engine_project.code_engine_project_instance.project_id
  name            = var.application_name
  image_reference = "${var.imageURLRegistry}/${var.namespace_name}/${var.application_name}"
  image_secret = ibm_code_engine_secret.code_engine_registry_access_secret.name
  image_port =  "8080"

  depends_on = [
    ibm_code_engine_secret.code_engine_registry_access_secret,
    docker_image.image,
    docker_registry_image.image-registry
  ]
}
resource "ibm_code_engine_secret" "code_engine_registry_access_secret" {
  project_id = ibm_code_engine_project.code_engine_project_instance.project_id
  name       = "my-registry-secret-arif"
  format     = "registry"
  data       = {
    "username" = "iamapikey"
    "password" = var.ibmcloud_api_key
    "server"   = var.imageURLRegistry
    "email"    = var.email
  }
}
