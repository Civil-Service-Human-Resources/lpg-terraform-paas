variable "rg_name" {
  default = "lpgperf"
}

variable "rg_prefix" {
  default = "lpg"
}

variable "rg_location" {
  default = "uksouth"
}

variable "test_rig_vm_size" {
  default = "Standard_D8as_v4" 
}

variable "test_rig_net_name" {
  default = "testrig-net"
}

variable "test_rig_subnet_name" {
  default = "testrig-subnet"
}

variable "test_rig_publicip_name" {
  default = "testrig-pubip"
}

variable "test_rig_nsg_name" {
  default = "testrig-nsg"
}

variable "test_rig_nic_name" {
  default = "testrig-nic"
}

variable "test_rig_ip_name" {
  default = "testrig-ip-name"
}

variable "test_rig_vm_name" {
  default = "testrig"
}

variable "env_profile" {
  default = "perf"
}
