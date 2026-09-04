terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket       = "tf-proxmox-talos-734061930556-us-east-1-an"
    region       = "us-east-1"
    key          = "pve-talos-clusters/platform-cluster-01/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "helm" {
  kubernetes = {
    host                   = module.platform_cluster_01.kubeconfig.host
    client_certificate     = base64decode(module.platform_cluster_01.kubeconfig.client_certificate)
    client_key             = base64decode(module.platform_cluster_01.kubeconfig.client_key)
    cluster_ca_certificate = base64decode(module.platform_cluster_01.kubeconfig.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = module.platform_cluster_01.kubeconfig.host
  client_certificate     = base64decode(module.platform_cluster_01.kubeconfig.client_certificate)
  client_key             = base64decode(module.platform_cluster_01.kubeconfig.client_key)
  cluster_ca_certificate = base64decode(module.platform_cluster_01.kubeconfig.cluster_ca_certificate)
}
