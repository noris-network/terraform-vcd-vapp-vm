data "vcd_catalog" "catalog" {
  org  = var.catalog_org_name
  name = var.catalog_name
}

data "vcd_catalog_vapp_template" "catalog_vapp_template" {
  catalog_id = data.vcd_catalog.catalog.id
  name       = var.vapp_template_name
}

data "vcd_vapp" "vapp" {
  name = var.vapp_name
  org  = var.vdc_org_name
  vdc  = var.vdc_name
}

resource "vcd_vapp_vm" "vapp_vm" {
  org                            = var.vdc_org_name
  vdc                            = var.vdc_name
  computer_name                  = var.computer_name
  name                           = var.name
  description                    = var.description
  vapp_name                      = data.vcd_vapp.vapp.name
  vapp_template_id               = data.vcd_catalog_vapp_template.catalog_vapp_template.id
  vm_name_in_template            = var.vm_name_in_template
  os_type                        = var.os_type
  hardware_version               = var.hardware_version
  memory                         = var.memory
  cpus                           = var.cpus
  cpu_cores                      = var.cpu_cores
  memory_hot_add_enabled         = var.memory_hot_add_enabled
  memory_reservation             = var.memory_reservation
  memory_priority                = var.memory_priority
  memory_shares                  = var.memory_shares
  memory_limit                   = var.memory_limit
  cpu_hot_add_enabled            = var.cpu_hot_add_enabled
  cpu_reservation                = var.cpu_reservation
  cpu_priority                   = var.cpu_priority
  cpu_shares                     = var.cpu_shares
  cpu_limit                      = var.cpu_limit
  power_on                       = var.power_on
  accept_all_eulas               = var.accept_all_eulas
  expose_hardware_virtualization = var.expose_hardware_virtualization
  network_dhcp_wait_seconds      = var.network_dhcp_wait_seconds
  boot_image                     = var.boot_image_id
  prevent_update_power_off       = var.prevent_update_power_off
  placement_policy_id            = var.placement_policy_id
  sizing_policy_id               = var.sizing_policy_id
  security_tags                  = var.security_tags
  storage_profile                = var.storage_profile_name
  guest_properties               = var.guest_properties

  dynamic "disk" {
    for_each = length(var.disks) > 0 ? var.disks : []
    content {
      name        = disk.value.name
      bus_number  = disk.value.bus_number
      unit_number = disk.value.unit_number
    }
  }

  dynamic "override_template_disk" {
    for_each = length(var.override_template_disks) > 0 ? var.override_template_disks : []
    content {
      bus_type        = override_template_disk.value.bus_type
      size_in_mb      = override_template_disk.value.size_in_mb
      bus_number      = override_template_disk.value.bus_number
      unit_number     = override_template_disk.value.unit_number
      iops            = try(override_template_disk.value.iops, 0)
      storage_profile = try(override_template_disk.value.storage_profile, null)
    }
  }

  dynamic "network" {
    for_each = var.network
    content {
      type               = try(network.value.type, "org")
      adapter_type       = try(network.value.adapter_type, "VMXNET3")
      name               = network.value.name
      ip_allocation_mode = try(network.value.ip_allocation_mode, "POOL")
      ip                 = try(network.value.ip_allocation_mode, "POOL") == "MANUAL" ? network.value.ip : null
      is_primary         = try(network.value.is_primary, null)
    }
  }

  dynamic "metadata_entry" {
    for_each = length(var.metadata_entry) > 0 ? var.metadata_entry : []
    content {
      key         = metadata_entry.value.key
      value       = metadata_entry.value.value
      type        = metadata_entry.value.type
      user_access = metadata_entry.value.user_access
      is_system   = metadata_entry.value.is_system
    }
  }

  customization {
    force                               = try(var.customization["force"], null)
    enabled                             = try(var.customization["enabled"], null)
    change_sid                          = try(var.customization["change_sid"], null)
    allow_local_admin_password          = try(var.customization["allow_local_admin_password"], null)
    must_change_password_on_first_login = try(var.customization["must_change_password_on_first_login"], null)
    auto_generate_password              = try(var.customization["auto_generate_password"], null)
    admin_password                      = try(var.customization["admin_password"], null)
    number_of_auto_logons               = try(var.customization["number_of_auto_logons"], null)
    join_domain                         = try(var.customization["join_domain"], null)
    join_org_domain                     = try(var.customization["join_org_domain"], null)
    join_domain_name                    = try(var.customization["join_domain_name"], null)
    join_domain_user                    = try(var.customization["join_domain_user"], null)
    join_domain_password                = try(var.customization["join_domain_password"], null)
    join_domain_account_ou              = try(var.customization["join_domain_account_ou"], null)
    initscript                          = try(var.customization["initscript"], null)
  }

  lifecycle {
    ignore_changes = [vapp_template_id]
  }
}

resource "vcd_vm_internal_disk" "vm_internal_disk" {
  count           = var.internal_disks != null ? length(var.internal_disks) : 0
  org             = var.vdc_org_name
  vdc             = var.vdc_name
  vapp_name       = data.vcd_vapp.vapp.name
  vm_name         = var.name
  bus_type        = try(var.internal_disks[count.index].bus_type, "paravirtual")
  size_in_mb      = var.internal_disks[count.index].size_in_mb
  bus_number      = var.internal_disks[count.index].bus_number
  unit_number     = var.internal_disks[count.index].unit_number
  iops            = try(var.internal_disks[count.index].iops, 0)
  allow_vm_reboot = try(var.internal_disks[count.index].allow_vm_reboot, false)
  storage_profile = try(var.internal_disks[count.index].storage_profile_name, var.storage_profile_name)
  depends_on      = [resource.vcd_vapp_vm.vapp_vm]
}
