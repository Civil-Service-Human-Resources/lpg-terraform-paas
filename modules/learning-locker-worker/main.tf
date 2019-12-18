###### learning-locker-worker ######

resource "azurerm_template_deployment" "learning-locker-worker-app-service" {
  name                = "${var.learning_locker_worker_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
  {
      "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
          "siteName": {
              "type": "string",
              "defaultvalue": "${var.learning_locker_worker_name}",
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
                              "name":"APPINSIGHTS_INSTRUMENTATIONKEY",
                              "value":"${var.ai_instrument_key}"
                          },
                          {
                              "name": "MONGODB_PATH",
                              "value": "${var.mongodb_path}"
                          },
                          {
                              "name": "REDIS_HOST",
                              "value": "${var.redis_host}"
                          },
                          {
                              "name": "REDIS_PORT",
                              "value": "${var.redis_port}"
                          },
                          {
                              "name": "REDIS_DB",
                              "value": "${var.redis_db}"
                          },
                          {
                              "name": "REDIS_PREFIX",
                              "value": "${var.redis_prefix}"
                          },
                          {
                              "name": "REDIS_PASSWORD",
                              "value": "${var.redis_password}"
                          },
                          {
                              "name": "QUEUE_PROVIDER",
                              "value": "${var.queue_provider}"
                          },
                          {
                              "name": "QUEUE_NAMESPACE",
                              "value": "${var.queue_namespace}"
                          },
                          {
                              "name": "HAMMER_HTTP_SERVER_PORT",
                              "value": "${var.hammer_http_server_port}"
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
                              "name": "REDIS_USE_TLS",
                              "value": "${var.redis_use_tls}"
                          },
                          {
                              "name": "HAMMER_WORKING_DIRECTORY",
                              "value": "${var.hammer_working_directory}"
                          },
                          {
                              "name": "WEBSITES_PORT",
                              "value": "${var.websites_port}"
                          },
                          {
                              "name": "TESTING",
                              "value": "${var.testing}"
                          },
                          {
                              "name":"DOCKER_ENABLE_CI",
                              "value":"true"
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
                          }
                      ]
                  },
                  "clientAffinityEnabled":false,
                  "httpsOnly":true,
                  "reserved":true,
                  "name": "[parameters('siteName')]",
                  "serverFarmId": "[variables('hostingPlanName')]"
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
                  "appCommandLine": "/bin/hammer node /opt/learning-locker/worker/dist/server",
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
