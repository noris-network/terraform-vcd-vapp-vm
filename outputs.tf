output "id" {
  description = "The ID of the vApp VM."
  value       = vcd_vapp_vm.vapp_vm.id
}

output "ip" {
  description = "The IP's of the vApp VM."
  value       = try(vcd_vapp_vm.vapp_vm.network[*].ip, null)
}
