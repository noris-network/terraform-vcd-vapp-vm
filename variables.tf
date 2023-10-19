variable "name" {
  description = "A name for the vApp VM."
  type        = string
}

variable "description" {
  description = "The VM description. Note: for VM from Template description is read only. Currently, this field has the description of the OVA used to create the VM."
  type        = string
  default     = null
}

variable "computer_name" {
  description = "Computer name to assign to this virtual machine."
  type        = string
  default     = null
}

variable "vdc_org_name" {
  description = "The name of the organization to use."
  type        = string
}

variable "vdc_name" {
  description = "The name of VDC to use."
  type        = string
  default     = null
}

variable "cpus" {
  description = "The number of virtual CPUs to allocate to the VM. Socket count is a result of: virtual logical processors/cores per socket. If cpu_hot_add_enabled is true, then cpus will be increased without VM power off."
  type        = number
}

variable "cpu_cores" {
  description = "The number of cores per socket."
  type        = number
  default     = null
}

variable "cpu_hot_add_enabled" {
  description = "True if the virtual machine supports addition of virtual CPUs while powered on."
  type        = bool
  default     = false
}

variable "cpu_reservation" {
  description = "The amount of MHz reservation on the underlying virtualization infrastructure."
  type        = number
  default     = null
}

variable "cpu_priority" {
  description = "Pre-determined relative priorities according to which the non-reserved portion of this resource is made available to the virtualized workload."
  type        = string
  default     = null
}

variable "cpu_shares" {
  description = "Custom priority for the resource in MHz. This is a read-only, unless the cpu_priority is 'CUSTOM'."
  type        = number
  default     = null
}

variable "cpu_limit" {
  description = "The limit (in MHz) for how much of CPU can be consumed on the underlying virtualization infrastructure. -1 value for unlimited."
  type        = number
  default     = null
}

variable "vm_name_in_template" {
  description = "The name of the VM in vApp Template to use. For cases when vApp template has more than one VM."
  type        = string
  default     = null
}

variable "memory" {
  description = "The amount of RAM (in MB) to allocate to the VM."
  type        = number
}

variable "memory_hot_add_enabled" {
  description = "True if the virtual machine supports addition of memory while powered on."
  type        = bool
  default     = false
}

variable "memory_reservation" {
  description = "The amount of RAM (in MB) reservation on the underlying virtualization infrastructure."
  type        = number
  default     = null
}

variable "memory_priority" {
  description = "Pre-determined relative priorities according to which the non-reserved portion of this resource is made available to the virtualized workload."
  type        = string
  default     = null
}

variable "memory_shares" {
  description = "Custom priority for the resource in MB. This is a read-only, unless the memory_priority is 'CUSTOM'."
  type        = number
  default     = null
}

variable "memory_limit" {
  description = "The limit (in MB) for how much of memory can be consumed on the underlying virtualization infrastructure. -1 value for unlimited."
  type        = number
  default     = null
}

variable "os_type" {
  description = "Operating System type. Possible values can be found in Os Types. Required when creating empty VM."
  type        = string
  default     = null
}

variable "hardware_version" {
  description = "Virtual Hardware Version (e.g.vmx-14, vmx-13, vmx-12, etc.). Required when creating empty VM."
  type        = string
  default     = null
}

variable "network" {
  description = "A block to define network interfaces."
  type        = any
  default     = []
}

variable "customization" {
  description = "A block to define for guest customization options."
  type        = any
  default     = null
}

variable "guest_properties" {
  description = "Key value map of guest properties."
  type        = map(any)
  default     = null
}

variable "metadata_entry" {
  description = "A set of metadata entries to assign."
  type        = list(map(string))
  default     = []
}

variable "power_on" {
  description = "A boolean value stating if this VM should be powered on."
  type        = bool
  default     = true
}

variable "accept_all_eulas" {
  description = "Automatically accept EULA if OVA has it."
  type        = bool
  default     = true
}

variable "expose_hardware_virtualization" {
  description = "Boolean for exposing full CPU virtualization to the guest operating system so that applications that require hardware virtualization can run on virtual machines without binary translation or paravirtualization. Useful for hypervisor nesting provided underlying hardware supports it."
  type        = bool
  default     = false
}

variable "network_dhcp_wait_seconds" {
  description = "Number of seconds to try and wait for DHCP IP."
  type        = number
  default     = null
}

variable "boot_image_id" {
  description = "Media URN to mount as boot image."
  type        = string
  default     = null
}

variable "prevent_update_power_off" {
  description = "True if the virtual machine supports addition of virtual CPUs while powered on."
  type        = bool
  default     = false
}

variable "placement_policy_id" {
  description = "VM placement policy ID. To be used, it needs to be assigned to Org VDC using vcd_org_vdc.vm_placement_policy_ids (and optionally vcd_org_vdc.default_compute_policy_id to make it default). In this case, if the placement policy is not set, it will pick the VDC default on creation. It must be set explicitly if one wants to update it to another policy (the VM requires at least one Compute Policy), and needs to be set to '' to be removed."
  type        = string
  default     = null
}

variable "sizing_policy_id" {
  description = "(vCD 10.0+) VM sizing policy ID. To be used, it needs to be assigned to Org VDC using vcd_org_vdc.vm_sizing_policy_ids (and vcd_org_vdc.default_compute_policy_id to make it default). In this case, if the sizing policy is not set, it will pick the VDC default on creation. It must be set explicitly if one wants to update it to another policy (the VM requires at least one Compute Policy), and needs to be set to '' to be removed."
  type        = string
  default     = null
}

variable "security_tags" {
  description = "Set of security tags to be managed by the vcd_vapp_vm resource."
  type        = set(string)
  default     = null
}

variable "storage_profile_name" {
  description = "Name of Storage Profile."
  type        = string
}

variable "disks" {
  description = "List of disks per virtual machine."
  type = list(object({
    name        = string
    bus_number  = number
    unit_number = number
  }))
  default = []
}

variable "override_template_disks" {
  description = "A list of disks to override in the vApp template."
  type = list(object({
    bus_type        = string
    size_in_mb      = number
    bus_number      = number
    unit_number     = number
    iops            = optional(number)
    storage_profile = optional(string)
  }))
  default = []
}

variable "catalog_name" {
  description = "Catalog where the vApp template is found."
  type        = string
  default     = null
}

variable "vapp_template_name" {
  description = "vApp template for this maschine."
  type        = string
  default     = null
}

variable "vapp_name" {
  description = "Name of vApp to put this VM into."
  type        = string
}

variable "internal_disks" {
  description = "A list of internal disks to add to this machine."
  type = list(object({
    size_in_mb  = number
    bus_type    = string
    bus_number  = number
    unit_number = number
  }))
  default = []
}
