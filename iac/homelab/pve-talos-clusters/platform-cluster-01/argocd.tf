resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    labels = {
      shared-traefik-gateway-access : "true"
    }
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  namespace        = "argocd"
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  create_namespace = false
  version          = "10.3.2"
  values = [
    templatefile("${path.module}/helm_values/argocd-values.yml", {
      hostname = local.argocd_hostname
    })
  ]
  depends_on = [module.platform_cluster_01]
}
