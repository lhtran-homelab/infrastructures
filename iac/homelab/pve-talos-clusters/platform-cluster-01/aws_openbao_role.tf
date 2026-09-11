data "aws_kms_alias" "openbao_unseal" {
  name = "alias/openbao-unseal-key"
}

data "aws_iam_policy_document" "openbao_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.irsa.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.irsa_issuer_host}:sub"
      values   = ["system:serviceaccount:openbao:openbao"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.irsa_issuer_host}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "openbao_unseal" {
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
    ]
    resources = [data.aws_kms_alias.openbao_unseal.target_key_arn]
  }
}

resource "aws_iam_role" "openbao" {
  name               = "openbao-platform-cluster-01"
  description        = "AWS KMS auto-unseal access for OpenBao on platform-cluster-01"
  assume_role_policy = data.aws_iam_policy_document.openbao_assume_role.json
}

resource "aws_iam_role_policy" "openbao_unseal" {
  name   = "kms-auto-unseal"
  role   = aws_iam_role.openbao.id
  policy = data.aws_iam_policy_document.openbao_unseal.json
}

output "openbao_role_arn" {
  description = "IRSA role ARN for the openbao/openbao service account."
  value       = aws_iam_role.openbao.arn
}
