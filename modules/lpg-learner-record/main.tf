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
                              "value": "${var.govuk_notify_api_key}"
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
                "appCommandLine": "/bin/hammer java -jar /data/app.jar",
                "linuxFxVersion": "DOCKER|${var.docker_image}:${var.docker_tag}"
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
