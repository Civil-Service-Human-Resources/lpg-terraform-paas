###### notification-service ######

resource "azurerm_template_deployment" "notification-service-app-service" {
  name                = "${var.notification_service_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
  {
     "$schema":"http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
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
              "name":"[parameters('siteName')]",
              "serverFarmId":"[variables('hostingPlanName')]",
              "hostingEnvironment":""
           },
           "apiVersion":"2016-03-01",
           "location":"[resourceGroup().location]",
           "tags":{
              "environment":"${var.env_profile}"
           },
           "dependsOn":[
              "[variables('hostingPlanName')]"
           ]
        },
        {
           "apiVersion":"2016-09-01",
           "name":"[variables('hostingPlanName')]",
           "type":"Microsoft.Web/serverfarms",
           "location":"[resourceGroup().location]",
           "properties":{
              "name":"[variables('hostingPlanName')]",
              "workerSizeId":"1",
              "reserved":true,
              "numberOfWorkers":"1",
              "hostingEnvironment":"",
              "capacity": "${var.notification_capacity}"
           },
           "sku":{
              "Tier":"${var.webapp_sku_tier}",
              "Name":"${var.webapp_sku_name}"
           },
           "kind":"linux"
        },
        {
           "type":"Microsoft.Web/sites/config",
           "name":"[concat(parameters('siteName'), '/web')]",
           "apiVersion":"2016-08-01",
           "location":"UK South",
           "scale":null,
           "properties":{
              "httpLoggingEnabled":true,
              "logsDirectorySizeLimit":35,
              "detailedErrorLoggingEnabled":true,
              "alwaysOn":true,
              "appCommandLine":"",
              "linuxFxVersion":"DOCKER|${var.docker_registry_server_url}/${var.docker_image}:${var.docker_tag}",
              "minTlsVersion":"1.0",
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
