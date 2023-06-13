terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.52.0"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = "5JQVcqELWEvfJ1dAfKx1IRtgHNnoUuR7JmvZlV8YjJAr"
}

provider "docker" {
  registry_auth {
    address = "us.icr.io"
    username = "iamapikey"
    password = var.ibmcloud_api_key
  }
}
