###### wso2 ######

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

resource "azurerm_template_deployment" "wso2-app-service" {
  name                = "${var.wso2_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
  {
      "$schema": "http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
          "siteName": {
              "type": "string",
              "defaultvalue": "${var.wso2_name}",
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
                              "name": "DATABASE_USER",
                              "value": "${var.database_user}"
                          },
                          {
                              "name": "DATABASE_PASSWORD",
                              "value": "${var.database_password}"
                          },
                          {
                              "name": "DATABASE_URL",
                              "value": "${var.database_url}"
                          },
                          {
                              "name": "CARBON_PROTOCOL",
                              "value": "${var.carbon_protocol}"
                          },
                          {
                              "name": "CARBON_PORT",
                              "value": "${var.carbon_port}"
                          },
                          {
                              "name": "CARBON_HOST",
                              "value": "${var.carbon_host}"
                          },
                          {
                              "name": "LPG_UI_URL",
                              "value": "${var.lpg_ui_url}"
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
                "detailedErrorLoggingEnabled": true
            },
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
            ]
        }
      ],
      "outputs" : {
        "wso2_ip_addresses": {
            "type": "String",
            "value": "[reference(parameters('siteName')).outboundIpAddresses]"
        }
      }
  }
  DEPLOY

  deployment_mode = "Incremental"
  depends_on      = ["azurerm_resource_group.rg"]
}

output "wso2_ip" {
  value = "${azurerm_template_deployment.wso2-app-service.outputs["wso2_ip_addresses"]}"
}

locals {
  fwips = "${azurerm_template_deployment.wso2-app-service.outputs["wso2_ip_addresses"]}"
}

resource "azurerm_sql_firewall_rule" "sqlfwrule" {
  depends_on          = ["azurerm_template_deployment.wso2-app-service"]
  name                = "${var.sql_rule_name}${format("%02d", count.index+1)}"
  resource_group_name = "${var.rg_name}"
  server_name         = "${var.sql_serv_name}"
  count               = "${length(split(",", local.fwips))}"
  start_ip_address    = "${element(split(",", local.fwips), count.index)}"
  end_ip_address      = "${element(split(",", local.fwips), count.index)}"
}
