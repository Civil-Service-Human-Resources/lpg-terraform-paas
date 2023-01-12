###### csrs ######

locals {
  allowed_ip_address_blocks = [for idx, ip in var.allowed_ip_addresses : {
	ipAddress = "${ip}/32"
	action = "Allow"
	tag = "Default"
	priority = 1
	name = "app service"
  }]
}

resource "azurerm_template_deployment" "civil-servant-registry-app-service" {
  name                = var.civil_servant_registry_name
  resource_group_name = var.rg_name

  template_body = <<DEPLOY
  {
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
      "siteName": {
        "type": "string",
        "defaultvalue": "${var.civil_servant_registry_name}",
        "metadata": {
          "description": "Name of azure web app"
        }
      },
      "vaultResourceGroup": {
        "type": "string",
        "defaultvalue": "${var.vaultresourcegroup}"
      },
      "vaultName": {
        "type": "string",
        "defaultvalue": "${var.vaultname}"
      },
      "existingKeyVaultId": {
        "type": "string",
        "defaultvalue": "[resourceId(subscription().subscriptionId,  parameters('vaultResourceGroup'), 'Microsoft.KeyVault/vaults', parameters('vaultName'))]",
        "metadata": {
          "description": "Existing Key Vault resource Id with an access policy to allow Microsoft.Web RP to read Key Vault secrets (Checkout README.md for more information)"
        }
      },
      "existingKeyVaultSecretName": {
        "type": "string",
        "defaultvalue": "${var.existingkeyvaultsecretname}",
        "metadata": {
          "description": "Key Vault Secret that contains a PFX certificate"
        }
      },
      "certificateName": {
        "type": "string",
        "defaultvalue": "${var.certificatename}",
        "metadata": {
          "description": "User friendly certificate resource name"
        }
      },
      "websiteCustomDomain": {
        "type": "string",
        "defaultvalue": "${var.domain}",
        "metadata": {
          "description": "Custom domain for creating SSL binding."
        }
      },
      "websiteCustomName": {
        "type": "string",
        "defaultvalue": "${var.envurl}civil-servant-registry",
        "metadata": {
          "description": "Custom hostname for creating SSL binding."
        }
      }
    },
    "variables": {
      "hostingPlanName": "[concat(parameters('siteName'), 'serviceplan')]"
    },
    "resources": [
      {
        "type": "Microsoft.Web/certificates",
        "name": "[parameters('certificateName')]",
        "apiVersion": "2019-08-01",
        "location": "[resourceGroup().location]",
        "properties": {
          "keyVaultId": "[parameters('existingKeyVaultId')]",
          "keyVaultSecretName": "[parameters('existingKeyVaultSecretName')]",
          "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
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
          "Name": "${var.webapp_sku_name}",
          "capacity": "${var.csrs_capacity}"
        }
      },
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
                "name":"APPLICATIONINSIGHTS_ROLE_NAME",
                "value":"${var.civil_servant_registry_name}"
              },
              {
                "name":"APPLICATIONINSIGHTS_CONNECTION_STRING",
                "value":"${var.application_insights_connection_string}"
              },
              {
                "name": "WEBSITES_PORT",
                "value": "${var.websites_port}"
              },
              {
                "name": "ENV_PROFILE",
                "value": "${var.env_profile}"
              },
              {
                "name": "DOCKER_ENABLE_CI",
                "value": "true"
              },
              {
                "name": "OAUTH_SERVICE_URL",
                "value": "${var.authentication_service_url}"
              },
              {
                "name": "CLIENT_ID",
                "value": "${var.csrs_client_id}"
              },
              {
                "name": "CLIENT_SECRET",
                "value": "${var.csrs_client_secret}"
              },
              {
                "name": "DATASOURCE",
                "value": "${var.datasource}"
              },
              {
                "name": "GOV_NOTIFY_API_KEY",
                "value": "${var.gov_notify_api_key}"
              },
              {
                "name": "GOV_NOTIFY_LINEMANAGER_TEMPLATE_ID",
                "value": "${var.gov_notify_linemanager_template_id}"
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
                "name": "AGENCY_TOKEN_MAX_CAPACITY",
                "value": "${var.agency_token_max_capacity}"
              },
              {
                "name": "AGENCY_TOKEN_MIN_CAPACITY",
                "value": "${var.agency_token_min_capacity}"
              },
              {
                "name": "JWT_KEY",
                "value": "${var.jwt_key}"
              }
            ],
            "healthCheckPath": "/health"
          },
          "httpsOnly": true,
          "reserved": true,
          "name": "[parameters('siteName')]",
          "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
          "hostNameSslStates": [
            {
              "name": "[concat(parameters('websiteCustomName'),'.',parameters('websiteCustomDomain'))]",
              "sslState": "SniEnabled",
              "thumbprint": "[reference(resourceId('Microsoft.Web/certificates', parameters('certificateName'))).Thumbprint]",
              "toUpdate": true,
              "hostType": "Standard"
            }
          ]
        },
        "apiVersion": "2019-08-01",
        "location": "[resourceGroup().location]",
        "tags": {
          "environment": "${var.env_profile}"
        },
        "dependsOn": [
          "[variables('hostingPlanName')]",
          "[resourceId('Microsoft.Web/certificates', parameters('certificateName'))]"
        ]
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
          "appCommandLine": "java -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar",
          "linuxFxVersion": "DOCKER|${var.docker_registry_server_url}/${var.docker_repository}/${var.docker_repository_region}:${var.docker_tag}",
          "minTlsVersion": "1.2",
          "ftpsState": "Disabled",
			"ipSecurityRestrictions": ${jsonencode(local.allowed_ip_address_blocks)}
        },
        "dependsOn": [
          "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
        ]
      },
      {
          "type": "Microsoft.Web/sites/hostNameBindings",
          "name": "[concat(parameters('sitename'), '/', parameters('websiteCustomName'), '.', parameters('websiteCustomDomain'))]",
          "apiVersion": "2019-08-01",
          "location": "[resourceGroup().location]",
          "properties": {
              "siteName": "[parameters('sitename')]",
              "domainId": null,
              "hostNameType": "Verified",
              "sslState": "SniEnabled",
              "thumbprint": "[reference(resourceId('Microsoft.Web/certificates', parameters('certificateName'))).Thumbprint]"
        },
          "dependsOn": [
              "[resourceId('Microsoft.Web/sites', parameters('sitename'))]"
          ]
      },
      {
        "type":"Microsoft.Insights/autoscalesettings",
        "name":"${var.civil_servant_registry_name}-scale",
        "dependsOn":[
          "[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
        ],
        "apiVersion":"2015-04-01",
        "location":"[resourceGroup().location]",
        "properties":{
          "profiles":[
            {
              "name":"Scale_Out_Hours",
              "capacity":{
                "minimum":"2",
                "maximum":"2",
                "default":"2"
              },
              "rules":[],
              "recurrence":{
                "frequency":"Week",
                "schedule":{
                  "timeZone":"GMT Standard Time",
                  "days":[
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday",
                    "Sunday"
                  ],
                  "hours":[
                    7
                  ],
                  "minutes":[
                    0
                  ]
                }
              }
            },
            {
              "name":"Scale_In_Hours",
              "capacity":{
                "minimum":"2",
                "maximum":"2",
                "default":"2"
              },
              "rules":[],
              "recurrence":{
                "frequency":"Week",
                "schedule":{
                  "timeZone":"GMT Standard Time",
                  "days":[
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday",
                    "Sunday"
                  ],
                  "hours":[
                    18
                  ],
                  "minutes":[
                    0
                  ]
                }
              }
            },
            {
              "name":"CPU_Scale",
              "capacity":{
                "minimum":"2",
                "maximum":"3",
                "default":"2"
              },
              "rules":[
                {
                  "scaleAction":{
                    "direction":"Increase",
                    "type":"ChangeCount",
                    "value":"1",
                    "cooldown":"PT5M"
                  },
                  "metricTrigger":{
                    "metricName":"CpuPercentage",
                    "metricNamespace":"",
                    "metricResourceUri":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
                    "operator":"GreaterThan",
                    "statistic":"Average",
                    "threshold":35,
                    "timeAggregation":"Average",
                    "timeGrain":"PT1M",
                    "timeWindow":"PT10M"
                  }
                },
                {
                  "scaleAction":{
                    "direction":"Decrease",
                    "type":"ChangeCount",
                    "value":"1",
                    "cooldown":"PT5M"
                  },
                  "metricTrigger":{
                    "metricName":"CpuPercentage",
                    "metricNamespace":"",
                    "metricResourceUri":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
                    "operator":"LessThan",
                    "statistic":"Average",
                    "threshold":15,
                    "timeAggregation":"Average",
                    "timeGrain":"PT1M",
                    "timeWindow":"PT10M"
                  }
                }
              ],
              "recurrence":{
                "frequency":"Week",
                "schedule":{
                  "timeZone":"GMT Standard Time",
                  "days":[
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday",
                    "Sunday"
                  ],
                  "hours":[
                    6
                  ],
                  "minutes":[
                    0
                  ]
                }
              }
            },
            {
              "name":"Memory_Scale",
              "capacity":{
                "minimum":"2",
                "maximum":"3",
                "default":"2"
              },
              "rules":[
                {
                  "scaleAction":{
                    "direction":"Increase",
                    "type":"ChangeCount",
                    "value":"1",
                    "cooldown":"PT5M"
                  },
                  "metricTrigger":{
                    "metricName":"MemoryPercentage",
                    "metricNamespace":"",
                    "metricResourceUri":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
                    "operator":"GreaterThan",
                    "statistic":"Average",
                    "threshold":75,
                    "timeAggregation":"Average",
                    "timeGrain":"PT1M",
                    "timeWindow":"PT10M"
                  }
                },
                {
                  "scaleAction":{
                    "direction":"Decrease",
                    "type":"ChangeCount",
                    "value":"1",
                    "cooldown":"PT5M"
                  },
                  "metricTrigger":{
                    "metricName":"MemoryPercentage",
                    "metricNamespace":"",
                    "metricResourceUri":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
                    "operator":"LessThan",
                    "statistic":"Average",
                    "threshold":69,
                    "timeAggregation":"Average",
                    "timeGrain":"PT1M",
                    "timeWindow":"PT10M"
                  }
                }
              ],
              "recurrence":{
                "frequency":"Week",
                "schedule":{
                  "timeZone":"GMT Standard Time",
                  "days":[
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday",
                    "Sunday"
                  ],
                  "hours":[
                    6
                  ],
                  "minutes":[
                    0
                  ]
                }
              }
            },
            {
              "name":"{\"name\":\"Default_Rule\",\"for\":\"Scale_Out_Hours\"}",
              "capacity":{
                "minimum":"2",
                "maximum":"2",
                "default":"2"
              },
              "rules":[],
              "recurrence":{
                "frequency":"Week",
                "schedule":{
                  "timeZone":"GMT Standard Time",
                  "days":[
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday",
                    "Sunday"
                  ],
                  "hours":[
                    17
                  ],
                  "minutes":[
                    59
                  ]
                }
              }
            },
            {
              "name":"{\"name\":\"Default_Rule\",\"for\":\"Scale_In_Hours\"}",
              "capacity":{
                "minimum":"2",
                "maximum":"2",
                "default":"2"
              },
              "rules":[],
              "recurrence":{
                "frequency":"Week",
                "schedule":{
                  "timeZone":"GMT Standard Time",
                  "days":[
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday",
                    "Sunday"
                  ],
                  "hours":[
                    6
                  ],
                  "minutes":[
                    59
                  ]
                }
              }
            },
            {
              "name":"{\"name\":\"Default_Rule\",\"for\":\"CPU_Scale\"}",
              "capacity":{
                "minimum":"2",
                "maximum":"2",
                "default":"2"
              },
              "rules":[],
              "recurrence":{
                "frequency":"Week",
                "schedule":{
                  "timeZone":"GMT Standard Time",
                  "days":[
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday",
                    "Sunday"
                  ],
                  "hours":[
                    5
                  ],
                  "minutes":[
                    59
                  ]
                }
              }
            },
            {
              "name":"{\"name\":\"Default_Rule\",\"for\":\"Memory_Scale\"}",
              "capacity":{
                "minimum":"2",
                "maximum":"2",
                "default":"2"
              },
              "rules":[],
              "recurrence":{
                "frequency":"Week",
                "schedule":{
                  "timeZone":"GMT Standard Time",
                  "days":[
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday",
                    "Sunday"
                  ],
                  "hours":[
                    5
                  ],
                  "minutes":[
                    59
                  ]
                }
              }
            }
          ],
          "notifications":[
            {
              "operation":"Scale",
              "email":{
                "sendToSubscriptionAdministrator":false,
                "sendToSubscriptionCoAdministrators":false,
                "customEmails":[
                  "${var.custom_emails}"
                ]
              },
              "webhooks":[]
            }
          ],
          "enabled":"${var.scaling_enabled}",
          "targetResourceUri":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
        }
      }
    ]
  }
  DEPLOY

  deployment_mode = "Incremental"
}
