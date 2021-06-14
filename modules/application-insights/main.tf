###### app insights ######

resource "azurerm_template_deployment" "app-insights" {
  name = "app-insights"
  resource_group_name = "${var.rg_name}"

  template_body = <<DEPLOY
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "appName": {
            "type": "string",
            "defaultValue": "${var.envurl}app-insights-1"
        },
        "appType": {
            "type": "string",
            "defaultValue": "other"
        },
        "appLocation": {
            "type": "string",
            "defaultValue": "West Europe"
        },
        "pingUrl-lpgUI": {
            "type": "string",
            "defaultValue": "https://${var.envurl}lpg.cshr.digital"
        },
        "pingText-lpgUI": {
            "type": "string",
            "defaultValue": "lpgUI"
        },
            "pingUrl-identity": {
            "type": "string",
            "defaultValue": "https://${var.envurl}identity.cshr.digital"
        },
        "pingText-identity": {
            "type": "string",
            "defaultValue": "identity"
        },
            "pingUrl-csrs": {
            "type": "string",
            "defaultValue": "https://${var.envurl}civil-servant-registry.cshr.digital"
        },
        "pingText-csrs": {
            "type": "string",
            "defaultValue": "civil-servant-registry"
        },
            "pingUrl-xapi": {
            "type": "string",
            "defaultValue": "https://${var.envurl}xapi.cshr.digital"
        },
        "pingText-xapi": {
            "type": "string",
            "defaultValue": "xapi"
        }
    },
    "variables": {
        "pingTestName-lpgUI": "[concat('PingTest-', parameters('pingText-lpgUI'))]",
        "pingAlertName-lpgUI": "[concat('PingAlert-', parameters('pingText-lpgUI'), '-', subscription().subscriptionId)]",
        "pingTestName-identity": "[concat('PingTest-', parameters('pingText-identity'))]",
        "pingAlertName-identity": "[concat('PingAlert-', parameters('pingText-identity'), '-', subscription().subscriptionId)]",
        "pingTestName-csrs": "[concat('PingTest-', parameters('pingText-csrs'))]",
        "pingAlertName-csrs": "[concat('PingAlert-', parameters('pingText-csrs'), '-', subscription().subscriptionId)]",
        "pingTestName-xapi": "[concat('PingTest-', parameters('pingText-xapi'))]",
        "pingAlertName-xapi": "[concat('PingAlert-', parameters('pingText-xapi'), '-', subscription().subscriptionId)]"
    },
    "resources": [
        {
            "type": "microsoft.insights/components",
            "kind": "[parameters('appType')]",
            "name": "[parameters('appName')]",
            "apiVersion": "2014-04-01",
            "location": "[parameters('appLocation')]",
            "tags": {},
            "properties": {
                "ApplicationId": "[parameters('appName')]"
            },
            "dependsOn": []
        },
        {
            "name": "[variables('pingTestName-lpgUI')]",
            "type": "Microsoft.Insights/webtests",
            "apiVersion": "2014-04-01",
            "location": "[parameters('appLocation')]",
            "dependsOn": [
            "[resourceId('Microsoft.Insights/components', parameters('appName'))]"
            ],
            "tags": {
                "[concat('hidden-link:', resourceId('Microsoft.Insights/components', parameters('appName')))]": "Resource"
            },
            "properties": {
                "Name": "[variables('pingTestName-lpgUI')]",
                "Description": "Basic ping test",
                "Enabled": true,
                "Frequency": 300,
                "Timeout": 120,
                "Kind": "ping",
                "RetryEnabled": true,
                "Locations": [
                {
                    "Id": "emea-nl-ams-azr"
                },
                {
                    "Id": "emea-ru-msa-edge"
                },
                {
                    "Id": "emea-se-sto-edge"
                },
                {
                    "Id": "emea-gb-db3-azr"
                }
                ],
                "Configuration": {
                "WebTest": "[concat('<WebTest   Name=\"', variables('pingTestName-lpgUI'), '\"   Enabled=\"True\"         CssProjectStructure=\"\"    CssIteration=\"\"  Timeout=\"120\"  WorkItemIds=\"\"         xmlns=\"http://microsoft.com/schemas/VisualStudio/TeamTest/2010\"         Description=\"\"  CredentialUserName=\"\"  CredentialPassword=\"\"         PreAuthenticate=\"True\"  Proxy=\"default\"  StopOnError=\"False\"         RecordedResultFile=\"\"  ResultsLocale=\"\">  <Items>  <Request Method=\"GET\"    Version=\"1.1\"  Url=\"', parameters('pingUrl-lpgUI'),   '\" ThinkTime=\"0\"  Timeout=\"300\" ParseDependentRequests=\"True\"         FollowRedirects=\"True\" RecordResult=\"True\" Cache=\"False\"         ResponseTimeGoal=\"0\"  Encoding=\"utf-8\"  ExpectedHttpStatusCode=\"200\"         ExpectedResponseUrl=\"\" ReportingName=\"\" IgnoreHttpStatusCode=\"False\" />        </Items>    </WebTest>')]"
                },
                "SyntheticMonitorId": "[variables('pingTestName-lpgUI')]"
            }
        },
        {
            "name": "[variables('pingTestName-identity')]",
            "type": "Microsoft.Insights/webtests",
            "apiVersion": "2014-04-01",
            "location": "[parameters('appLocation')]",
            "dependsOn": [
            "[resourceId('Microsoft.Insights/components', parameters('appName'))]"
            ],
            "tags": {
                "[concat('hidden-link:', resourceId('Microsoft.Insights/components', parameters('appName')))]": "Resource"
            },
            "properties": {
                "Name": "[variables('pingTestName-identity')]",
                "Description": "Basic ping test",
                "Enabled": true,
                "Frequency": 300,
                "Timeout": 120,
                "Kind": "ping",
                "RetryEnabled": true,
                "Locations": [
                {
                    "Id": "emea-nl-ams-azr"
                },
                {
                    "Id": "emea-ru-msa-edge"
                },
                {
                    "Id": "emea-se-sto-edge"
                },
                {
                    "Id": "emea-gb-db3-azr"
                }
                ],
                "Configuration": {
                "WebTest": "[concat('<WebTest   Name=\"', variables('pingTestName-identity'), '\"   Enabled=\"True\"         CssProjectStructure=\"\"    CssIteration=\"\"  Timeout=\"120\"  WorkItemIds=\"\"         xmlns=\"http://microsoft.com/schemas/VisualStudio/TeamTest/2010\"         Description=\"\"  CredentialUserName=\"\"  CredentialPassword=\"\"         PreAuthenticate=\"True\"  Proxy=\"default\"  StopOnError=\"False\"         RecordedResultFile=\"\"  ResultsLocale=\"\">  <Items>  <Request Method=\"GET\"    Version=\"1.1\"  Url=\"', parameters('pingUrl-identity'),   '\" ThinkTime=\"0\"  Timeout=\"300\" ParseDependentRequests=\"True\"         FollowRedirects=\"True\" RecordResult=\"True\" Cache=\"False\"         ResponseTimeGoal=\"0\"  Encoding=\"utf-8\"  ExpectedHttpStatusCode=\"200\"         ExpectedResponseUrl=\"\" ReportingName=\"\" IgnoreHttpStatusCode=\"False\" />        </Items>    </WebTest>')]"
                },
                "SyntheticMonitorId": "[variables('pingTestName-identity')]"
            }
        },
        {
            "name": "[variables('pingTestName-csrs')]",
            "type": "Microsoft.Insights/webtests",
            "apiVersion": "2014-04-01",
            "location": "[parameters('appLocation')]",
            "dependsOn": [
            "[resourceId('Microsoft.Insights/components', parameters('appName'))]"
            ],
            "tags": {
                "[concat('hidden-link:', resourceId('Microsoft.Insights/components', parameters('appName')))]": "Resource"
            },
            "properties": {
                "Name": "[variables('pingTestName-csrs')]",
                "Description": "Basic ping test",
                "Enabled": true,
                "Frequency": 300,
                "Timeout": 120,
                "Kind": "ping",
                "RetryEnabled": true,
                "Locations": [
                {
                    "Id": "emea-nl-ams-azr"
                },
                {
                    "Id": "emea-ru-msa-edge"
                },
                {
                    "Id": "emea-se-sto-edge"
                },
                {
                    "Id": "emea-gb-db3-azr"
                }
                ],
                "Configuration": {
                "WebTest": "[concat('<WebTest   Name=\"', variables('pingTestName-csrs'), '\"   Enabled=\"True\"         CssProjectStructure=\"\"    CssIteration=\"\"  Timeout=\"120\"  WorkItemIds=\"\"         xmlns=\"http://microsoft.com/schemas/VisualStudio/TeamTest/2010\"         Description=\"\"  CredentialUserName=\"\"  CredentialPassword=\"\"         PreAuthenticate=\"True\"  Proxy=\"default\"  StopOnError=\"False\"         RecordedResultFile=\"\"  ResultsLocale=\"\">  <Items>  <Request Method=\"GET\"    Version=\"1.1\"  Url=\"', parameters('pingUrl-csrs'),   '\" ThinkTime=\"0\"  Timeout=\"300\" ParseDependentRequests=\"True\"         FollowRedirects=\"True\" RecordResult=\"True\" Cache=\"False\"         ResponseTimeGoal=\"0\"  Encoding=\"utf-8\"  ExpectedHttpStatusCode=\"200\"         ExpectedResponseUrl=\"\" ReportingName=\"\" IgnoreHttpStatusCode=\"False\" />        </Items>    </WebTest>')]"
                },
                "SyntheticMonitorId": "[variables('pingTestName-csrs')]"
            }
        },
        {
            "name": "[variables('pingTestName-xapi')]",
            "type": "Microsoft.Insights/webtests",
            "apiVersion": "2014-04-01",
            "location": "[parameters('appLocation')]",
            "dependsOn": [
            "[resourceId('Microsoft.Insights/components', parameters('appName'))]"
            ],
            "tags": {
                "[concat('hidden-link:', resourceId('Microsoft.Insights/components', parameters('appName')))]": "Resource"
            },
            "properties": {
                "Name": "[variables('pingTestName-xapi')]",
                "Description": "Basic ping test",
                "Enabled": true,
                "Frequency": 300,
                "Timeout": 120,
                "Kind": "ping",
                "RetryEnabled": true,
                "Locations": [
                {
                    "Id": "emea-nl-ams-azr"
                },
                {
                    "Id": "emea-ru-msa-edge"
                },
                {
                    "Id": "emea-se-sto-edge"
                },
                {
                    "Id": "emea-gb-db3-azr"
                }
                ],
                "Configuration": {
                "WebTest": "[concat('<WebTest   Name=\"', variables('pingTestName-xapi'), '\"   Enabled=\"True\"         CssProjectStructure=\"\"    CssIteration=\"\"  Timeout=\"120\"  WorkItemIds=\"\"         xmlns=\"http://microsoft.com/schemas/VisualStudio/TeamTest/2010\"         Description=\"\"  CredentialUserName=\"\"  CredentialPassword=\"\"         PreAuthenticate=\"True\"  Proxy=\"default\"  StopOnError=\"False\"         RecordedResultFile=\"\"  ResultsLocale=\"\">  <Items>  <Request Method=\"GET\"    Version=\"1.1\"  Url=\"', parameters('pingUrl-xapi'),   '\" ThinkTime=\"0\"  Timeout=\"300\" ParseDependentRequests=\"True\"         FollowRedirects=\"True\" RecordResult=\"True\" Cache=\"False\"         ResponseTimeGoal=\"0\"  Encoding=\"utf-8\"  ExpectedHttpStatusCode=\"200\"         ExpectedResponseUrl=\"\" ReportingName=\"\" IgnoreHttpStatusCode=\"False\" />        </Items>    </WebTest>')]"
                },
                "SyntheticMonitorId": "[variables('pingTestName-xapi')]"
            }
        },
        {
            "name": "[variables('pingAlertName-lpgUI')]",
            "type": "Microsoft.Insights/alertrules",
            "apiVersion": "2014-04-01",
            "location": "[parameters('appLocation')]",
            "dependsOn": [
                "[resourceId('Microsoft.Insights/webtests', variables('pingTestName-lpgUI'))]"
            ],
            "tags": {
                "[concat('hidden-link:', resourceId('Microsoft.Insights/components', parameters('appName')))]": "Resource",
                "[concat('hidden-link:', resourceId('Microsoft.Insights/webtests', variables('pingTestName-lpgUI')))]": "Resource"
            },
            "properties": {
                "name": "[variables('pingAlertName-lpgUI')]",
                "description": "alert for web test",
                "isEnabled": true,
                "condition": {
                    "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.LocationThresholdRuleCondition, Microsoft.WindowsAzure.Management.Mon.Client",
                    "odata.type": "Microsoft.Azure.Management.Insights.Models.LocationThresholdRuleCondition",
                    "dataSource": {
                        "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleMetricDataSource, Microsoft.WindowsAzure.Management.Mon.Client",
                        "odata.type": "Microsoft.Azure.Management.Insights.Models.RuleMetricDataSource",
                        "resourceUri": "[resourceId('microsoft.insights/webtests', variables('pingTestName-lpgUI'))]",
                        "metricName": "GSMT_AvRaW"
                    },
                    "windowSize": "PT5M",
                    "failedLocationCount": 3
                },
                "actions": [
                    {
                        "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleEmailAction, Microsoft.WindowsAzure.Management.Mon.Client",
                        "odata.type": "Microsoft.Azure.Management.Insights.Models.RuleEmailAction",
                        "sendToServiceOwners": false,
                        "customEmails": []
                    }
                ]
            }
        },
        {
            "name": "[variables('pingAlertName-identity')]",
            "type": "Microsoft.Insights/alertrules",
            "apiVersion": "2014-04-01",
            "location": "[parameters('appLocation')]",
            "dependsOn": [
                "[resourceId('Microsoft.Insights/webtests', variables('pingTestName-identity'))]"
            ],
            "tags": {
                "[concat('hidden-link:', resourceId('Microsoft.Insights/components', parameters('appName')))]": "Resource",
                "[concat('hidden-link:', resourceId('Microsoft.Insights/webtests', variables('pingTestName-identity')))]": "Resource"
            },
            "properties": {
                "name": "[variables('pingAlertName-identity')]",
                "description": "alert for web test",
                "isEnabled": true,
                "condition": {
                    "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.LocationThresholdRuleCondition, Microsoft.WindowsAzure.Management.Mon.Client",
                    "odata.type": "Microsoft.Azure.Management.Insights.Models.LocationThresholdRuleCondition",
                    "dataSource": {
                        "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleMetricDataSource, Microsoft.WindowsAzure.Management.Mon.Client",
                        "odata.type": "Microsoft.Azure.Management.Insights.Models.RuleMetricDataSource",
                        "resourceUri": "[resourceId('microsoft.insights/webtests', variables('pingTestName-identity'))]",
                        "metricName": "GSMT_AvRaW"
                    },
                    "windowSize": "PT5M",
                    "failedLocationCount": 3
                },
                "actions": [
                    {
                        "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleEmailAction, Microsoft.WindowsAzure.Management.Mon.Client",
                        "odata.type": "Microsoft.Azure.Management.Insights.Models.RuleEmailAction",
                        "sendToServiceOwners": false,
                        "customEmails": []
                    }
                ]
            }
        },
        {
            "name": "[variables('pingAlertName-csrs')]",
            "type": "Microsoft.Insights/alertrules",
            "apiVersion": "2014-04-01",
            "location": "[parameters('appLocation')]",
            "dependsOn": [
                "[resourceId('Microsoft.Insights/webtests', variables('pingTestName-csrs'))]"
            ],
            "tags": {
                "[concat('hidden-link:', resourceId('Microsoft.Insights/components', parameters('appName')))]": "Resource",
                "[concat('hidden-link:', resourceId('Microsoft.Insights/webtests', variables('pingTestName-csrs')))]": "Resource"
            },
            "properties": {
                "name": "[variables('pingAlertName-csrs')]",
                "description": "alert for web test",
                "isEnabled": true,
                "condition": {
                    "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.LocationThresholdRuleCondition, Microsoft.WindowsAzure.Management.Mon.Client",
                    "odata.type": "Microsoft.Azure.Management.Insights.Models.LocationThresholdRuleCondition",
                    "dataSource": {
                        "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleMetricDataSource, Microsoft.WindowsAzure.Management.Mon.Client",
                        "odata.type": "Microsoft.Azure.Management.Insights.Models.RuleMetricDataSource",
                        "resourceUri": "[resourceId('microsoft.insights/webtests', variables('pingTestName-identity'))]",
                        "metricName": "GSMT_AvRaW"
                    },
                    "windowSize": "PT5M",
                    "failedLocationCount": 3
                },
                "actions": [
                    {
                        "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleEmailAction, Microsoft.WindowsAzure.Management.Mon.Client",
                        "odata.type": "Microsoft.Azure.Management.Insights.Models.RuleEmailAction",
                        "sendToServiceOwners": false,
                        "customEmails": []
                    }
                ]
            }
        },
        {
            "name": "[variables('pingAlertName-xapi')]",
            "type": "Microsoft.Insights/alertrules",
            "apiVersion": "2014-04-01",
            "location": "[parameters('appLocation')]",
            "dependsOn": [
                "[resourceId('Microsoft.Insights/webtests', variables('pingTestName-xapi'))]"
            ],
            "tags": {
                "[concat('hidden-link:', resourceId('Microsoft.Insights/components', parameters('appName')))]": "Resource",
                "[concat('hidden-link:', resourceId('Microsoft.Insights/webtests', variables('pingTestName-csrs')))]": "Resource"
            },
            "properties": {
                "name": "[variables('pingAlertName-xapi')]",
                "description": "alert for web test",
                "isEnabled": true,
                "condition": {
                    "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.LocationThresholdRuleCondition, Microsoft.WindowsAzure.Management.Mon.Client",
                    "odata.type": "Microsoft.Azure.Management.Insights.Models.LocationThresholdRuleCondition",
                    "dataSource": {
                        "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleMetricDataSource, Microsoft.WindowsAzure.Management.Mon.Client",
                        "odata.type": "Microsoft.Azure.Management.Insights.Models.RuleMetricDataSource",
                        "resourceUri": "[resourceId('microsoft.insights/webtests', variables('pingTestName-identity'))]",
                        "metricName": "GSMT_AvRaW"
                    },
                    "windowSize": "PT5M",
                    "failedLocationCount": 3
                },
                "actions": [
                    {
                        "$type": "Microsoft.WindowsAzure.Management.Monitoring.Alerts.Models.RuleEmailAction, Microsoft.WindowsAzure.Management.Mon.Client",
                        "odata.type": "Microsoft.Azure.Management.Insights.Models.RuleEmailAction",
                        "sendToServiceOwners": false,
                        "customEmails": []
                    }
                ]
            }
        }
    ]
}
  DEPLOY

  deployment_mode = "Incremental"
}