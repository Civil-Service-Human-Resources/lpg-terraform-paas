###### learning-locker-xapi ######

resource "azurerm_template_deployment" "learning-locker-xapi" {
  name                = "${var.learning_locker_xapi_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
  {
      "$schema":"http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
      "contentVersion":"1.0.0.0",
      "parameters":{
          "siteName":{
              "type":"string",
              "defaultvalue":"${var.learning_locker_xapi_name}",
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
              "defaultvalue":"${var.envurl}xapi",
              "metadata":{
                  "description":"Custom hostname for creating SSL binding."
              }
          }
      },
      "variables":{
          "hostingPlanName":"[concat(parameters('siteName'), 'serviceplan')]"
      },
      "resources":[
          {
              "type":"Microsoft.Web/certificates",
              "name":"[parameters('certificateName')]",
              "apiVersion":"2016-03-01",
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
              "apiVersion":"2016-09-01",
              "name":"[variables('hostingPlanName')]",
              "type":"Microsoft.Web/serverfarms",
              "location":"[resourceGroup().location]",
              "properties":{
                  "name":"[variables('hostingPlanName')]",
                  "workerSizeId":"1",
                  "reserved":true,
                  "numberOfWorkers":"1",
                  "hostingEnvironment":""
              },
              "sku":{
                  "Tier":"${var.webapp_sku_tier}",
                  "Name":"${var.webapp_sku_name}"
              },
              "kind":"linux"
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
                              "name":"APPINSIGHTS_INSTRUMENTATIONKEY",
                              "value":"${var.ai_instrument_key}"
                          },
                          {
                              "name":"MONGO_URL",
                              "value":"${var.mongo_url}"
                          },
                          {
                              "name":"REDIS_URL",
                              "value":"${var.redis_url}"
                          },
                          {
                              "name":"WEBSITES_PORT",
                              "value":"${var.websites_port}"
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
                              "name":"REDIS_USE_TLS",
                              "value":"${var.redis_use_tls}"
                          },
                          {
                              "name":"REDIS_PREFIX",
                              "value":"${var.redis_prefix}"
                          },
                          {
                              "name":"EXPRESS_PORT",
                              "value":"${var.express_port}"
                          },
                          {
                              "name":"DOCKER_ENABLE_CI",
                              "value":"true"
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
                          }
                      ]
                  },
                  "httpsOnly":true,
                  "name":"[parameters('siteName')]",
                  "serverFarmId":"[variables('hostingPlanName')]",
                  "hostingEnvironment":"",
                  "hostNameSslStates":[
                      {
                          "name":"[concat(parameters('websiteCustomName'),'.',parameters('websiteCustomDomain'))]",
                          "sslState":"SniEnabled",
                          "thumbprint":"[reference(resourceId('Microsoft.Web/certificates', parameters('certificateName'))).Thumbprint]",
                          "toUpdate":true,
                          "hostType":"Standard"
                      },
                      {
                          "name":"[concat(parameters('siteName'),'.azurewebsites.net')]",
                          "sslState":"Disabled",
                          "thumbprint":null,
                          "toUpdate":true,
                          "hostType":"Standard"
                      },
                      {
                          "name":"[concat(parameters('siteName'),'.scm.azurewebsites.net')]",
                          "sslState":"Disabled",
                          "thumbprint":null,
                          "toUpdate":true,
                          "hostType":"Standard"
                      }
                  ]
              },
              "apiVersion":"2016-03-01",
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
              "apiVersion":"2016-08-01",
              "location":"UK South",
              "scale":null,
              "properties":{
                  "httpLoggingEnabled":true,
                  "logsDirectorySizeLimit":35,
                  "detailedErrorLoggingEnabled":true,
                  "alwaysOn":true,
                  "appCommandLine":"/bin/hammer node /opt/xapi-service/dist/server",
                  "linuxFxVersion":"DOCKER|${var.docker_registry_server_url}/${var.docker_image}:${var.docker_tag}",
                  "minTlsVersion":"1.0",
                  "ftpsState":"Disabled"
              },
              "dependsOn":[
                  "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
              ]
          },
          {
              "type":"Microsoft.Web/sites/hostNameBindings",
              "name":"[concat(parameters('sitename'), '/', parameters('sitename'), '.azurewebsites.net')]",
              "apiVersion":"2016-08-01",
              "location":"UK South",
              "scale":null,
              "properties":{
                  "siteName":"[parameters('sitename')]",
                  "domainId":null,
                  "hostNameType":"Verified"
              },
              "dependsOn":[
                  "[resourceId('Microsoft.Web/sites', parameters('sitename'))]"
              ]
          },
          {
              "type":"Microsoft.Web/sites/hostNameBindings",
              "name":"[concat(parameters('sitename'), '/', parameters('websiteCustomName'), '.', parameters('websiteCustomDomain'))]",
              "apiVersion":"2016-08-01",
              "location":"UK South",
              "scale":null,
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
              "name":"${var.learning_locker_xapi_name}-scale",
              "dependsOn":[
                  "[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
              ],
              "apiVersion":"2014-04-01",
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
                          "rules":[

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
                              "minimum":"1",
                              "maximum":"1",
                              "default":"1"
                          },
                          "rules":[

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
                              "minimum":"1",
                              "maximum":"3",
                              "default":"1"
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
                              "minimum":"1",
                              "maximum":"3",
                              "default":"1"
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
                              "minimum":"1",
                              "maximum":"1",
                              "default":"1"
                          },
                          "rules":[

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
                              "minimum":"1",
                              "maximum":"1",
                              "default":"1"
                          },
                          "rules":[

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
                                      59
                                  ]
                              }
                          }
                      },
                      {
                          "name":"{\"name\":\"Default_Rule\",\"for\":\"CPU_Scale\"}",
                          "capacity":{
                              "minimum":"1",
                              "maximum":"1",
                              "default":"1"
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
                              "minimum":"1",
                              "maximum":"1",
                              "default":"1"
                          },
                          "rules":[

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
