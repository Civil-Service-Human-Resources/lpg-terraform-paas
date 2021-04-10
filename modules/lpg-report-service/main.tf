###### lpg-report-service ######

resource "azurerm_template_deployment" "lpg-report-service-app-service" {
  name                = var.lpg_report_service_name
  resource_group_name = var.rg_name

  template_body = <<DEPLOY
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "siteName": {
      "type": "string",
      "defaultvalue": "${var.lpg_report_service_name}",
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
      "defaultvalue": "${var.domain}",
      "metadata": {
        "description": "Custom domain for creating SSL binding."
      }
    },
    "websiteCustomName": {
      "type": "string",
      "defaultvalue": "${var.envurl}report",
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
      "apiVersion": "2019-08-01",
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
      "apiVersion": "2019-08-01",
      "name": "[variables('hostingPlanName')]",
      "type": "Microsoft.Web/serverfarms",
      "location": "[resourceGroup().location]",
      "properties": {
        "name": "[variables('hostingPlanName')]",
        "workerTierName": null,
        "adminSiteName": null,
        "reserved": true,
        "kind":" linux",
        "perSiteScaling": false
      },
      "sku": {
        "Tier": "${var.webapp_sku_tier}",
        "Name": "${var.webapp_sku_name}"
      }
    },
    {
      "type": "Microsoft.Web/sites",
      "name": "[parameters('siteName')]",
      "properties": {
        "siteConfig": {
          "appSettings": [
            {
                "name": "WEBSITES_ENABLE_APP_SERVICE_STORAGE",
                "value": "false"
            },
            {
                "name":"APPINSIGHTS_INSTRUMENTATIONKEY",
                "value":"${var.ai_instrument_key}"
            },
            {
                "name": "LEARNER_RECORD_URL",
                "value": "${var.learner_record_url}"
            },
            {
                "name": "OAUTH_SERVICE_URL",
                "value": "${var.authentication_service_url}"
            },
            {
                "name": "REGISTRY_SERVICE_URL",
                "value": "${var.registry_service_url}"
            },
            {
                "name": "LEARNING_CATALOGUE_SERVICE_URL",
                "value": "${var.course_catalogue_url}"
            },
            {
                "name": "CLIENT_ID",
                "value": "${var.report_service_client_id}"
            },
            {
                "name": "CLIENT_SECRET",
                "value": "${var.report_service_client_secret}"
            },
            {
                "name": "WEBSITES_PORT",
                "value": "${var.websites_port}"
            },
            {
                "name": "ENV_PROFILE",
                "value": "${var.env_profile}"
            },
            {
                "name": "DOCKER_ENABLE_CI",
                "value": "true"
            },
            {
              "name": "DOCKER_REGISTRY_SERVER_URL",
              "value": "https://${var.docker_registry_server_url}"
            },
            {
              "name": "DOCKER_REGISTRY_SERVER_USERNAME",
              "value": "${var.docker_registry_server_username}"
            },
            {
              "name": "DOCKER_REGISTRY_SERVER_PASSWORD",
              "value": "${var.docker_registry_server_password}"
            },
            {
                "name":"DATASOURCE",
                "value":"${var.datasource}"
            },
            {
                "name": "JWT_KEY",
                "value": "${var.jwt_key}"
            }
          ]
        },
        "httpsOnly": true,
        "reserved": true,
        "name": "[parameters('siteName')]",
        "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
        "hostNameSslStates": [
          {
            "name": "[concat(parameters('websiteCustomName'),'.',parameters('websiteCustomDomain'))]",
            "sslState": "SniEnabled",
            "thumbprint": "[reference(resourceId('Microsoft.Web/certificates', parameters('certificateName'))).Thumbprint]",
            "toUpdate": true,
            "hostType": "Standard"
          }
        ]
      },
      "apiVersion": "2019-08-01",
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
      "apiVersion": "2019-08-01",
      "location": "[resourceGroup().location]",
      "properties": {
        "httpLoggingEnabled": true,
        "logsDirectorySizeLimit": 35,
        "detailedErrorLoggingEnabled": true,
        "alwaysOn": true,
        "appCommandLine": "${var.report_service_command_line}",
        "linuxFxVersion": "DOCKER|${var.docker_registry_server_url}/${var.docker_image}:${var.docker_tag}",
        "minTlsVersion": "1.2",
        "ftpsState": "Disabled"
      },
      "dependsOn": [
        "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
      ]
    },
    {
        "type": "Microsoft.Web/sites/hostNameBindings",
        "name": "[concat(parameters('sitename'), '/', parameters('websiteCustomName'), '.', parameters('websiteCustomDomain'))]",
        "apiVersion": "2019-08-01",
        "location": "[resourceGroup().location]",
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
  ]
}
  DEPLOY

  deployment_mode = "Incremental"
}
