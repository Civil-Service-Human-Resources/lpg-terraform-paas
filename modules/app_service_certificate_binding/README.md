# App Service certificate binding

This Terraform module is intended to set up an app service against a hosted DNS server in CSL.

The code in this module creates the following resources against a particular app service in Azure:
1. CNAME DNS record
2. Custom hostname entry (using the DNS record as validation)
3. Application certificate binding/reference

The app service must exist before running this module.