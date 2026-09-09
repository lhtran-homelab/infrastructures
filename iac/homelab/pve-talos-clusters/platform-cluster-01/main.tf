module "platform_cluster_01" {
  source                   = "https://github.com/lhtran-homelab/iac-modules/releases/download/pve-talos-cluster-v0.3.3/pve-talos-cluster-v0.3.3.zip"
  proxmox_api_url          = data.aws_ssm_parameter.proxmox_api_url.value
  proxmox_api_token_id     = data.aws_ssm_parameter.proxmox_api_token_id.value
  proxmox_api_token_secret = data.aws_ssm_parameter.proxmox_api_token_secret.value
  proxmox_ssh_user         = data.aws_ssm_parameter.talos_proxmox_ssh_user.value
  proxmox_ssh_private_key  = data.aws_ssm_parameter.talos_proxmox_ssh_private_key.value
  proxmox_nodes            = ["pve1", "pve3", "pve2"]

  vm_storage            = "truenas-nvme"
  vm_image_storage      = "truenas-nfs"
  vm_network_pve_bridge = "vmbr101"

  vm_controller_count        = 1
  vm_controller_cpu_cores    = 2
  vm_controller_memory       = 4096
  vm_controller_disk_size_gb = 40

  vm_worker_count        = 1
  vm_worker_cpu_cores    = 2
  vm_worker_memory       = 4096
  vm_worker_disk_size_gb = 60

  talos_cluster_name                = local.talos_cluster_name
  talos_cluster_virtual_ip_hostname = "${local.talos_cluster_name}.lhtran.com"
  talos_cluster_virtual_ip          = "172.16.101.5"
  talos_architecture                = "amd64"
  talos_version                     = "1.13.8"
  talos_schematic_id                = "e15f3b626ab4a557519983f80f0530ab962ceb961e49c38f577da35dfeee9fa4" #siderolabs/iscsi-tools, siderolabs/nfs-utils, siderolabs/nvme-cli, siderolabs/qemu-guest-agent
  kubernetes_version                = "1.36.2"
  kubernetes_api_gateway = {
    version = "1.6.1"
    channel = "standard"
  }
  kubernetes_pods_cidr  = "10.240.0.0/16"
  helm_cilium_version   = "1.20.0"
  cilium_bgp_port       = 1790
  cilium_lb_svc_cidr    = "10.200.1.0/24"
  cilium_bgp_local_asn  = 65000
  cilium_bgp_remote_asn = 65100
  cilium_bgp_secret     = data.aws_ssm_parameter.cilium_bgp_secret.value

  helm_democratic_csi_version                                       = "0.15.1"
  democratic_csi_truenas_host                                       = data.aws_ssm_parameter.truenas_host.value
  democratic_csi_truenas_api_key                                    = data.aws_ssm_parameter.truenas_api_key.value
  democratic_csi_truenas_zfs_dataset_parent_name                    = "RAIDZ1-SSD/TALOS-NVME/vols"
  democratic_csi_truenas_zfs_detached_snapshots_dataset_parent_name = "RAIDZ1-SSD/TALOS-NVME/snaps"

  pihole_url      = data.aws_ssm_parameter.pihole_api_url.value
  pihole_password = data.aws_ssm_parameter.pihole_password.value

  s3_oidc = {
    region = local.aws_region
  }
}

resource "local_file" "kubeconfig" {
  content  = module.platform_cluster_01.kubeconfig.raw
  filename = "${path.module}/artifacts/kubeconfig"
}

resource "local_file" "talosconfig" {
  content  = module.platform_cluster_01.talosconfig
  filename = "${path.module}/artifacts/talosconfig"
}

resource "local_file" "frr_bgp_config" {
  content  = module.platform_cluster_01.frr_bgp_config
  filename = "${path.module}/artifacts/frr_bgp.conf"
}