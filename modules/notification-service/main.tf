###### notification-service ######

resource "azurerm_template_deployment" "notification-service-app-service" {
  name                = var.notification_service_name
  resource_group_name = var.rg_name

  template_body = <<DEPLOY
  {
     "$schema":"https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
     "contentVersion":"1.0.0.0",
     "parameters":{
        "siteName":{
           "type":"string",
           "defaultvalue":"${var.notification_service_name}",
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
              "siteConfig":{
                 "appSettings":[
                    {
                       "name":"WEBSITES_ENABLE_APP_SERVICE_STORAGE",
                       "value":"false"
                    },
                    {
                       "name":"DOCKER_ENABLE_CI",
                       "value":"true"
                    },
                    {
                       "name":"HAMMER_LOGSTASH_HOST",
                       "value":"${var.hammer_logstash_host}"
                    },
                    {
                       "name":"HAMMER_LOGSTASH_PORT",
                       "value":"${var.hammer_logstash_port}"
                    },
                    {
                       "name":"ENV_PROFILE",
                       "value":"${var.env_profile}"
                    },
                    {
                       "name":"WEBSITES_PORT",
                       "value":"${var.websites_port}"
                    },
                    {
                       "name":"GOV_NOTIFY_API_KEY",
                       "value":"${var.gov_notify_api_key}"
                    },
                    {
                       "name":"APPINSIGHTS_INSTRUMENTATIONKEY",
                       "value":"${var.ai_instrument_key}"
                    },
                    {
                       "name":"DOCKER_REGISTRY_SERVER_URL",
                       "value":"https://${var.docker_registry_server_url}"
                    },
                    {
                       "name":"DOCKER_REGISTRY_SERVER_USERNAME",
                       "value":"${var.docker_registry_server_username}"
                    },
                    {
                       "name":"DOCKER_REGISTRY_SERVER_PASSWORD",
                       "value":"${var.docker_registry_server_password}"
                    },
                    {
                       "name":"OAUTH_SERVICE_URL",
                       "value":"${var.authentication_service_url}"
                    },
                    {
                       "name":"CLIENT_ID",
                       "value":"${var.notification_service_client_id}"
                    },
                    {
                       "name":"CLIENT_SECRET",
                       "value":"${var.notification_service_client_secret}"
                    }
                 ]
              },
              "httpsOnly":true,
              "reserved":true,
              "name":"[parameters('siteName')]",
              "serverFarmId":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
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
              "Name":"${var.webapp_sku_name}",
              "capacity": "${var.notification_capacity}"
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
              "appCommandLine":"java -javaagent:/opt/appinsights/applicationinsights-agent-2.5.0.jar -jar /data/app.jar",
              "linuxFxVersion":"DOCKER|${var.docker_registry_server_url}/${var.docker_image}:${var.docker_tag}",
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
