###### identity-management ######

resource "azurerm_template_deployment" "identity-management-app-service" {
  name                = "${var.identity_management_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
  {
      "$schema": "http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
          "siteName": {
              "type": "string",
              "defaultvalue": "${var.identity_management_name}",
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
                              "name":"APPINSIGHTS_INSTRUMENTATIONKEY",
                              "value":"${var.ai_instrument_key}"
                          },
                          {
                            "name": "DATASOURCE",
                            "value": "${var.datasource}"
                          },
                          {
                            "name": "WEBSITES_PORT",
                            "value": "${var.websites_port}"
                          },
                          {
                            "name": "WEBSITES_CONTAINER_START_TIME_LIMIT",
                            "value": "600"
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
                            "name": "OAUTH_URL",
                            "value": "${var.authentication_service_url}"
                          },
                          {
                            "name": "CLIENT_ID",
                            "value": "${var.identity_management_client_id}"
                          },
                          {
                            "name": "CLIENT_SECRET",
                            "value": "${var.identity_management_client_secret}"
                          },
                          {
                            "name": "INVITE_SIGNUP_URL",
                            "value": "${var.invite_signup_url}"
                          },
                          {
                            "name": "LEARNER_RECORD_URL",
                            "value": "${var.learner_record_url}"
                          },
                          {
                            "name": "REGISTRY_SERVICE_URL",
                            "value": "${var.registry_service_url}"
                          },
                          {
                            "name": "NOTIFICATION_SERVICE_URL",
                            "value": "${var.notification_service_url}"
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
                          }
                      ]
                  },
                  "httpsOnly":true,
                  "name": "[parameters('siteName')]",
                  "serverFarmId": "[variables('hostingPlanName')]",
                  "hostingEnvironment": ""
              },
              "apiVersion": "2016-03-01",
              "location": "[resourceGroup().location]",
              "tags" : {
                  "environment": "${var.env_profile}"
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
                  "Tier": "${var.webapp_sku_tier}",
                  "Name": "${var.webapp_sku_name}"
              },
              "kind": "linux"
          },
          {
            "type": "Microsoft.Web/sites/config",
            "name": "[concat(parameters('siteName'), '/web')]",
            "apiVersion": "2016-08-01",
            "location": "UK South",
            "scale": null,
            "properties": {
                "httpLoggingEnabled": true,
                "logsDirectorySizeLimit": 35,
                "detailedErrorLoggingEnabled": true,
                "alwaysOn": true,
                "appCommandLine": "",
                "linuxFxVersion": "DOCKER|${var.docker_registry_server_url}/${var.docker_image}:${var.docker_tag}",
                "minTlsVersion": "1.0",
                "ftpsState": "Disabled"
            },
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
            ]
          },
          {
            "type":"Microsoft.Insights/autoscalesettings",
            "name":"${var.identity_management_name}-scale",
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
              },
              {
                "name":"{\"name\":\"Default_Rule\",\"for\":\"Memory_Scale\"}",
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
                "webhooks":[

                ]
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
