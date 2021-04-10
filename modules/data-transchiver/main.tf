###### learning-locker-worker ######

resource "azurerm_template_deployment" "data-transchiver-app-service" {
  name                = var.data_transchiver_name
  resource_group_name = var.rg_name

  template_body = <<DEPLOY
  {
      "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
          "siteName": {
              "type": "string",
              "defaultvalue": "${var.data_transchiver_name}",
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
                              "name": "ENV_PROFILE",
                              "value": "${var.env_profile}"
                          },
                          {
                              "name": "WEBSITES_PORT",
                              "value": "${var.websites_port}"
                          },
                          {
                              "name":"DOCKER_ENABLE_CI",
                              "value":"true"
                          },
                          {
                              "name": "DOCKER_REGISTRY_SERVER_URL",
                              "value": "https://${var.docker_registry_server_url}"
                          },
                          {
                              "name": "DOCKER_REGISTRY_SERVER_USERNAME",
                              "value": "${var.docker_registry_server_username}"
                          },
                          {
                              "name": "DOCKER_REGISTRY_SERVER_PASSWORD",
                              "value": "${var.docker_registry_server_password}"
                          },
                          {
                              "name": "TDS_MYSQL_PROC_REGISTRY_HOST",
                              "value": "${var.tds_mysql_proc_registry_host}"
                          },
                          {
                              "name": "TDS_MYSQL_PROC_REGISTRY_DB_USER",
                              "value": "${var.tds_mysql_proc_registry_db_user}"
                          },
                          {
                              "name": "TDS_MYSQL_PROC_REGISTRY_DB_PWD",
                              "value": "${var.tds_mysql_proc_registry_db_pwd}"
                          },
                          {
                              "name": "TDS_MYSQL_LEARNER_RECORD_DB_HOST",
                              "value": "${var.tds_mysql_learner_record_db_host}"
                          },
                          {
                              "name": "TDS_MYSQL_LEARNER_RECORD_DB_USER",
                              "value": "${var.tds_mysql_learner_record_db_user}"
                          },
                          {
                              "name": "TDS_MYSQL_LEARNER_RECORD_DB_PWD",
                              "value": "${var.tds_mysql_learner_record_db_pwd}"
                          },
                          {
                              "name": "TDS_MYSQL_HISTORY_DB_HOST",
                              "value": "${var.tds_mysql_history_db_host}"
                          },
                          {
                              "name": "TDS_MYSQL_HISTORY_DB_USER",
                              "value": "${var.tds_mysql_history_db_user}"
                          },
                          {
                              "name": "TDS_MYSQL_HISTORY_DB_PWD",
                              "value": "${var.tds_mysql_history_db_pwd}"
                          },
                          {
                              "name": "COSMOS_SRC_CONNECTION_STRING",
                              "value": "${var.cosmos_src_connection_string}"
                          },
                          {
                              "name": "DATA_XFR_JOB_SCHEDULE",
                              "value": "${var.data_xfr_job_schedule}"
                          }
                      ]
                  },
                  "httpsOnly":true,
                  "reserved":true,
                  "name": "[parameters('siteName')]",
                  "serverFarmId": "[variables('hostingPlanName')]"
              },
              "apiVersion": "2019-08-01",
              "location": "[resourceGroup().location]",
              "tags": {
                  "environment": "${var.env_profile}"
              },
              "dependsOn": [
                  "[variables('hostingPlanName')]"
              ]
          },
          {
              "apiVersion": "2019-08-01",
              "name": "[variables('hostingPlanName')]",
              "type": "Microsoft.Web/serverfarms",
              "location": "[resourceGroup().location]",
              "properties": {
                  "name": "[variables('hostingPlanName')]",
                  "workerTierName": null,
                  "adminSiteName": null,
                  "reserved": true,
                  "kind": "linux",
                  "perSiteScaling": false
              },
              "sku": {
                  "Tier": "${var.webapp_sku_tier}",
                  "Name": "${var.webapp_sku_name}"
              }
          },
          {
              "type": "Microsoft.Web/sites/config",
              "name": "[concat(parameters('siteName'), '/web')]",
              "apiVersion": "2019-08-01",
              "location": "[resourceGroup().location]",
              "properties": {
                  "httpLoggingEnabled": true,
                  "logsDirectorySizeLimit": 35,
                  "detailedErrorLoggingEnabled": true,
                  "alwaysOn": true,
                  "appCommandLine": "",
                  "linuxFxVersion": "DOCKER|${var.docker_registry_server_url}/${var.docker_image}:${var.docker_tag}",
                  "minTlsVersion": "1.2",
                  "ftpsState": "Disabled"
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
