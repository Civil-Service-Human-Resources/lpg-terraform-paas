# Instructions

This module is not included in the environments/master/main.tf file due to not being able to selectively include modules in terraform at the time of writing - conditional statements do not work for modules.

This module needs to be run independently from within this directory.

This will deploy into a single resource group, *lpgperf* by default.

## Components created

The following are created by this:

* Virtual Network
* Subnet
* Public IP
* Network Security Group
* Network Interface
* Virtual Machine

## Accessing the VM

Access is via the ssh key within Keybase.

Your IP also needs to be allowed access in the NSG.
