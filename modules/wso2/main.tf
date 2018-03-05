resource "azurerm_template_deployment" "wso2-app-service" {
    name = "${var.rg_name}",
    resource_group_name = "${var.rg_name}"
    template_body = <<DEPLOY
    {
    "parameters": {
        "name": {
            "type": "string",
             "value": "${var.wso2_name}"
        },
        "hostingPlanName": {
            "type": "string",
            "value": "[concat('wso2',uniqueString(resourceGroup().id))]"
        },
        "location": {
            "type": "string",
            "value": "${var.rg_location}"
        },
        "hostingEnvironment": {
            "type": "string"
        },
        "serverFarmResourceGroup": {
            "type": "string",
            "value": "${var.rg_name}"
        },
        "subscriptionId": {
            "type": "string",
            "value": "72aa545d-e1e2-4b4e-ade4-34ef397aca13"
        },
        "sku" : {
            "type": "string",
            "value": "${var.app_service_sku}"
        },
        "skuCode" : {
            "type": "string",
            "value": "${var.app_service_sku_code}"
        },
        "workerSize" : {
            "type": "string",
            "value": "${var.app_service_worker_size}"
        }
    },
    "resources": [
        {
            "apiVersion": "2016-03-01",
            "name": "[parameters('name')]",
            "type": "Microsoft.Web/Sites",
            "properties": {
                "name": "[parameters('name')]",
                "siteConfig": {
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
                    "appCommandLine": "",
                    "linuxFxVersion": "DOCKER|${var.docker_image}:${var.docker_tag}"
                },
                "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', variables('servicePlanName'))]",
                "hostingEnvironment": "[parameters('hostingEnvironment')]"
            },
            "location": "[parameters('location')]",
            "tags": {
                "[concat('hidden-related:', '/subscriptions/', '/resourcegroups/', parameters('serverFarmResourceGroup'), '/providers/Microsoft.Web/serverfarms/', parameters('hostingPlanName'))]": "empty"
            }
        },
        {
            "apiVersion": "2016-09-01",
            "name": "[parameters('hostingPlanName')]",
            "type": "Microsoft.Web/serverfarms",
            "location": "[parameters('location')]",
            "properties": {
                "name": "[parameters('hostingPlanName')]",
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