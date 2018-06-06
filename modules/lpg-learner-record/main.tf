###### lpg-learner-record ######

resource "azurerm_template_deployment" "lpg-learner-record-app-service" {
  name                = "${var.lpg_learner_record_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
{
  "$schema": "http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "siteName": {
      "type": "string",
      "defaultvalue": "${var.lpg_learner_record_name}",
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
      "defaultvalue": "${var.envurl}learning-record",
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
              "name": "OAUTH_SERVICE_URL",
              "value": "${var.authentication_service_url}"
            },
            {
              "name": "CLIENT_ID",
              "value": "${var.learner_record_client_id}"
            },
            {
              "name": "CLIENT_SECRET",
              "value": "${var.learner_record_client_secret}"
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
              "name": "LEARNING_CATALOGUE_USERNAME",
              "value": "${var.course_catalogue_user}"
            },
            {
              "name": "LEARNING_CATALOGUE_PASSWORD",
              "value": "${var.course_catalogue_pass}"
            },
            {
              "name": "GOV_NOTIFY_API_KEY",
              "value": "${var.gov_notify_api_key}"
            },
            {
              "name": "GOV_NOTIFY_REQUIRED_LEARNING_DUE_TEMPLATE_ID",
              "value": "${var.required_learning_template_id}"
            },
            {
              "name": "XAPI_URL",
              "value": "${var.xapi_url}"
            },
            {
              "name": "XAPI_USERNAME",
              "value": "${var.xapi_username}"
            },
            {
              "name": "XAPI_PASSWORD",
              "value": "${var.xapi_password}"
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
                              "name": "SPRING_PROFILES_ACTIVE",
                              "value": "${var.spring_profiles_active}"
                          },
                          {
                              "name": "OAUTH_SERVICE_URL",
                              "value": "${var.authentication_service_url}"
                          },
                          {
                              "name": "CLIENT_ID",
                              "value": "${var.learner_record_client_id}"
                          },
                          {
                              "name": "CLIENT_SECRET",
                              "value": "${var.learner_record_client_secret}"
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
                              "name": "LEARNING_CATALOGUE_USERNAME",
                              "value": "${var.course_catalogue_user}"
                          },
                          {
                              "name": "LEARNING_CATALOGUE_PASSWORD",
                              "value": "${var.course_catalogue_pass}"
                          },
                          {
                              "name": "GOV_NOTIFY_API_KEY",
                              "value": "${var.gov_notify_api_key}"
                          },
                          {
                              "name": "GOV_NOTIFY_REQUIRED_LEARNING_DUE_TEMPLATE_ID",
                              "value": "${var.required_learning_template_id}"
                          },
                          {
                              "name": "XAPI_URL",
                              "value": "${var.xapi_url}"
                          },
                          {
                              "name": "XAPI_USERNAME",
                              "value": "${var.xapi_username}"
                          },
                          {
                              "name": "XAPI_PASSWORD",
                              "value": "${var.xapi_password}"
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
                  "name": "[parameters('siteName')]",
                  "serverFarmId": "[variables('hostingPlanName')]",
                  "hostingEnvironment": ""
              },
              "apiVersion": "2016-03-01",
              "location": "[resourceGroup().location]",
              "tags" : {
                  "environment": "${var.env_profile}"
              },
              "dependsOn": [
                  "[variables('hostingPlanName')]"
              ]
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
        "appCommandLine": "",
        "linuxFxVersion": "DOCKER|${var.docker_image}:${var.docker_tag}"
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
