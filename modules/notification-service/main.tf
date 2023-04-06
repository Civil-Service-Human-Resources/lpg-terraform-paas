###### notification-service ######

locals {
  allowed_ip_address_blocks = [for idx, ip in var.allowed_ip_addresses : {
	ipAddress = "${ip}/32"
	action = "Allow"
	tag = "Default"
	priority = 1
	name = "app service"
  }]
}

resource "azurerm_template_deployment" "notification-service-app-service" {
  name                = var.notification_service_name
  resource_group_name = var.rg_name

  template_body = <<DEPLOY
  {
     "$schema":"https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
     "contentVersion":"1.0.0.0",
     "parameters":{
        "siteName":{
           "type":"string",
           "defaultvalue":"${var.notification_service_name}",
           "metadata":{
              "description":"Name of azure web app"
           }
        },
		  "uaiId": {
				"defaultValue": "${var.app_managed_identity_id}",
				"type": "String"
			}
     },
     "variables":{
        "hostingPlanName":"[concat(parameters('siteName'), 'serviceplan')]"
     },
     "resources":[
        {
           "type":"Microsoft.Web/sites",
			"identity": {
				"type": "UserAssigned",
				"userAssignedIdentities": {
					"${var.app_managed_identity_id}": {}
				}
			},
           "name":"[parameters('siteName')]",
           "properties":{
              "siteConfig":{
                 "healthCheckPath": "/health"
              },
              "httpsOnly":true,
              "reserved":true,
              "name":"[parameters('siteName')]",
              "serverFarmId":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
			"keyVaultReferenceIdentity": "[parameters('uaiId')]"
           },
           "apiVersion":"2019-08-01",
           "location":"[resourceGroup().location]",
           "tags":{
              "environment":"${var.env_profile}"
           },
           "dependsOn":[
              "[variables('hostingPlanName')]"
           ]
        },
        {
           "apiVersion":"2019-08-01",
           "name":"[variables('hostingPlanName')]",
           "type":"Microsoft.Web/serverfarms",
           "location":"[resourceGroup().location]",
           "properties":{
               "name":"[variables('hostingPlanName')]",
               "workerTierName":null,
               "adminSiteName":null,
               "reserved":true,
               "kind":"linux",
               "perSiteScaling":false
           },
           "sku":{
              "Tier":"${var.webapp_sku_tier}",
              "Name":"${var.webapp_sku_name}",
              "capacity": "${var.notification_capacity}"
           }
        },
        {
           "type":"Microsoft.Web/sites/config",
           "name":"[concat(parameters('siteName'), '/web')]",
           "apiVersion":"2019-08-01",
           "location":"[resourceGroup().location]",
           "properties":{
              "httpLoggingEnabled":true,
              "logsDirectorySizeLimit":35,
              "detailedErrorLoggingEnabled":true,
              "alwaysOn":true,
              "appCommandLine":"${var.app_command_line}",
              "minTlsVersion":"1.2",
              "ftpsState":"Disabled",
			  "ipSecurityRestrictions": ${jsonencode(local.allowed_ip_address_blocks)}
           },
           "dependsOn":[
              "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
           ]
        }
     ]
  }
  DEPLOY

  deployment_mode = "Incremental"
}
