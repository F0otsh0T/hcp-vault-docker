# versions.tf

terraform {
  required_version = ">= 0.13"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.16.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">=2.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">=3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.1.0"
    }
  }
}





