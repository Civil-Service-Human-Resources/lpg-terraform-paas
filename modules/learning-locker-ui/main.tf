###### learning-locker-ui ######

resource "azurerm_template_deployment" "learning-locker-ui-app-service" {
  name                = var.learning_locker_ui_name
  resource_group_name = var.rg_name

  template_body = <<DEPLOY
  {
      "$schema":"https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
      "contentVersion":"1.0.0.0",
      "parameters":{
          "siteName":{
              "type":"string",
              "defaultvalue":"${var.learning_locker_ui_name}",
              "metadata":{
                  "description":"Name of azure web app"
              }
          }
      },
      "variables":{
          "hostingPlanName":"[concat(parameters('siteName'), 'serviceplan')]"
      },
      "resources":[
          {
              "type":"Microsoft.Web/sites",
              "name":"[parameters('siteName')]",
              "properties":{
                  "httpsOnly":true,
                  "reserved":true,
                  "name":"[parameters('siteName')]",
                  "serverFarmId":"[variables('hostingPlanName')]"
              },
              "apiVersion":"2019-08-01",
              "location":"[resourceGroup().location]",
              "tags":{
                  "environment":"${var.env_profile}"
              },
              "dependsOn":[
                  "[variables('hostingPlanName')]"
              ]
          },
          {
              "apiVersion":"2019-08-01",
              "name":"[variables('hostingPlanName')]",
              "type":"Microsoft.Web/serverfarms",
              "location":"[resourceGroup().location]",
              "properties":{
                  "name":"[variables('hostingPlanName')]",
                  "workerTierName":null,
                  "adminSiteName":null,
                  "reserved":true,
                  "kind":"linux",
                  "perSiteScaling":false
              },
              "sku":{
                  "Tier":"${var.webapp_sku_tier}",
                  "Name":"${var.webapp_sku_name}"
              }
          },
          {
              "type":"Microsoft.Web/sites/config",
              "name":"[concat(parameters('siteName'), '/web')]",
              "apiVersion":"2019-08-01",
              "location":"[resourceGroup().location]",
              "properties":{
                  "httpLoggingEnabled":true,
                  "logsDirectorySizeLimit":35,
                  "detailedErrorLoggingEnabled":true,
                  "alwaysOn":true,
                  "appCommandLine":"/opt/learning-locker/run-ui.sh",
                  "minTlsVersion":"1.2",
                  "ftpsState":"Disabled"
              },
              "dependsOn":[
                  "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
              ]
          }
      ]
  }
  DEPLOY

  deployment_mode = "Incremental"
}
