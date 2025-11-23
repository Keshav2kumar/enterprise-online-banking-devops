resource "vsphere_virtual_machine" "k8s_master" {
  name   = "k8s-master"
  cpu    = 4
  memory = 8192
  guest_id = "otherGuest64"

  network_interface {
    network_id = var.network_id
  }

  disk {
    label = "disk0"
    size  = 50
  }
}

resource "vsphere_virtual_machine" "k8s_worker" {
  count = 2
  name  = "k8s-worker-${count.index}"

  cpu    = 4
  memory = 8192
  guest_id = "otherGuest64"

  network_interface {
    network_id = var.network_id
  }

  disk {
    label = "disk0"
    size  = 50
  }
}
