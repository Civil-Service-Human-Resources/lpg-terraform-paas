###### lpg-learning-catalogue ######

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

resource "azurerm_template_deployment" "lpg-learning-catalogue-app-service" {
  name = "${var.lpg_learning_catalogue_name}"
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
                              "name": "AUTH_USER",
                              "value": "${var.auth_user}"
                          },
                          {
                              "name": "AUTH_PASSWORD",
                              "value": "${var.auth_password}"
                          },
                          {
                              "name": "ELASTICSEARCH_HOST",
                              "value": "${var.elasticsearch_host}"
                          },
                          {
                              "name": "ELASTICSEARCH_PORT",
                              "value": "${var.elasticsearch_port}"
                          },
                          {
                              "name": "ELASTICSEARCH_CLUSTER",
                              "value": "${var.elasticsearch_cluster}"
                          },
                          {
                              "name": "WEBSITES_PORT",
                              "value": "${var.websites_port}"
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
            "comments": "Generalized from resource: '/subscriptions/72aa545d-e1e2-4b4e-ade4-34ef397aca13/resourceGroups/pptestlab/providers/Microsoft.Web/sites/lpg-learner-record/config/web'.",
            "type": "Microsoft.Web/sites/config",
            "name": "[concat(parameters('siteName'), '/web')]",
            "apiVersion": "2016-08-01",
            "location": "UK South",
            "scale": null,
            "properties": {
                "httpLoggingEnabled": true,
                "logsDirectorySizeLimit": 35,
                "detailedErrorLoggingEnabled": true,
                "appCommandLine": "./wait-for-it.sh ${var.elasticsearch_host}:${var.elasticsearch_port} -- java -jar /data/app.jar"
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
