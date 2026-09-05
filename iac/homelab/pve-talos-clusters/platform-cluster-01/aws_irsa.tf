resource "aws_iam_openid_connect_provider" "irsa" {
  url            = module.platform_cluster_01.oidc.issuer
  client_id_list = ["sts.amazonaws.com"]
}
