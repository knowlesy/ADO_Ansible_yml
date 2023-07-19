output "azurerm_public_ip" {
  value = azurerm_network_interface.windows_nic.private_ip_address
}
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
output "admin_username" {
  value = azurerm_windows_virtual_machine.test_machine.admin_username
}
output "password_not_hidden" {
  value = nonsensitive(azurerm_key_vault_secret.key.value)
}
output "windows_local_ip" {
  value = azurerm_network_interface.windows_nic.private_ip_address
}
