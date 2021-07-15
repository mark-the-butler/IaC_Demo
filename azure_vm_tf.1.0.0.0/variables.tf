variable "resource_group_name" {
  default = "#{Project.Azure.RG.Name}"
}

variable "vnet_name" {
  default = "#{Project.Azure.VNet.Name}"
}

variable "subnet_name" {
  default = "#{Project.Azure.Subnet.Name}"
}

variable "public_ip_name" {
  default = "#{Project.Azure.PublicIP.Name}"
}

variable "nic_name" {
  default = "#{Project.Azure.NIC.Name}"
}

variable "vm_name" {
  default = "#{Project.Azure.VM.Name}"
}

variable "vm_admin_username" {
  default = "#{Project.Azure.VM.Admin.Username}"
}

variable "vm_admin_password" {
  default = "#{Project.Azure.VM.Admin.Password}"
}