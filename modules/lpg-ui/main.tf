###### lpg-ui ######

resource "azurerm_template_deployment" "lpg-ui-app-service" {
  name                = "${var.lpg_ui_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
{
  "$schema": "http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "siteName": {
      "type": "string",
      "defaultvalue": "${var.lpg_ui_name}",
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
      "defaultvalue": "${var.envurl}lpg",
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
        "Name": "S1"
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
              "name": "WEBSITES_ENABLE_APP_SERVICE_STORAGE",
              "value": "false"
            },
            {
              "name": "AUTHENTICATION_SERVICE_URL",
              "value": "${var.authentication_service_url}"
            },
            {
              "name": "AZURE_STORAGE_CONNECTION_STRING",
              "value": "${var.azure_storage_connection_string}"
            },
            {
              "name": "GOOGLE_ANALYTICS_ID",
              "value": "${var.google_analytics_id}"
            },
            {
              "name": "GOV_NOTIFY_API_KEY",
              "value": "${var.gov_notify_api_key}"
            },
            {
              "name": "LEARNER_RECORD_URL",
              "value": "${var.learner_record_url}"
            },
            {
              "name": "COURSE_CATALOGUE_URL",
              "value": "${var.course_catalogue_url}"
            },
            {
              "name": "COURSE_CATALOGUE_USER",
              "value": "${var.course_catalogue_user}"
            },
            {
              "name": "COURSE_CATALOGUE_PASS",
              "value": "${var.course_catalogue_pass}"
            },
            {
              "name": "XAPI_URL",
              "value": "${var.xapi_url}"
            },
            {
              "name": "YOUTUBE_API_KEY",
              "value": "${var.youtube_api_key}"
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
              "name": "WEBSITES_PORT",
              "value": "${var.websites_port}"
            },
            {
              "name": "HAMMER_WORKING_DIRECTORY",
              "value": "${var.hammer_working_directory}"
            },
            {
              "name": "SESSION_SECRET",
              "value": "${var.session_secret}"
            },
            {
              "name": "CONTENT_URL",
              "value": "${var.content_url}"
            },
            {
              "name": "DOCKER_ENABLE_CI",
              "value": "true"
            },
            {
              "name": "REGISTRY_SERVICE_URL",
              "value": "${var.registry_service_url}"
            },
            {
              "name": "LPG_UI_SERVER",
              "value": "${var.lpg_ui_server}"
            },
            {
              "name": "OAUTH_CLIENT_ID",
              "value": "${var.lpg_ui_oauth_client_id}"
            },
            {
              "name": "OAUTH_CLIENT_SECRET",
              "value": "${var.lpg_ui_oauth_client_secret}"
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
        "[variables('hostingPlanName')]"
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
        "appCommandLine": "/bin/hammer node ../node_modules/ui/server.js",
        "linuxFxVersion": "DOCKER|${var.docker_image}:${var.docker_tag}",
        "minTlsVersion": "1.0",
        "ftpsState": "Disabled"
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
  ]
}
  DEPLOY

  deployment_mode = "Incremental"
}
