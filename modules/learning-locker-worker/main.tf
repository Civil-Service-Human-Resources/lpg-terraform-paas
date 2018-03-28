###### learning-locker-worker ######

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

resource "azurerm_template_deployment" "learning-locker-worker-app-service" {
  name                = "${var.learning_locker_worker_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
  {
      "$schema": "http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
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
                              "name": "DOCKER_CUSTOM_IMAGE_NAME",
                              "value": "${var.docker_image}:${var.docker_tag}"
                          },
                          {
                              "name": "WEBSITES_ENABLE_APP_SERVICE_STORAGE",
                              "value": "false"
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
                  "environment": "${var.environment_tag}"
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
                "appCommandLine": "/bin/hammer node /opt/learning-locker/worker/dist/server"
            },
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
            ]
        }
      ]
  }
  DEPLOY

  deployment_mode = "Incremental"
  depends_on      = ["azurerm_resource_group.rg"]
}
