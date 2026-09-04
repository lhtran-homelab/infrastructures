data "aws_caller_identity" "current" {}

locals {
  aws_region         = "us-east-1"
  argocd_hostname    = "argocd.tools.lhtran.com"
  talos_cluster_name = "platform-cluster-01"

  irsa_issuer_host = split("/", module.platform_cluster_01.oidc.issuer)[2]

}
