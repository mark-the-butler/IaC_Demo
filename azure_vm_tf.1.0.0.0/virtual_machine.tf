// Get existing resource group data
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

// Get existing virtual network data
data "azurerm_virtual_network" "vnet" {
  name = var.vnet_name 
  resource_group_name = data.azurerm_resource_group.rg.name
}

// Get existing subnet data
data "azurerm_subnet" "default_subnet" {
    name = var.subnet_name
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name = data.azurerm_resource_group.rg.name
}

// Create public ip address for vm
resource "azurerm_public_ip" "vm_public_ip" {
  name = var.public_ip_name 
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  allocation_method = "Dynamic"
}

// Create network interface for vm
resource "azurerm_network_interface" "default_nic" {
  name = var.nic_name
  location = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name = data.azurerm_subnet.default_subnet.name
    subnet_id = data.azurerm_subnet.default_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_public_ip.id
  }
}

// Create windows vm
resource "azurerm_windows_virtual_machine" "windows_vm" {
  name = var.vm_name 
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  size = "Standard_B2s"
  admin_username = var.vm_admin_username
  admin_password = var.vm_admin_password
  network_interface_ids = [ 
      azurerm_network_interface.default_nic.id
   ]

   os_disk {
     caching = "ReadWrite"
     storage_account_type = "Standard_LRS"
   }

   source_image_reference {
     publisher = "MicrosoftWindowsServer"
     offer     = "WindowsServer"
     sku       = "2019-Datacenter"
     version   = "latest"
   }
}

output "vm_public_ip" {
  value = azurerm_windows_virtual_machine.windows_vm.public_ip_address
}