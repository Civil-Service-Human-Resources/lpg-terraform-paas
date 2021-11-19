###### identity ######

## App service plan and app

data "azurerm_resource_group" "app_service_rg" {
  name = var.rg_name
}

resource "azurerm_app_service_plan" "identity_service_plan" {
  name                = "lpg-${var.identity_name}${var.serviceplan_suffix}"
  location            = data.azurerm_resource_group.app_service_rg.location
  resource_group_name = data.azurerm_resource_group.app_service_rg.name

  sku {
    tier     = var.webapp_sku_tier
    size     = var.webapp_sku_name
    capacity = var.identity_capacity
  }

  kind     = "Linux"
  reserved = true

}

resource "azurerm_app_service" "app_service" {
  name                    = var.identity_name
  resource_group_name     = data.azurerm_resource_group.app_service_rg.name
  location                = data.azurerm_resource_group.app_service_rg.location
  app_service_plan_id     = azurerm_app_service_plan.identity_service_plan.id
  client_affinity_enabled = false
  client_cert_enabled     = false
  https_only              = true

  app_settings = local.application_settings

  site_config {
    always_on         = true
    app_command_line  = "java -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
    ftps_state        = "Disabled"
    ip_restriction    = []
    linux_fx_version  = "DOCKER|${var.docker_registry_server_url}/${var.docker_image}:${var.docker_tag}"
    min_tls_version   = "1.2"
    http2_enabled     = false

  }
}

# Hostname

resource "azurerm_app_service_custom_hostname_binding" "app_service_custom_hostname" {
  hostname            = "identity.${var.domain}"
  app_service_name    = azurerm_app_service.app_service.name
  resource_group_name = azurerm_app_service.app_service.resource_group_name

  # Ignore ssl_state and thumbprint as they are managed using
  # azurerm_app_service_certificate_binding.example
  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
}

# Certificate

data "azurerm_key_vault" "app_keyvault" {
  name = var.vaultname
  resource_group_name = var.vaultresourcegroup
}

data "azurerm_key_vault_certificate" "app_keyvault_cert" {
  name = var.existingkeyvaultsecretname
  key_vault_id = data.azurerm_key_vault.app_keyvault.id
}

resource "azurerm_app_service_certificate" "identity_service_certificate" {
  name                = var.existingkeyvaultsecretname
  resource_group_name = azurerm_app_service.app_service.resource_group_name
  location            = azurerm_app_service.app_service.location
  key_vault_secret_id = data.azurerm_key_vault_certificate.app_keyvault_cert.secret_id
}

resource "azurerm_app_service_certificate_binding" "identity_service_cert_binding" {
  hostname_binding_id = azurerm_app_service.app_service.custom_domain_verification_id
  certificate_id      = azurerm_app_service_certificate.identity_service_certificate.id
  ssl_state           = "SniEnabled"
}


## LEGACY


# resource "azurerm_template_deployment" "identity-app-service" {
#   name                = var.identity_name
#   resource_group_name = var.rg_name

