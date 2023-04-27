###### lpg-ui ######

resource "azurerm_template_deployment" "lpg-ui-app-service" {
  name                = var.lpg_ui_name
  resource_group_name = var.rg_name_lpg_ui

  template_body = <<DEPLOY
  {
      "$schema":"https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
      "contentVersion":"1.0.0.0",
      "parameters":{
          "siteName":{
              "type":"string",
              "defaultvalue":"${var.lpg_ui_name}",
              "metadata":{
                  "description":"Name of azure web app"
              }
          },
          "vaultResourceGroup":{
              "type":"string",
              "defaultvalue":"${var.vaultresourcegroup}"
          },
          "vaultName":{
              "type":"string",
              "defaultvalue":"${var.vaultname}"
          },
          "existingKeyVaultId":{
              "type":"string",
              "defaultvalue":"[resourceId(subscription().subscriptionId,  parameters('vaultResourceGroup'), 'Microsoft.KeyVault/vaults', parameters('vaultName'))]",
              "metadata":{
                  "description":"Existing Key Vault resource Id with an access policy to allow Microsoft.Web RP to read Key Vault secrets (Checkout README.md for more information)"
              }
          },
          "existingKeyVaultSecretName":{
              "type":"string",
              "defaultvalue":"${var.existingkeyvaultsecretname}",
              "metadata":{
                  "description":"Key Vault Secret that contains a PFX certificate"
              }
          },
          "certificateName":{
              "type":"string",
              "defaultvalue":"${var.certificatename}",
              "metadata":{
                  "description":"User friendly certificate resource name"
              }
          },
          "websiteCustomDomain":{
              "type":"string",
              "defaultvalue":"${var.domain}",
              "metadata":{
                  "description":"Custom domain for creating SSL binding."
              }
          },
          "websiteCustomName":{
              "type":"string",
              "defaultvalue":"${var.envurl}",
              "metadata":{
                  "description":"Custom hostname for creating SSL binding."
              }
          }
      },
      "variables":{
          "hostingPlanName":"[concat(parameters('siteName'), '${var.serviceplan_suffix_lpgui}')]"
      },
      "resources":[
          {
              "type":"Microsoft.Web/certificates",
              "name":"[parameters('certificateName')]",
              "apiVersion":"2019-08-01",
              "location":"[resourceGroup().location]",
              "properties":{
                  "keyVaultId":"[parameters('existingKeyVaultId')]",
                  "keyVaultSecretName":"[parameters('existingKeyVaultSecretName')]",
                  "serverFarmId":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
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
                  "capacity": "${var.lpg_ui_capacity}"
              }
          },
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
                              "name":"APPLICATIONINSIGHTS_ROLE_NAME",
                              "value":"${var.lpg_ui_name}"
                          },
                          {
                              "name":"APPLICATIONINSIGHTS_CONNECTION_STRING",
                              "value":"${var.application_insights_connection_string}"
                          },
                          {
                              "name":"AUTHENTICATION_SERVICE_URL",
                              "value":"${var.authentication_service_url}"
                          },
                          {
                              "name":"GOOGLE_ANALYTICS_ID",
                              "value":"${var.google_analytics_id}"
                          },
                          {
                              "name":"GOV_NOTIFY_API_KEY",
                              "value":"${var.gov_notify_api_key}"
                          },
                          {
                              "name":"LEARNER_RECORD_URL",
                              "value":"${var.learner_record_url}"
                          },
                          {
                              "name":"COURSE_CATALOGUE_URL",
                              "value":"${var.course_catalogue_url}"
                          },
                          {
                              "name":"COURSE_CATALOGUE_USER",
                              "value":"${var.course_catalogue_user}"
                          },
                          {
                              "name":"COURSE_CATALOGUE_PASS",
                              "value":"${var.course_catalogue_pass}"
                          },
                          {
                              "name":"XAPI_URL",
                              "value":"${var.xapi_url}"
                          },
                          {
                              "name":"YOUTUBE_API_KEY",
                              "value":"${var.youtube_api_key}"
                          },
                          {
                              "name":"ENV_PROFILE",
                              "value":"${var.env_profile}"
                          },
						  {
							  "name": "LOGGING_LEVEL",
							  "value": "${var.logging_level}"
						  },
                          {
                              "name":"WEBSITES_PORT",
                              "value":"${var.websites_port}"
                          },
                          {
                              "name":"SESSION_SECRET",
                              "value":"${var.session_secret}"
                          },
                          {
                              "name":"CONTENT_URL",
                              "value":"${var.content_url}"
                          },
                          {
                              "name":"DOCKER_ENABLE_CI",
                              "value":"true"
                          },
                          {
                              "name":"REGISTRY_SERVICE_URL",
                              "value":"${var.registry_service_url}"
                          },
                          {
                              "name":"LPG_UI_SERVER",
                              "value":"${var.lpg_ui_server}"
                          },
                          {
                              "name":"OAUTH_CLIENT_ID",
                              "value":"${var.lpg_ui_oauth_client_id}"
                          },
                          {
                              "name":"OAUTH_CLIENT_SECRET",
                              "value":"${var.lpg_ui_oauth_client_secret}"
                          },
                          {
                              "name":"LPG_MANAGEMENT_SERVER",
                              "value":"${var.lpg_management_server}"
                          },
                          {
                              "name":"FEEDBACK_URL",
                              "value":"${var.feedback_url}"
                          },
                          {
                              "name": "CONTACT_EMAIL",
                              "value": "${var.contact_us_email}"
                          },
                          {
                              "name":"UV_THREADPOOL_SIZE",
                              "value":"${var.uv_threadpool_size}"
                          },
                          {
                              "name":"REDIS_HOST",
                              "value":"${var.redis_host}"
                          },
                          {
                              "name":"REDIS_PASSWORD",
                              "value":"${var.redis_password}"
                          },
                          {
                              "name":"REDIS_PORT",
                              "value":"${var.redis_port}"
                          },
                          {
                              "name":"ORG_REDIS_HOST",
                              "value":"${var.org_redis_host}"
                          },
                          {
                              "name":"ORG_REDIS_PASSWORD",
                              "value":"${var.org_redis_password}"
                          },
                          {
                              "name":"ORG_REDIS_PORT",
                              "value":"${var.org_redis_port}"
                          },
                          {
                              "name":"ORG_REDIS_TTL",
                              "value":"${var.org_redis_ttl}"
                          },
                          {
                              "name":"XAPI_USER",
                              "value":"${var.xapi_username}"
                          },
                          {
                              "name":"XAPI_PASS",
                              "value":"${var.xapi_password}"
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
                              "name":"SERVER_TIMEOUT_MS",
                              "value":"${var.ui_server_timeout_ms}"
                          },
                          {
                              "name":"STATIC_ASSET_ROOT",
                              "value":"${var.ui_static_asset_root}"
                          },
                          {
                              "name":"STATIC_ASSET_TTL",
                              "value":"${var.ui_static_asset_ttl}"
                          }
                      ]
                  },
                  "clientAffinityEnabled":false,
                  "httpsOnly":true,
                  "reserved":true,
                  "name":"[parameters('siteName')]",
                  "serverFarmId":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
                  "hostNameSslStates":[
                      {
                          "name":"[concat(parameters('websiteCustomName'),parameters('websiteCustomDomain'))]",
                          "sslState":"SniEnabled",
                          "thumbprint":"[reference(resourceId('Microsoft.Web/certificates', parameters('certificateName'))).Thumbprint]",
                          "toUpdate":true,
                          "hostType":"Standard"
                      }
                  ]
              },
              "apiVersion":"2019-08-01",
              "location":"[resourceGroup().location]",
              "tags":{
                  "environment":"${var.env_profile}"
              },
              "dependsOn":[
                  "[variables('hostingPlanName')]",
                  "[resourceId('Microsoft.Web/certificates', parameters('certificateName'))]"
              ]
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
                  "appCommandLine":"npm run start:ui",
                  "linuxFxVersion":"DOCKER|${var.docker_registry_server_url}/${var.docker_repository}/${var.docker_repository_region}:${var.docker_tag}",
                  "minTlsVersion":"1.2",
                  "ftpsState":"Disabled"
              },
              "dependsOn":[
                  "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
              ]
          },
          {
              "type":"Microsoft.Web/sites/hostNameBindings",
              "name":"[concat(parameters('sitename'), '/', parameters('websiteCustomName'), parameters('websiteCustomDomain'))]",
              "apiVersion":"2019-08-01",
              "location":"[resourceGroup().location]",
              "properties":{
                  "siteName":"[parameters('sitename')]",
                  "domainId":null,
                  "hostNameType":"Verified",
                  "sslState":"SniEnabled",
                  "thumbprint":"[reference(resourceId('Microsoft.Web/certificates', parameters('certificateName'))).Thumbprint]"
              },
              "dependsOn":[
                  "[resourceId('Microsoft.Web/sites', parameters('sitename'))]"
              ]
          },
          {
              "type":"Microsoft.Insights/autoscalesettings",
              "name":"${var.lpg_ui_name}-scale",
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
                              "minimum":"4",
                              "maximum":"5",
                              "default":"4"
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
                              "minimum":"4",
                              "maximum":"4",
                              "default":"4"
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
                              "minimum":"4",
                              "maximum":"5",
                              "default":"4"
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
                              "minimum":"4",
                              "maximum":"5",
                              "default":"4"
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
                                      "threshold":70,
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
                                      "threshold":65,
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
                              "minimum":"4",
                              "maximum":"4",
                              "default":"4"
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
                              "minimum":"4",
                              "maximum":"4",
                              "default":"4"
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
                              "minimum":"4",
                              "maximum":"4",
                              "default":"4"
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
                              "minimum":"4",
                              "maximum":"4",
                              "default":"4"
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
