output "master_ip" {
  value = vsphere_virtual_machine.k8s_master.default_ip_address
}

output "worker_ips" {
  value = vsphere_virtual_machine.k8s_worker[*].default_ip_address
}
