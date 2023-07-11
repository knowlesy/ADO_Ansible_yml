data "azurerm_public_ip" "pubip" {
  name                = azurerm_public_ip.ansible_publicip.name
  resource_group_name = azurerm_resource_group.rg.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "public_ip_address" {
  value = data.azurerm_public_ip.pubip.ip_address
}

output "password" {
  value     = "azurerm_key_vault_secret.key.value"
  sensitive = true
}

