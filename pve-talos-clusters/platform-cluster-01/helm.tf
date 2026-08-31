# resource "helm_release" "argocd" {
#   namespace        = "argocd"
#   name             = "argocd"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argo-cd"
#   create_namespace = true
#   version          = "10.3.2"
#   values = [
#     templatefile("${path.module}/helm_values/argocd-values.yml", {
#       hostname = local.argocd_hostname,
#       argocd_pocketid_client_secret = var.argocd_pocketid_client_secret
#     })
#   ]
#   depends_on = [data.talos_cluster_health.this, proxmox_virtual_environment_vm.talos-worker]
# }