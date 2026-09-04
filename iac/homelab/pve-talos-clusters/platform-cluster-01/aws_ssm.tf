data "aws_ssm_parameter" "proxmox_api_url" {
  name = "/infrastructures/pve-talos-clusters/platform-cluster-01/proxmox/api-url"
}
data "aws_ssm_parameter" "proxmox_api_token_id" {
  name = "/infrastructures/pve-talos-clusters/platform-cluster-01/proxmox/token-id"
}
data "aws_ssm_parameter" "proxmox_api_token_secret" {
  name = "/infrastructures/pve-talos-clusters/platform-cluster-01/proxmox/token-secret"
}
data "aws_ssm_parameter" "talos_proxmox_ssh_user" {
  name = "/infrastructures/pve-talos-clusters/platform-cluster-01/proxmox/ssh-user"
}
data "aws_ssm_parameter" "talos_proxmox_ssh_private_key" {
  name = "/infrastructures/pve-talos-clusters/platform-cluster-01/proxmox/ssh-private-key"
}
data "aws_ssm_parameter" "cilium_bgp_secret" {
  name = "/infrastructures/pve-talos-clusters/platform-cluster-01/cilium/bgp-secret"
}
data "aws_ssm_parameter" "truenas_host" {
  name = "/infrastructures/pve-talos-clusters/platform-cluster-01/truenas/host"
}
data "aws_ssm_parameter" "truenas_api_key" {
  name = "/infrastructures/pve-talos-clusters/platform-cluster-01/truenas/api-key"
}
data "aws_ssm_parameter" "pihole_api_url" {
  name = "/infrastructures/pve-talos-clusters/platform-cluster-01/pihole/api-url"
}
data "aws_ssm_parameter" "pihole_password" {
  name = "/infrastructures/pve-talos-clusters/platform-cluster-01/pihole/password"
}
