###### lpg-ui ######

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

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
                              "name": "AUTHENTICATION_SERVICE_URL",
                              "value": "${var.authentication_service_url}"
                          },
                          {
                              "name": "AZURE_STORAGE_CONNECTION_STRING",
                              "value": "${var.azure_storage_connection_string}"
                          },
                          {
                              "name": "BOOKING_ALERT_WEBHOOK",
                              "value": "${var.booking_alert_webhook}"
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
                              "name": "LEARNER_RECORD_USER",
                              "value": "${var.learner_record_user}"
                          },
                          {
                              "name": "LEARNER_RECORD_PASSWORD",
                              "value": "${var.learner_record_pass}"
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
                              "value": "${var.learner_record_pass}"
                          },
                          {
                              "name": "VIRTUAL_HOST",
                              "value": "${var.virtual_host}"
                          },
                          {
                              "name": "XAPI_URL",
                              "value": "${var.xapi_url}"
                          },
                          {
                              "name": "YOUTUBE_API_KEY",
                              "value": "${var.youtube_api_key}"
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
                "alwaysOn": true
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
