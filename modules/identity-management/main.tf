###### identity-management ######

resource "azurerm_template_deployment" "identity-management-app-service" {
  name                = var.identity_management_name
  resource_group_name = var.rg_name

  template_body = <<DEPLOY
  {
      "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
          "siteName": {
              "type": "string",
              "defaultvalue": "${var.identity_management_name}",
              "metadata": {
                  "description": "Name of azure web app"
              }
          }
      },
      "variables": {
          "hostingPlanName": "[concat(parameters('siteName'), 'serviceplan')]"
      },
      "resources": [
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
                            "name": "DATASOURCE",
                            "value": "${var.datasource}"
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
                            "name": "ENV_PROFILE",
                            "value": "${var.env_profile}"
                          },
                          {
                            "name": "DOCKER_ENABLE_CI",
                            "value": "true"
                          },
                          {
                            "name": "OAUTH_URL",
                            "value": "${var.authentication_service_url}"
                          },
                          {
                            "name": "CLIENT_ID",
                            "value": "${var.identity_management_client_id}"
                          },
                          {
                            "name": "CLIENT_SECRET",
                            "value": "${var.identity_management_client_secret}"
                          },
                          {
                            "name": "INVITE_SIGNUP_URL",
                            "value": "${var.invite_signup_url}"
                          },
                          {
                            "name": "LEARNER_RECORD_URL",
                            "value": "${var.learner_record_url}"
                          },
                          {
                            "name": "REGISTRY_SERVICE_URL",
                            "value": "${var.registry_service_url}"
                          },
                          {
                            "name": "NOTIFICATION_SERVICE_URL",
                            "value": "${var.notification_service_url}"
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
                              "name": "JWT_KEY",
                              "value": "${var.jwt_key}"
                          }
                      ]
                  },
                  "httpsOnly":true,
                  "reserved":true,
                  "name": "[parameters('siteName')]",
                  "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
              },
              "apiVersion": "2019-08-01",
              "location": "[resourceGroup().location]",
              "tags": {
                  "environment": "${var.env_profile}"
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
                  "kind": "linux",
                  "perSiteScaling": false
              },
              "sku": {
                  "Tier": "${var.webapp_sku_tier}",
                  "Name": "${var.webapp_sku_name}"
              }
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
                "linuxFxVersion": "DOCKER|${var.docker_registry_server_url}/${var.docker_image}:${var.docker_tag}",
                "minTlsVersion": "1.2",
                "ftpsState": "Disabled"
            },
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
            ]
          }
      ]
  }
  DEPLOY

  deployment_mode = "Incremental"
}
