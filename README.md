# terraform-vcd-vapp-vm

Terraform module which manages vApp VM ressources on VMWare Cloud Director.

It can be used to create, modify, and delete VMs within a vApp. It can also attach internal disks to a VM.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.9 |
| <a name="requirement_vcd"></a> [vcd](#requirement\_vcd) | >= 3.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vcd"></a> [vcd](#provider\_vcd) | 3.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vcd_vapp_vm.vapp_vm](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/vapp_vm) | resource |
| [vcd_vm_internal_disk.vm_internal_disk](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/vm_internal_disk) | resource |
| [vcd_catalog.catalog](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/catalog) | data source |
| [vcd_catalog_vapp_template.catalog_vapp_template](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/catalog_vapp_template) | data source |
| [vcd_vapp.vapp](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/vapp) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpus"></a> [cpus](#input\_cpus) | The number of virtual CPUs to allocate to the VM. Socket count is a result of: virtual logical processors/cores per socket. If cpu\_hot\_add\_enabled is true, then cpus will be increased without VM power off. | `number` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of RAM (in MB) to allocate to the VM. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A name for the vApp VM. | `string` | n/a | yes |
| <a name="input_storage_profile_name"></a> [storage\_profile\_name](#input\_storage\_profile\_name) | Name of Storage Profile. | `string` | n/a | yes |
| <a name="input_vapp_name"></a> [vapp\_name](#input\_vapp\_name) | Name of vApp to put this VM into. | `string` | n/a | yes |
| <a name="input_vdc_org_name"></a> [vdc\_org\_name](#input\_vdc\_org\_name) | The name of the organization to use. | `string` | n/a | yes |
| <a name="input_accept_all_eulas"></a> [accept\_all\_eulas](#input\_accept\_all\_eulas) | Automatically accept EULA if OVA has it. | `bool` | `true` | no |
| <a name="input_boot_image_id"></a> [boot\_image\_id](#input\_boot\_image\_id) | Media URN to mount as boot image. | `string` | `null` | no |
| <a name="input_catalog_name"></a> [catalog\_name](#input\_catalog\_name) | Catalog where the vApp template is found. | `string` | `null` | no |
| <a name="input_catalog_org_name"></a> [catalog\_org\_name](#input\_catalog\_org\_name) | Name of Org where the Catalog is found if it is not in a catalog created by the same Org. | `string` | `null` | no |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | Computer name to assign to this virtual machine. | `string` | `null` | no |
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | The number of cores per socket. | `number` | `null` | no |
| <a name="input_cpu_hot_add_enabled"></a> [cpu\_hot\_add\_enabled](#input\_cpu\_hot\_add\_enabled) | True if the virtual machine supports addition of virtual CPUs while powered on. | `bool` | `false` | no |
| <a name="input_cpu_limit"></a> [cpu\_limit](#input\_cpu\_limit) | The limit (in MHz) for how much of CPU can be consumed on the underlying virtualization infrastructure. -1 value for unlimited. | `number` | `null` | no |
| <a name="input_cpu_priority"></a> [cpu\_priority](#input\_cpu\_priority) | Pre-determined relative priorities according to which the non-reserved portion of this resource is made available to the virtualized workload. | `string` | `null` | no |
| <a name="input_cpu_reservation"></a> [cpu\_reservation](#input\_cpu\_reservation) | The amount of MHz reservation on the underlying virtualization infrastructure. | `number` | `null` | no |
| <a name="input_cpu_shares"></a> [cpu\_shares](#input\_cpu\_shares) | Custom priority for the resource in MHz. This is a read-only, unless the cpu\_priority is 'CUSTOM'. | `number` | `null` | no |
| <a name="input_customization"></a> [customization](#input\_customization) | A block to define for guest customization options. | `any` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | The VM description. Note: for VM from Template description is read only. Currently, this field has the description of the OVA used to create the VM. | `string` | `null` | no |
| <a name="input_disks"></a> [disks](#input\_disks) | List of disks per virtual machine. | <pre>list(object({<br>    name        = string<br>    bus_number  = number<br>    unit_number = number<br>  }))</pre> | `[]` | no |
| <a name="input_expose_hardware_virtualization"></a> [expose\_hardware\_virtualization](#input\_expose\_hardware\_virtualization) | Boolean for exposing full CPU virtualization to the guest operating system so that applications that require hardware virtualization can run on virtual machines without binary translation or paravirtualization. Useful for hypervisor nesting provided underlying hardware supports it. | `bool` | `false` | no |
| <a name="input_guest_properties"></a> [guest\_properties](#input\_guest\_properties) | Key value map of guest properties. | `map(any)` | `null` | no |
| <a name="input_hardware_version"></a> [hardware\_version](#input\_hardware\_version) | Virtual Hardware Version (e.g.vmx-14, vmx-13, vmx-12, etc.). Required when creating empty VM. | `string` | `null` | no |
| <a name="input_internal_disks"></a> [internal\_disks](#input\_internal\_disks) | A list of internal disks to add to this machine. | <pre>list(object({<br>    size_in_mb           = number<br>    bus_type             = optional(string)<br>    bus_number           = number<br>    unit_number          = number<br>    storage_profile_name = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_memory_hot_add_enabled"></a> [memory\_hot\_add\_enabled](#input\_memory\_hot\_add\_enabled) | True if the virtual machine supports addition of memory while powered on. | `bool` | `false` | no |
| <a name="input_memory_limit"></a> [memory\_limit](#input\_memory\_limit) | The limit (in MB) for how much of memory can be consumed on the underlying virtualization infrastructure. -1 value for unlimited. | `number` | `null` | no |
| <a name="input_memory_priority"></a> [memory\_priority](#input\_memory\_priority) | Pre-determined relative priorities according to which the non-reserved portion of this resource is made available to the virtualized workload. | `string` | `null` | no |
| <a name="input_memory_reservation"></a> [memory\_reservation](#input\_memory\_reservation) | The amount of RAM (in MB) reservation on the underlying virtualization infrastructure. | `number` | `null` | no |
| <a name="input_memory_shares"></a> [memory\_shares](#input\_memory\_shares) | Custom priority for the resource in MB. This is a read-only, unless the memory\_priority is 'CUSTOM'. | `number` | `null` | no |
| <a name="input_metadata_entry"></a> [metadata\_entry](#input\_metadata\_entry) | A set of metadata entries to assign. | `list(map(string))` | `[]` | no |
| <a name="input_network"></a> [network](#input\_network) | A block to define network interfaces. | `any` | `[]` | no |
| <a name="input_network_dhcp_wait_seconds"></a> [network\_dhcp\_wait\_seconds](#input\_network\_dhcp\_wait\_seconds) | Number of seconds to try and wait for DHCP IP. | `number` | `null` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Operating System type. Possible values can be found in Os Types. Required when creating empty VM. | `string` | `null` | no |
| <a name="input_override_template_disks"></a> [override\_template\_disks](#input\_override\_template\_disks) | A list of disks to override in the vApp template. | <pre>list(object({<br>    bus_type        = string<br>    size_in_mb      = number<br>    bus_number      = number<br>    unit_number     = number<br>    iops            = optional(number)<br>    storage_profile = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_placement_policy_id"></a> [placement\_policy\_id](#input\_placement\_policy\_id) | VM placement policy ID. To be used, it needs to be assigned to Org VDC using vcd\_org\_vdc.vm\_placement\_policy\_ids (and optionally vcd\_org\_vdc.default\_compute\_policy\_id to make it default). In this case, if the placement policy is not set, it will pick the VDC default on creation. It must be set explicitly if one wants to update it to another policy (the VM requires at least one Compute Policy), and needs to be set to '' to be removed. | `string` | `null` | no |
| <a name="input_power_on"></a> [power\_on](#input\_power\_on) | A boolean value stating if this VM should be powered on. | `bool` | `true` | no |
| <a name="input_prevent_update_power_off"></a> [prevent\_update\_power\_off](#input\_prevent\_update\_power\_off) | True if the virtual machine supports addition of virtual CPUs while powered on. | `bool` | `false` | no |
| <a name="input_security_tags"></a> [security\_tags](#input\_security\_tags) | Set of security tags to be managed by the vcd\_vapp\_vm resource. | `set(string)` | `null` | no |
| <a name="input_sizing_policy_id"></a> [sizing\_policy\_id](#input\_sizing\_policy\_id) | (vCD 10.0+) VM sizing policy ID. To be used, it needs to be assigned to Org VDC using vcd\_org\_vdc.vm\_sizing\_policy\_ids (and vcd\_org\_vdc.default\_compute\_policy\_id to make it default). In this case, if the sizing policy is not set, it will pick the VDC default on creation. It must be set explicitly if one wants to update it to another policy (the VM requires at least one Compute Policy), and needs to be set to '' to be removed. | `string` | `null` | no |
| <a name="input_vapp_template_name"></a> [vapp\_template\_name](#input\_vapp\_template\_name) | vApp template for this maschine. | `string` | `null` | no |
| <a name="input_vdc_name"></a> [vdc\_name](#input\_vdc\_name) | The name of VDC to use. | `string` | `null` | no |
| <a name="input_vm_name_in_template"></a> [vm\_name\_in\_template](#input\_vm\_name\_in\_template) | The name of the VM in vApp Template to use. For cases when vApp template has more than one VM. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the vApp VM. |
| <a name="output_ip"></a> [ip](#output\_ip) | The IP's of the vApp VM. |
<!-- END_TF_DOCS -->

## Examples

```
module "vcd_vapp_vm" {
  source               = "git::https://github.com/noris-network/terraform-vcd-vapp-vm?ref=1.0.0"
  name                 = "web01.example.net"
  vdc_org_name         = "myORG"
  vdc_name             = "myDC01"
  vapp_name            = "webserver"
  cpus                 = 2
  catalog_name         = "myCatalog"
  vapp_template_name   = "debian12"
  memory               = (1024*4)
  storage_profile_name = "myDatastorePolicy"
  internal_disks       = [
    {
      size_in_mb  = (1024 * 16)
      bus_type    = "sas"
      bus_number  = 0
      unit_number = 1
    }
]
  network = {
    "TEST-NET" = {
      ip_allocation_mode = "MANUAL"
      ip                 = "192.168.0.10"
      is_primary         = true
    },
    "TEST-NET2" = {
      ip_allocation_mode = "POOL"
    }
  }
  guest_properties = {
    "user-data" = base64encode(templatefile("./templates/cloudinit.yaml", {
      hostname     = "web01.example.net"
      eth0_ip      = "192.168.0.10",
      eth0_netmask = "24"
      eth0_gateway = "192.168.0.1"
    }))
  }
  customization = { enabled = true }
}
```

### Cloud Init Template

```
#cloud-config

hostname: ${hostname}
users:
  - name: testuser
    ssh-authorized-keys:
    - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEc7+easbd9qfpyP1qaAvuFVMGqiKmAulEHS/VDEK3LFrRYLC test.user@example.de
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash
    lock_passwd: false
network:
  version: 2
  ethernets:
    eth0:
      addresses:
        - ${eth0_ip}/${eth0_netmask}
      gateway4: ${eth0_gateway}
      nameservers:
        search: []
        addresses: [8.8.8.8]
```
