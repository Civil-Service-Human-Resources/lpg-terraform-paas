###### lpg-learning-catalogue ######

resource "azurerm_template_deployment" "lpg-learning-catalogue-app-service" {
  name                = "${var.lpg_learning_catalogue_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
{
  "$schema": "http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "siteName": {
      "type": "string",
      "defaultvalue": "${var.lpg_learning_catalogue_name}",
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
      "defaultvalue": "${var.envurl}learning-resources",
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
              "name": "WEBSITES_ENABLE_APP_SERVICE_STORAGE",
              "value": "false"
            },
            {
              "name": "AUTH_USER",
              "value": "${var.auth_user}"
            },
            {
              "name": "AUTH_PASSWORD",
              "value": "${var.auth_password}"
            },
            {
              "name": "ELASTICSEARCH_URI",
              "value": "${var.elasticsearch_uri}"
            },
            {
              "name": "ELASTICSEARCH_USERNAME",
              "value": "${var.elasticsearch_user}"
            },
            {
              "name": "ELASTICSEARCH_PASSWORD",
              "value": "${var.elasticsearch_password}"
            },
            {
              "name": "WEBSITES_PORT",
              "value": "${var.websites_port}"
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
              "name": "DOCKER_ENABLE_CI",
              "value": "true"
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
        "appCommandLine": "/bin/hammer java -jar /data/app.jar",
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
