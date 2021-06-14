###### test-rig ######

# virtual network
resource "azurerm_virtual_network" "test-rig-network" {
    name                = "${var.rg_prefix}-${var.rg_name}-${var.test_rig_net_name}"
    address_space       = [var.test_rig_net_address_space]
    location            = var.rg_location
    resource_group_name = var.rg_name
    tags = {
        environment = var.env_profile
    }
}

# subnet
resource "azurerm_subnet" "test-rig-network-subnet" {
    name                 = "${var.rg_prefix}-${var.rg_name}-${var.test_rig_subnet_name}"
    resource_group_name  = var.rg_name
    virtual_network_name = azurerm_virtual_network.test-rig-network.name
    address_prefix       = var.test_rig_subnet_prefix
}

# public ip
resource "azurerm_public_ip" "test-rig-publicip" {
    name                         = "${var.rg_prefix}-${var.rg_name}-${var.test_rig_publicip_name}"
    location                     = var.rg_location
    resource_group_name          = var.rg_name
    allocation_method            = "Dynamic"

    tags = {
        environment = var.env_profile
    }
}

# NSG
resource "azurerm_network_security_group" "test-rig-nsg" {
    name                = "${var.rg_prefix}-${var.rg_name}-${var.test_rig_nsg_name}"
    location            = var.rg_location
    resource_group_name = var.rg_name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefixes    = var.test_rig_ip_exceptions
        destination_address_prefix = "*"
    }

    tags = {
        environment = var.env_profile
    }
}

# network interface
resource "azurerm_network_interface" "test-rig-nic" {
    name                      = "${var.rg_prefix}-${var.rg_name}-${var.test_rig_nic_name}"
    location                  = var.rg_location
    resource_group_name       = var.rg_name

    ip_configuration {
        name                          = "${var.rg_prefix}-${var.rg_name}-${var.test_rig_ip_name}"
        subnet_id                     = azurerm_subnet.test-rig-network-subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.test-rig-publicip.id
    }

    tags = {
        environment = var.env_profile
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "test-rig-net-sg" {
    network_interface_id      = azurerm_network_interface.test-rig-nic.id
    network_security_group_id = azurerm_network_security_group.test-rig-nsg.id
}

# vm
resource "azurerm_linux_virtual_machine" "test-rig-vm" {
    name                  = "${var.rg_prefix}-${var.rg_name}-${var.test_rig_vm_name}"
    location              = var.rg_location
    resource_group_name   = var.rg_name
    network_interface_ids = [azurerm_network_interface.test-rig-nic.id]
    size                  = var.test_rig_vm_size

    os_disk {
        name              = "lpgperfOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = var.test_rig_vm_comp_name
    admin_username = var.test_rig_vm_username
    disable_password_authentication = true
    custom_data    = base64encode(file("azure-boot-data.sh"))
        
    admin_ssh_key {
        username       = var.test_rig_vm_username
        public_key     = var.test_rig_ssh_pub_key
    }

    tags = {
        environment = var.env_profile
    }
}