#   template_body = <<DEPLOY
#   {
#       "$schema":"https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
#       "contentVersion":"1.0.0.0",
#       "parameters":{
#           "siteName":{
#               "type":"string",
#               "defaultvalue":"${var.identity_name}",
#               "metadata":{
#                   "description":"Name of azure web app"
#               }
#           },
#           "vaultResourceGroup":{
#               "type":"string",
#               "defaultvalue":"${var.vaultresourcegroup}"
#           },
#           "vaultName":{
#               "type":"string",
#               "defaultvalue":"${var.vaultname}"
#           },
#           "existingKeyVaultId":{
#               "type":"string",
#               "defaultvalue":"[resourceId(subscription().subscriptionId,  parameters('vaultResourceGroup'), 'Microsoft.KeyVault/vaults', parameters('vaultName'))]",
#               "metadata":{
#                   "description":"Existing Key Vault resource Id with an access policy to allow Microsoft.Web RP to read Key Vault secrets (Checkout README.md for more information)"
#               }
#           },
#           "existingKeyVaultSecretName":{
#               "type":"string",
#               "defaultvalue":"${var.existingkeyvaultsecretname}",
#               "metadata":{
#                   "description":"Key Vault Secret that contains a PFX certificate"
#               }
#           },
#           "certificateName":{
#               "type":"string",
#               "defaultvalue":"${var.certificatename}",
#               "metadata":{
#                   "description":"User friendly certificate resource name"
#               }
#           },
#           "websiteCustomDomain":{
#               "type":"string",
#               "defaultvalue":"${var.domain}",
#               "metadata":{
#                   "description":"Custom domain for creating SSL binding."
#               }
#           },
#           "websiteCustomName":{
#               "type":"string",
#               "defaultvalue":"${var.envurl}identity",
#               "metadata":{
#                   "description":"Custom hostname for creating SSL binding."
#               }
#           }
#       },
#       "variables":{
#           "hostingPlanName":"[concat(parameters('siteName'), '${var.serviceplan_suffix}')]"
#       },
#       "resources":[
#           {
#               "type":"Microsoft.Web/certificates",
#               "name":"[parameters('certificateName')]",
#               "apiVersion":"2019-08-01",
#               "location":"[resourceGroup().location]",
#               "properties":{
#                   "keyVaultId":"[parameters('existingKeyVaultId')]",
#                   "keyVaultSecretName":"[parameters('existingKeyVaultSecretName')]",
#                   "serverFarmId":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
#               },
#               "dependsOn":[
#                   "[variables('hostingPlanName')]"
#               ]
#           },
#           {
#               "apiVersion":"2019-08-01",
#               "name":"[variables('hostingPlanName')]",
#               "type":"Microsoft.Web/serverfarms",
#               "location":"[resourceGroup().location]",
#               "properties":{
#                   "name":"[variables('hostingPlanName')]",
#                   "workerTierName":null,
#                   "adminSiteName":null,
#                   "reserved":true,
#                   "kind":"linux",
#                   "perSiteScaling":false
#               },
#               "sku":{
#                   "Tier":"${var.webapp_sku_tier}",
#                   "Name":"${var.webapp_sku_name}",
#                   "capacity":"${var.identity_capacity}"
#               }
#           },
#           {
#               "type":"Microsoft.Web/sites",
#               "name":"[parameters('siteName')]",
#               "properties":{
#                   "siteConfig":{
#                       "appSettings":[
#                           {
#                               "name":"WEBSITES_ENABLE_APP_SERVICE_STORAGE",
#                               "value":"false"
#                           },
#                           {
#                               "name":"APPLICATIONINSIGHTS_ROLE_NAME",
#                               "value":"${var.identity_name}"
#                           },
#                           {
#                               "name":"APPLICATIONINSIGHTS_CONNECTION_STRING",
#                               "value":"${var.application_insights_connection_string}"
#                           },
#                           {
#                               "name":"DATASOURCE",
#                               "value":"${var.datasource}"
#                           },
#                           {
#                               "name":"OAUTH_SERVICE_URL",
#                               "value":"${var.authentication_service_url}"
#                           },
#                           {
#                               "name":"WEBSITES_PORT",
#                               "value":"${var.websites_port}"
#                           },
#                           {
#                               "name":"WEBSITES_CONTAINER_START_TIME_LIMIT",
#                               "value":"600"
#                           },
#                           {
#                               "name":"ENV_PROFILE",
#                               "value":"${var.env_profile}"
#                           },
#                           {
#                               "name":"GOV_NOTIFY_API_KEY",
#                               "value":"${var.gov_notify_api_key}"
#                           },
#                           {
#                               "name":"DOCKER_ENABLE_CI",
#                               "value":"true"
#                           },
#                           {
#                               "name":"GOV_NOTIFY_INVITE_TEMPLATE_ID",
#                               "value":"${var.gov_notify_invite_template_id}"
#                           },
#                           {
#                               "name":"GOV_NOTIFY_RESET_TEMPLATE_ID",
#                               "value":"${var.gov_notify_reset_template_id}"
#                           },
#                           {
#                               "name":"GOV_NOTIFY_RESET_SUCCESSFUL_TEMPLATE_ID",
#                               "value":"${var.gov_notify_reset_successful_template_id}"
#                           },
#                           {
#                               "name":"INVITE_SIGNUP_URL",
#                               "value":"${var.invite_signup_url}"
#                           },
#                           {
#                               "name":"RESET_URL",
#                               "value":"${var.reset_url}"
#                           },
#                           {
#                               "name":"REDIS_HOST",
#                               "value":"${var.redis_host}"
#                           },
#                           {
#                               "name":"REDIS_PASSWORD",
#                               "value":"${var.redis_password}"
#                           },
#                           {
#                               "name":"REDIS_PORT",
#                               "value":"${var.redis_port}"
#                           },
#                           {
#                               "name":"SESSION_TIMEOUT",
#                               "value":"3600"
#                           },
#                           {
#                               "name":"LPG_UI_URL",
#                               "value":"${var.lpg_ui_url}"
#                           },
#                           {
#                               "name":"WHITELISTED_DOMAINS",
#                               "value":"${var.whitelisted_domains}"
#                           },
#                           {
#                               "name":"DOCKER_REGISTRY_SERVER_URL",
#                               "value":"https://${var.docker_registry_server_url}"
#                           },
#                           {
#                               "name":"DOCKER_REGISTRY_SERVER_USERNAME",
#                               "value":"${var.docker_registry_server_username}"
#                           },
#                           {
#                               "name":"DOCKER_REGISTRY_SERVER_PASSWORD",
#                               "value":"${var.docker_registry_server_password}"
#                           },
#                           {
#                               "name":"REGISTRY_SERVICE_URL",
#                               "value":"${var.registry_service_url}"
#                           },
#                           {
#                               "name": "JWT_KEY",
#                               "value": "${var.jwt_key}"
#                           },
#                           {
#                               "name":"INVITE_VALIDITY",
#                               "value":"${var.invite_validity}"
#                           },
#                           {
#                               "name":"DURATION_AFTER_REREG_ALLOWED_SECONDS",
#                               "value":"${var.duration_after_rereg_allowed_seconds}"
#                           },
#                           {
#                               "name":"MAINTENANCE_PAGE_ENABLED",
#                               "value":"${var.maintenance_page_enabled}"
#                           },
#                           {
#                               "name":"MAINTENANCE_PAGE_CONTENT_LINE_1",
#                               "value":"${var.maintenance_page_content_line_1}"
#                           },
#                           {
#                               "name":"MAINTENANCE_PAGE_CONTENT_LINE_2",
#                               "value":"${var.maintenance_page_content_line_2}"
#                           },
#                           {
#                               "name":"MAINTENANCE_PAGE_CONTENT_LINE_3",
#                               "value":"${var.maintenance_page_content_line_3}"
#                           },
#                           {
#                               "name":"MAINTENANCE_PAGE_CONTENT_LINE_4",
#                               "value":"${var.maintenance_page_content_line_4}"
#                           }
#                       ]
#                   },
#                   "clientAffinityEnabled":false,
#                   "httpsOnly":true,
#                   "reserved":true,
#                   "name":"[parameters('siteName')]",
#                   "serverFarmId":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
#                   "hostNameSslStates":[
#                       {
#                           "name":"[concat(parameters('websiteCustomName'),'.',parameters('websiteCustomDomain'))]",
#                           "sslState":"SniEnabled",
#                           "thumbprint":"[reference(resourceId('Microsoft.Web/certificates', parameters('certificateName'))).Thumbprint]",
#                           "toUpdate":true,
#                           "hostType":"Standard"
#                       }
#                   ]
#               },
#               "apiVersion":"2019-08-01",
#               "location":"[resourceGroup().location]",
#               "tags":{
#                   "environment":"${var.env_profile}"
#               },
#               "dependsOn":[
#                   "[variables('hostingPlanName')]",
#                   "[resourceId('Microsoft.Web/certificates', parameters('certificateName'))]"
#               ]
#           },
#           {
#               "type":"Microsoft.Web/sites/config",
#               "name":"[concat(parameters('siteName'), '/web')]",
#               "apiVersion":"2019-08-01",
#               "location":"[resourceGroup().location]",
#               "properties":{
#                   "httpLoggingEnabled":true,
#                   "logsDirectorySizeLimit":35,
#                   "detailedErrorLoggingEnabled":true,
#                   "alwaysOn":true,
#                   "appCommandLine": "java -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar",
#                   "linuxFxVersion":"DOCKER|${var.docker_registry_server_url}/${var.docker_image}:${var.docker_tag}",
#                   "minTlsVersion":"1.2",
#                   "ftpsState":"Disabled"
#               },
#               "dependsOn":[
#                   "[resourceId('Microsoft.Web/sites', parameters('siteName'))]"
#               ]
#           },
#           {
#               "type":"Microsoft.Web/sites/hostNameBindings",
#               "name":"[concat(parameters('sitename'), '/', parameters('websiteCustomName'), '.', parameters('websiteCustomDomain'))]",
#               "apiVersion":"2019-08-01",
#               "location":"[resourceGroup().location]",
#               "properties":{
#                   "siteName":"[parameters('sitename')]",
#                   "domainId":null,
#                   "hostNameType":"Verified",
#                   "sslState":"SniEnabled",
#                   "thumbprint":"[reference(resourceId('Microsoft.Web/certificates', parameters('certificateName'))).Thumbprint]"
#               },
#               "dependsOn":[
#                   "[resourceId('Microsoft.Web/sites', parameters('sitename'))]"
#               ]
#           },
#           {
#               "type":"Microsoft.Insights/autoscalesettings",
#               "name":"${var.identity_name}-scale",
#               "dependsOn":[
#                   "[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
#               ],
#               "apiVersion":"2015-04-01",
#               "location":"[resourceGroup().location]",
#               "properties":{
#                   "profiles":[
#                       {
#                           "name":"Scale_Out_Hours",
#                           "capacity":{
#                               "minimum":"4",
#                               "maximum":"5",
#                               "default":"4"
#                           },
#                           "rules":[],
#                           "recurrence":{
#                               "frequency":"Week",
#                               "schedule":{
#                                   "timeZone":"GMT Standard Time",
#                                   "days":[
#                                       "Monday",
#                                       "Tuesday",
#                                       "Wednesday",
#                                       "Thursday",
#                                       "Friday",
#                                       "Saturday",
#                                       "Sunday"
#                                   ],
#                                   "hours":[
#                                       7
#                                   ],
#                                   "minutes":[
#                                       0
#                                   ]
#                               }
#                           }
#                       },
#                       {
#                           "name":"Scale_In_Hours",
#                           "capacity":{
#                               "minimum":"4",
#                               "maximum":"4",
#                               "default":"4"
#                           },
#                           "rules":[],
#                           "recurrence":{
#                               "frequency":"Week",
#                               "schedule":{
#                                   "timeZone":"GMT Standard Time",
#                                   "days":[
#                                       "Monday",
#                                       "Tuesday",
#                                       "Wednesday",
#                                       "Thursday",
#                                       "Friday",
#                                       "Saturday",
#                                       "Sunday"
#                                   ],
#                                   "hours":[
#                                       18
#                                   ],
#                                   "minutes":[
#                                       0
#                                   ]
#                               }
#                           }
#                       },
#                       {
#                           "name":"CPU_Scale",
#                           "capacity":{
#                               "minimum":"4",
#                               "maximum":"5",
#                               "default":"4"
#                           },
#                           "rules":[
#                               {
#                                   "scaleAction":{
#                                       "direction":"Increase",
#                                       "type":"ChangeCount",
#                                       "value":"1",
#                                       "cooldown":"PT5M"
#                                   },
#                                   "metricTrigger":{
#                                       "metricName":"CpuPercentage",
#                                       "metricNamespace":"",
#                                       "metricResourceUri":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
#                                       "operator":"GreaterThan",
#                                       "statistic":"Average",
#                                       "threshold":35,
#                                       "timeAggregation":"Average",
#                                       "timeGrain":"PT1M",
#                                       "timeWindow":"PT10M"
#                                   }
#                               },
#                               {
#                                   "scaleAction":{
#                                       "direction":"Decrease",
#                                       "type":"ChangeCount",
#                                       "value":"1",
#                                       "cooldown":"PT5M"
#                                   },
#                                   "metricTrigger":{
#                                       "metricName":"CpuPercentage",
#                                       "metricNamespace":"",
#                                       "metricResourceUri":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
#                                       "operator":"LessThan",
#                                       "statistic":"Average",
#                                       "threshold":15,
#                                       "timeAggregation":"Average",
#                                       "timeGrain":"PT1M",
#                                       "timeWindow":"PT10M"
#                                   }
#                               }
#                           ],
#                           "recurrence":{
#                               "frequency":"Week",
#                               "schedule":{
#                                   "timeZone":"GMT Standard Time",
#                                   "days":[
#                                       "Monday",
#                                       "Tuesday",
#                                       "Wednesday",
#                                       "Thursday",
#                                       "Friday",
#                                       "Saturday",
#                                       "Sunday"
#                                   ],
#                                   "hours":[
#                                       6
#                                   ],
#                                   "minutes":[
#                                       0
#                                   ]
#                               }
#                           }
#                       },
#                       {
#                           "name":"Memory_Scale",
#                           "capacity":{
#                               "minimum":"4",
#                               "maximum":"5",
#                               "default":"4"
#                           },
#                           "rules":[
#                               {
#                                   "scaleAction":{
#                                       "direction":"Increase",
#                                       "type":"ChangeCount",
#                                       "value":"1",
#                                       "cooldown":"PT5M"
#                                   },
#                                   "metricTrigger":{
#                                       "metricName":"MemoryPercentage",
#                                       "metricNamespace":"",
#                                       "metricResourceUri":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
#                                       "operator":"GreaterThan",
#                                       "statistic":"Average",
#                                       "threshold":70,
#                                       "timeAggregation":"Average",
#                                       "timeGrain":"PT1M",
#                                       "timeWindow":"PT10M"
#                                   }
#                               },
#                               {
#                                   "scaleAction":{
#                                       "direction":"Decrease",
#                                       "type":"ChangeCount",
#                                       "value":"1",
#                                       "cooldown":"PT5M"
#                                   },
#                                   "metricTrigger":{
#                                       "metricName":"MemoryPercentage",
#                                       "metricNamespace":"",
#                                       "metricResourceUri":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]",
#                                       "operator":"LessThan",
#                                       "statistic":"Average",
#                                       "threshold":65,
#                                       "timeAggregation":"Average",
#                                       "timeGrain":"PT1M",
#                                       "timeWindow":"PT10M"
#                                   }
#                               }
#                           ],
#                           "recurrence":{
#                               "frequency":"Week",
#                               "schedule":{
#                                   "timeZone":"GMT Standard Time",
#                                   "days":[
#                                       "Monday",
#                                       "Tuesday",
#                                       "Wednesday",
#                                       "Thursday",
#                                       "Friday",
#                                       "Saturday",
#                                       "Sunday"
#                                   ],
#                                   "hours":[
#                                       6
#                                   ],
#                                   "minutes":[
#                                       0
#                                   ]
#                               }
#                           }
#                       },
#                       {
#                           "name":"{\"name\":\"Default_Rule\",\"for\":\"Scale_Out_Hours\"}",
#                           "capacity":{
#                               "minimum":"4",
#                               "maximum":"4",
#                               "default":"4"
#                           },
#                           "rules":[],
#                           "recurrence":{
#                               "frequency":"Week",
#                               "schedule":{
#                                   "timeZone":"GMT Standard Time",
#                                   "days":[
#                                       "Monday",
#                                       "Tuesday",
#                                       "Wednesday",
#                                       "Thursday",
#                                       "Friday",
#                                       "Saturday",
#                                       "Sunday"
#                                   ],
#                                   "hours":[
#                                       17
#                                   ],
#                                   "minutes":[
#                                       59
#                                   ]
#                               }
#                           }
#                       },
#                       {
#                           "name":"{\"name\":\"Default_Rule\",\"for\":\"Scale_In_Hours\"}",
#                           "capacity":{
#                               "minimum":"4",
#                               "maximum":"4",
#                               "default":"4"
#                           },
#                           "rules":[],
#                           "recurrence":{
#                               "frequency":"Week",
#                               "schedule":{
#                                   "timeZone":"GMT Standard Time",
#                                   "days":[
#                                       "Monday",
#                                       "Tuesday",
#                                       "Wednesday",
#                                       "Thursday",
#                                       "Friday",
#                                       "Saturday",
#                                       "Sunday"
#                                   ],
#                                   "hours":[
#                                       6
#                                   ],
#                                   "minutes":[
#                                       59
#                                   ]
#                               }
#                           }
#                       },
#                       {
#                           "name":"{\"name\":\"Default_Rule\",\"for\":\"CPU_Scale\"}",
#                           "capacity":{
#                               "minimum":"4",
#                               "maximum":"4",
#                               "default":"4"
#                           },
#                           "rules":[],
#                           "recurrence":{
#                               "frequency":"Week",
#                               "schedule":{
#                                   "timeZone":"GMT Standard Time",
#                                   "days":[
#                                       "Monday",
#                                       "Tuesday",
#                                       "Wednesday",
#                                       "Thursday",
#                                       "Friday",
#                                       "Saturday",
#                                       "Sunday"
#                                   ],
#                                   "hours":[
#                                       5
#                                   ],
#                                   "minutes":[
#                                       59
#                                   ]
#                               }
#                           }
#                       },
#                       {
#                           "name":"{\"name\":\"Default_Rule\",\"for\":\"Memory_Scale\"}",
#                           "capacity":{
#                               "minimum":"4",
#                               "maximum":"4",
#                               "default":"4"
#                           },
#                           "rules":[],
#                           "recurrence":{
#                               "frequency":"Week",
#                               "schedule":{
#                                   "timeZone":"GMT Standard Time",
#                                   "days":[
#                                       "Monday",
#                                       "Tuesday",
#                                       "Wednesday",
#                                       "Thursday",
#                                       "Friday",
#                                       "Saturday",
#                                       "Sunday"
#                                   ],
#                                   "hours":[
#                                       5
#                                   ],
#                                   "minutes":[
#                                       59
#                                   ]
#                               }
#                           }
#                       }
#                   ],
#                   "notifications":[
#                       {
#                           "operation":"Scale",
#                           "email":{
#                               "sendToSubscriptionAdministrator":false,
#                               "sendToSubscriptionCoAdministrators":false,
#                               "customEmails":[
#                                   "${var.custom_emails}"
#                               ]
#                           },
#                           "webhooks":[]
#                       }
#                   ],
#                   "enabled":"${var.scaling_enabled}",
#                   "targetResourceUri":"[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
#               }
#           }
#       ]
#   }
#   DEPLOY

#   deployment_mode = "Incremental"
# }
