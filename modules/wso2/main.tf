###### wso2 ######

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

resource "azurerm_template_deployment" "wso2-app-service" {
  name                = "${var.wso2_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
{
  "$schema": "http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "siteName": {
      "type": "string",
      "defaultvalue": "${var.wso2_name}",
      "metadata": {
        "description": "Name of azure web app"
      }
    },
    "vaultResourceGroup": {
      "type": "string",
      "defaultvalue": "${var.vaultresourcegroup}"
    },
    "vaultName": {
      "type": "string",
      "defaultvalue": "${var.vaultname}"
    },
    "existingKeyVaultId": {
      "type": "string",
      "defaultvalue": "[resourceId(subscription().subscriptionId,  parameters('vaultResourceGroup'), 'Microsoft.KeyVault/vaults', parameters('vaultName'))]",
      "metadata": {
        "description": "Existing Key Vault resource Id with an access policy to allow Microsoft.Web RP to read Key Vault secrets (Checkout README.md for more information)"
      }
    },
    "existingKeyVaultSecretName": {
      "type": "string",
      "defaultvalue": "${var.existingkeyvaultsecretname}",
      "metadata": {
        "description": "Key Vault Secret that contains a PFX certificate"
      }
    },
    "certificateName": {
      "type": "string",
      "defaultvalue": "${var.certificatename}",
      "metadata": {
        "description": "User friendly certificate resource name"
      }
    },
    "websiteCustomDomain": {
      "type": "string",
      "defaultvalue": "cshr.digital",
      "metadata": {
        "description": "Custom domain for creating SSL binding."
      }
    },
    "websiteCustomName": {
      "type": "string",
      "defaultvalue": "localtest-identity",
      "metadata": {
        "description": "Custom hostname for creating SSL binding."
      }
    }
  },
  "variables": {
    "hostingPlanName": "[concat(parameters('siteName'), 'serviceplan')]"
  },
  "resources": [
    {
      "type": "Microsoft.Web/certificates",
      "name": "[parameters('certificateName')]",
      "apiVersion": "2016-03-01",
      "location": "[resourceGroup().location]",
      "properties": {
        "keyVaultId": "[parameters('existingKeyVaultId')]",
        "keyVaultSecretName": "[parameters('existingKeyVaultSecretName')]",
        "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
      },
      "dependsOn": [
        "[variables('hostingPlanName')]"
      ]
    },
    {
      "apiVersion": "2016-09-01",
      "name": "[variables('hostingPlanName')]",
      "type": "Microsoft.Web/serverfarms",
      "location": "[resourceGroup().location]",
      "properties": {
        "name": "[variables('hostingPlanName')]",
        "workerSizeId": "1",
        "reserved": true,
        "numberOfWorkers": "1",
        "hostingEnvironment": ""
      },
      "sku": {
        "Tier": "Standard",
        "Name": "S3"
      },
      "kind": "linux"
    },
    {
      "type": "Microsoft.Web/sites",
      "name": "[parameters('siteName')]",
      "properties": {
        "siteConfig": {
          "appSettings": [
            {
              "name": "DOCKER_CUSTOM_IMAGE_NAME",
              "value": "${var.docker_image}:${var.docker_tag}"
            },
            {
              "name": "WEBSITES_ENABLE_APP_SERVICE_STORAGE",
              "value": "false"
            },
            {
              "name": "DATABASE_URL",
              "value": "${var.database_url}"
            },
            {
              "name": "CARBON_PROTOCOL",
              "value": "${var.carbon_protocol}"
            },
            {
              "name": "WEBSITES_PORT",
              "value": "${var.websites_port}"
            },
            {
              "name": "WEBSITES_CONTAINER_START_TIME_LIMIT",
              "value": "600"
            },
            {
              "name": "HAMMER_LOGSTASH_HOST",
              "value": "${var.hammer_logstash_host}"
            },
            {
              "name": "HAMMER_LOGSTASH_PORT",
              "value": "${var.hammer_logstash_port}"
            },
            {
              "name": "ENV_PROFILE",
              "value": "${var.env_profile}"
            },
            {
              "name": "LPG_UI_URL",
              "value": "${var.lpg_ui_url}"
            },
            {
              "name": "LPG_MANAGEMENT_UI_URL",
              "value": "${var.lpg_management_ui_url}"
            }
          ]
        },
        "httpsOnly": true,
        "name": "[parameters('siteName')]",
        "serverFarmId": "[variables('hostingPlanName')]",
        "hostingEnvironment": "",
        "hostNameSslStates": [
          {
            "name": "[concat(parameters('websiteCustomName'),'.',parameters('websiteCustomDomain'))]",
            "sslState": "SniEnabled",
            "thumbprint": "[reference(resourceId('Microsoft.Web/certificates', parameters('certificateName'))).Thumbprint]",
            "toUpdate": true,
            "hostType": "Standard"
          },
          {
            "name": "[concat(parameters('siteName'),'.azurewebsites.net')]",
            "sslState": "Disabled",
            "thumbprint": null,
            "toUpdate": true,
            "hostType": "Standard"
          },
          {
            "name": "[concat(parameters('siteName'),'.scm.azurewebsites.net')]",
            "sslState": "Disabled",
            "thumbprint": null,
            "toUpdate": true,
            "hostType": "Standard"
          }
        ]
      },
      "apiVersion": "2016-03-01",
      "location": "[resourceGroup().location]",
      "tags": {
        "environment": "${var.env_profile}"
      },
      "dependsOn": [
        "[variables('hostingPlanName')]",
        "[resourceId('Microsoft.Web/certificates', parameters('certificateName'))]"
      ]
    },
    {
      "type": "Microsoft.Web/sites/config",
      "name": "[concat(parameters('siteName'), '/web')]",
      "apiVersion": "2016-08-01",
      "location": "UK South",
      "scale": null,
      "properties": {
        "httpLoggingEnabled": true,
        "logsDirectorySizeLimit": 35,
        "detailedErrorLoggingEnabled": true,
        "alwaysOn": true,
        "appCommandLine": "/bin/hammer bin/wso2server.sh"
      },
      "dependsOn": [
        "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
      ]
    },
    {
        "type": "Microsoft.Web/sites/hostNameBindings",
        "name": "[concat(parameters('sitename'), '/', parameters('sitename'), '.azurewebsites.net')]",
        "apiVersion": "2016-08-01",
        "location": "UK South",
        "scale": null,
        "properties": {
            "siteName": "[parameters('sitename')]",
            "domainId": null,
            "hostNameType": "Verified"
        },
        "dependsOn": [
            "[resourceId('Microsoft.Web/sites', parameters('sitename'))]"
        ]
    },
    {
        "type": "Microsoft.Web/sites/hostNameBindings",
        "name": "[concat(parameters('sitename'), '/', parameters('websiteCustomName'), '.', parameters('websiteCustomDomain'))]",
        "apiVersion": "2016-08-01",
        "location": "UK South",
        "scale": null,
        "properties": {
            "siteName": "[parameters('sitename')]",
            "domainId": null,
            "hostNameType": "Verified",
            "sslState": "SniEnabled",
            "thumbprint": "[reference(resourceId('Microsoft.Web/certificates', parameters('certificateName'))).Thumbprint]"
       },
        "dependsOn": [
            "[resourceId('Microsoft.Web/sites', parameters('sitename'))]"
        ]
    }
  ],
  "outputs": {
    "wso2_ip_addresses": {
      "type": "String",
      "value": "[reference(parameters('siteName')).outboundIpAddresses]"
    }
  }
}  DEPLOY

  deployment_mode = "Incremental"
  depends_on      = ["azurerm_resource_group.rg"]
}

output "wso2_ip" {
  value = "${azurerm_template_deployment.wso2-app-service.outputs["wso2_ip_addresses"]}"
}
