###### identity ######

resource "azurerm_template_deployment" "identity-app-service" {
  name                = "${var.identity_name}"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
  {
      "$schema":"http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
      "contentVersion":"1.0.0.0",
      "parameters":{
          "siteName":{
              "type":"string",
              "defaultvalue":"${var.identity_name}",
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
              "defaultvalue":"${var.envurl}identity",
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
                              "name":"DATASOURCE",
                              "value":"${var.datasource}"
                          },
                          {
                              "name": "OAUTH_SERVICE_URL",
                              "value": "${var.authentication_service_url}"
                          },
                          {
                              "name":"WEBSITES_PORT",
                              "value":"${var.websites_port}"
                          },
                          {
                              "name":"WEBSITES_CONTAINER_START_TIME_LIMIT",
                              "value":"600"
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
                              "name":"GOV_NOTIFY_API_KEY",
                              "value":"${var.gov_notify_api_key}"
                          },
                          {
                              "name":"DOCKER_ENABLE_CI",
                              "value":"true"
                          },
                          {
                              "name":"GOV_NOTIFY_INVITE_TEMPLATE_ID",
                              "value":"${var.gov_notify_invite_template_id}"
                          },
                          {
                              "name":"GOV_NOTIFY_RESET_TEMPLATE_ID",
                              "value":"${var.gov_notify_reset_template_id}"
                          },
                          {
                              "name":"GOV_NOTIFY_RESET_SUCCESSFUL_TEMPLATE_ID",
                              "value":"${var.gov_notify_reset_successful_template_id}"
                          },
                          {
                              "name":"INVITE_SIGNUP_URL",
                              "value":"${var.invite_signup_url}"
                          },
                          {
                              "name":"RESET_URL",
                              "value":"${var.reset_url}"
                          },
                          {
                              "name":"REDIS_URL",
                              "value":"${var.redis_url}"
                          },
                          {
                              "name":"REDIS_USE_TLS",
                              "value":"${var.redis_use_tls}"
                          },
                          {
                              "name":"LPG_UI_URL",
                              "value":"${var.lpg_ui_url}"
                          },
                          {
                              "name":"WHITELISTED_DOMAINS",
                              "value":"${var.whitelisted_domains}"
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
                  "appCommandLine":"",
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
          }
      ]
  }
  DEPLOY

  deployment_mode = "Incremental"
}
