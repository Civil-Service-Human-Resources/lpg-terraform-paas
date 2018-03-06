resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

resource "azurerm_template_deployment" "wso2-app-service" {
    name = "wso2_template_01",
    resource_group_name = "${var.rg_name}"
    template_body = <<DEPLOY
    {
    "parameters": {
        "name": {
            "type": "string",
             "defaultvalue": "${var.wso2_name}"
        },
        "servicePlanName": {
            "type": "string",
            "defaultvalue": "[concat('wso2',uniqueString(resourceGroup().id))]"
        },
        "location": {
            "type": "string",
            "defaultvalue": "${var.rg_location}"
        },
        "hostingEnvironment": {
            "type": "string",
            "defaultvalue": ""
        },
        "serverFarmResourceGroup": {
            "type": "string",
            "defaultvalue": "${var.rg_name}"
        },
        "sku" : {
            "type": "string",
            "defaultvalue": "${var.app_service_sku}"
        },
        "skuCode" : {
            "type": "string",
            "defaultvalue": "${var.app_service_sku_code}"
        },
        "workerSize" : {
            "type": "string",
            "defaultvalue": "${var.app_service_worker_size}"
        }
    },
    "resources": [
        {
            "apiVersion": "2016-08-01",
            "kind": "app,linux,container",
            "name": "[parameters('name')]",
            "type": "Microsoft.Web/Sites",
            "properties": {
                "name": "[parameters('name')]",
                "siteConfig": {
                    "alwaysOn": true,
                    "appSettings": [
                        {
                            "WEBSITES_ENABLE_APP_SERVICE_STORAGE": "false",
                            "DATABASE_USER": "${var.database_user}",
                            "DATABASE_PASSWORD": "${var.database_password}",
                            "DATABASE_URL": "${var.database_url}",
                            "CARBON_PROTOCOL": "${var.carbon_protocol}",
                            "CARBON_PORT": "${var.carbon_port}",
                            "CARBON_HOST": "${var.carbon_host}",
                            "LPG_UI_URL": "${var.lpg_ui_url}",
                            "WEBSITES_PORT": "${var.carbon_port}"
                        }
                    ],
                    "linuxFxVersion": "DOCKER|${var.docker_image}:${var.docker_tag}"
                },
                "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', parameters('servicePlanName'))]"
            },
            "dependsOn": [
                "[resourceId('Microsoft.Web/serverfarms', parameters('servicePlanName'))]"
            ],
            "location": "[resourceGroup().location]",
            "tags": {
                "[concat('hidden-related:', '/subscriptions/', '/resourcegroups/', parameters('serverFarmResourceGroup'), '/providers/Microsoft.Web/serverfarms/', parameters('servicePlanName'))]": "empty"
            }
        },
        {
            "apiVersion": "2016-09-01",
            "name": "[parameters('servicePlanName')]",
            "type": "Microsoft.Web/serverfarms",
            "location": "[parameters('location')]",
            "properties": {
                "name": "[parameters('servicePlanName')]",
                "workerSizeId": "[parameters('workerSize')]",
                "reserved": true,
                "numberOfWorkers": "1",
                "hostingEnvironment": "[parameters('hostingEnvironment')]"
            },
            "sku": {
                "Tier": "[parameters('sku')]",
                "Name": "[parameters('skuCode')]"
            },
            "kind": "linux"
        }
    ],
    "$schema": "http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0"
    }
    DEPLOY
    deployment_mode = "Incremental"
}