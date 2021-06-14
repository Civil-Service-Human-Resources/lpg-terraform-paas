###### dashboard ######

resource "azurerm_template_deployment" "service-overview-dashboard" {
    name                = "${var.env_profile}-dashboard"
    resource_group_name = var.rg_name

    template_body = <<DEPLOY
    {
        "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {},
        "variables": {
            "csrsResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.civil_servant_registry_name}')]",
            "identityResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.identity_name}')]",
            "identityManagementResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.identity_management_name}')]",
            "learningLockerApiResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.learning_locker_worker_name}')]",
            "learningLockerUiResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.learning_locker_ui_name}')]",
            "learningLockerXapiResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.learning_locker_xapi_name}')]",
            "learnerRecordResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.lpg_learner_record_name}')]",
            "learningCatalogueResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.lpg_learning_catalogue_name}')]",
            "lpgManagementResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.lpg_management_name}')]",
            "reportServiceResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.lpg_report_service_name}')]",
            "lpgUiResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.lpg_ui_name}')]",
            "notificationServiceResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/sites/', '${var.notification_service_name}')]",
            "csrsPlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.civil_servant_registry_name}')]",
            "identityPlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.identity_name}')]",
            "identityManagementPlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.identity_management_name}')]",
            "learningLockerApiPlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.learning_locker_worker_name}')]",
            "learningLockerUiPlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.learning_locker_ui_name}')]",
            "learningLockerXapiPlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.learning_locker_xapi_name}')]",
            "learnerRecordPlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.lpg_learner_record_name}')]",
            "learningCataloguePlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.lpg_learning_catalogue_name}')]",
            "lpgManagementPlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.lpg_management_name}')]",
            "reportServicePlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.lpg_report_service_name}')]",
            "lpgUiPlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.lpg_ui_name}')]",
            "notificationServicePlanResource": "[resourceId('${var.rg_name}', 'Microsoft.Web/serverFarms/', '${var.notification_service_name}')]",            
            "redisResource": "[resourceId('${var.rg_name}', 'Microsoft.Cache/Redis/', '${var.redis_name}')]",
            "redisSessionResource": "[resourceId('${var.rg_name}', 'Microsoft.Cache/Redis/', '${var.redis_name_session}')]",
            "cosmosResource": "[resourceId('${var.rg_name}', 'Microsoft.DocumentDB/databaseAccounts/', '${var.cosmos_name}')]",
            "mysqlResource": "[resourceId('${var.rg_name}', 'Microsoft.DBforMySQL/servers/', '${var.mysql_name}')]"
        },
        "resources": [
            {
                "apiVersion": "2015-08-01-preview",
                "name": "${var.env_profile}-dashboard",
                "type": "Microsoft.Portal/dashboards",
                "location": "[resourceGroup().location]",
                "tags": {
                    "environment": "${var.env_profile}",
                    "hidden-title": "${var.overview_dashboard_name}"
                },
                "properties": {
                    "lenses": {
                        "0": {
                            "order": 0,
                            "parts": {
                                "0": {
                                    "position": {
                                        "x": 0,
                                        "y": 0,
                                        "colSpan": 18,
                                        "rowSpan": 1
                                    },
                                    "metadata": {
                                        "inputs": [],
                                        "type": "Extension/HubsExtension/PartType/MarkdownPart",
                                        "settings": {
                                            "content": {
                                                "settings": {
                                                    "content": "# HTTP Responses\n---",
                                                    "title": "",
                                                    "subtitle": ""
                                                }
                                            }
                                        }
                                    }
                                },
                                "1": {
                                    "position": {
                                        "x": 0,
                                        "y": 1,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average HTTP 2xx Responses",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "Http2xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 2xx"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average HTTP 2xx Responses",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "2": {
                                    "position": {
                                        "x": 6,
                                        "y": 1,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average HTTP 4xx Responses",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "Http4xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http 4xx"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average HTTP 4xx Responses",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "3": {
                                    "position": {
                                        "x": 12,
                                        "y": 1,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average HTTP 5xx Responses",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "Http5xx",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Http Server Errors"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average HTTP 5xx Responses",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "4": {
                                    "position": {
                                        "x": 0,
                                        "y": 4,
                                        "colSpan": 18,
                                        "rowSpan": 1
                                    },
                                    "metadata": {
                                        "inputs": [],
                                        "type": "Extension/HubsExtension/PartType/MarkdownPart",
                                        "settings": {
                                            "content": {
                                                "settings": {
                                                    "content": "# App Service Plans\n---",
                                                    "title": "",
                                                    "subtitle": ""
                                                }
                                            }
                                        }
                                    }
                                },
                                "5": {
                                    "position": {
                                        "x": 0,
                                        "y": 5,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('csrsPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('identityManagementPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('identityPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerApiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerUiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerXapiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learnerRecordPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningCataloguePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('lpgManagementPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('reportServicePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('lpgUiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('notificationServicePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            }
                                                        ],
                                                        "title": "App Service Plan AVG Memory Percentage",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                },
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('csrsPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('identityManagementPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('identityPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerApiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerUiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerXapiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learnerRecordPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningCataloguePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('lpgManagementPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('reportServicePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('lpgUiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('notificationServicePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "MemoryPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory Percentage"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Memory Percentage",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 3
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "6": {
                                    "position": {
                                        "x": 6,
                                        "y": 5,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('csrsPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('identityManagementPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('identityPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerApiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerUiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerXapiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learnerRecordPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningCataloguePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('lpgManagementPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('reportServicePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('lpgUiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('notificationServicePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            }
                                                        ],
                                                        "title": "App Service Plan AVG CPU Percentage",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                },
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('csrsPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('identityManagementPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('identityPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerApiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerUiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningLockerXapiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learnerRecordPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('learningCataloguePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('lpgManagementPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('reportServicePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('lpgUiPlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[concat(variables('notificationServicePlanResource'),'serviceplan')]"
                                                                },
                                                                "name": "CpuPercentage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/serverfarms",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Percentage"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average CPU Percentage",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 3
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "7": {
                                    "position": {
                                        "x": 0,
                                        "y": 8,
                                        "colSpan": 18,
                                        "rowSpan": 1
                                    },
                                    "metadata": {
                                        "inputs": [],
                                        "type": "Extension/HubsExtension/PartType/MarkdownPart",
                                        "settings": {
                                            "content": {
                                                "settings": {
                                                    "content": "# App Services\n---",
                                                    "title": "",
                                                    "subtitle": ""
                                                }
                                            }
                                        }
                                    }
                                },
                                "8": {
                                    "position": {
                                        "x": 0,
                                        "y": 9,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average Response Time",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                },
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "AverageResponseTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average Response Time"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average Response Time",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "9": {
                                    "position": {
                                        "x": 6,
                                        "y": 9,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average CPU Time",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "CpuTime",
                                                                "aggregationType": 1,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU Time"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average CPU Time",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "10": {
                                    "position": {
                                        "x": 12,
                                        "y": 9,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Data IN",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "BytesReceived",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data In"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Data IN",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "11": {
                                    "position": {
                                        "x": 0,
                                        "y": 12,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average Requests",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "Requests",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Requests"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average Requests",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "12": {
                                    "position": {
                                        "x": 6,
                                        "y": 12,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average Memory Usage",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "AverageMemoryWorkingSet",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Average memory working set"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average Memory Usage",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "13": {
                                    "position": {
                                        "x": 12,
                                        "y": 12,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Data OUT",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('csrsResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('identityManagementResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerApiResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerUiResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningLockerXapiResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learnerRecordResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('learningCatalogueResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgManagementResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('reportServiceResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('lpgUiResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('notificationServiceResource')]"
                                                                },
                                                                "name": "BytesSent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.web/sites",
                                                                "metricVisualization": {
                                                                    "displayName": "Data Out"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Data OUT",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "14": {
                                    "position": {
                                        "x": 0,
                                        "y": 15,
                                        "colSpan": 18,
                                        "rowSpan": 1
                                    },
                                    "metadata": {
                                        "inputs": [],
                                        "type": "Extension/HubsExtension/PartType/MarkdownPart",
                                        "settings": {
                                            "content": {
                                                "settings": {
                                                    "content": "# MySQL\n---",
                                                    "title": "",
                                                    "subtitle": ""
                                                }
                                            }
                                        }
                                    }
                                },
                                "15": {
                                    "position": {
                                        "x": 0,
                                        "y": 16,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('mysqlResource')]"
                                                                },
                                                                "name": "cpu_percent",
                                                                "aggregationType": 4,
                                                                "namespace": "Microsoft.DBforMySQL/servers",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU percentage"
                                                                }
                                                            }
                                                        ],
                                                        "title": "MySQL Server AVG CPU Percentage",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                },
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('mysqlResource')]"
                                                                },
                                                                "name": "cpu_percent",
                                                                "aggregationType": 4,
                                                                "namespace": "Microsoft.DBforMySQL/servers",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU percentage"
                                                                }
                                                            }
                                                        ],
                                                        "title": "MySQL Server AVG CPU Percentage",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "16": {
                                    "position": {
                                        "x": 6,
                                        "y": 16,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('mysqlResource')]"
                                                                },
                                                                "name": "memory_percent",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.dbformysql/servers",
                                                                "metricVisualization": {
                                                                    "displayName": "Memory percent"
                                                                }
                                                            }
                                                        ],
                                                        "title": "MySQL Server Avg Memory Percentage",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                "17": {
                                    "position": {
                                        "x": 12,
                                        "y": 16,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "options",
                                                "value": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('mysqlResource')]"
                                                                },
                                                                "name": "storage",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.dbformysql/servers",
                                                                "metricVisualization": {
                                                                    "displayName": "Data space used"
                                                                }
                                                            }
                                                        ],
                                                        "title": "MySQL Database Data Space Used",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "version": 2
                                                },
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('mysqlResource')]"
                                                                },
                                                                "name": "storage_used",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.dbformysql/servers",
                                                                "metricVisualization": {
                                                                    "displayName": "Storage used"
                                                                }
                                                            }
                                                        ],
                                                        "title": "MySQL Database Data Space Used",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    },
                                                    "version": 2
                                                }
                                            }
                                        }
                                    }
                                },
                                "18": {
                                    "position": {
                                        "x": 0,
                                        "y": 19,
                                        "colSpan": 18,
                                        "rowSpan": 1
                                    },
                                    "metadata": {
                                        "inputs": [],
                                        "type": "Extension/HubsExtension/PartType/MarkdownPart",
                                        "settings": {
                                            "content": {
                                                "settings": {
                                                    "content": "# CosmosDB\n---",
                                                    "title": "",
                                                    "subtitle": ""
                                                }
                                            }
                                        }
                                    }
                                },
                                "19": {
                                    "position": {
                                        "x": 0,
                                        "y": 20,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('cosmosResource')]"
                                                                },
                                                                "name": "MongoRequests",
                                                                "aggregationType": 7,
                                                                "namespace": "microsoft.documentdb/databaseaccounts",
                                                                "metricVisualization": {
                                                                    "displayName": "Mongo Requests"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Count Mongo Requests",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        },
                                                        "grouping": {
                                                            "dimension": "CommandName",
                                                            "sort": 2,
                                                            "top": 14
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                "20": {
                                    "position": {
                                        "x": 6,
                                        "y": 20,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('cosmosResource')]"
                                                                },
                                                                "name": "TotalRequestUnits",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.documentdb/databaseaccounts",
                                                                "metricVisualization": {
                                                                    "displayName": "Total Request Units"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average Total Request Units",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                "21": {
                                    "position": {
                                        "x": 12,
                                        "y": 20,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('cosmosResource')]"
                                                                },
                                                                "name": "TotalRequests",
                                                                "aggregationType": 7,
                                                                "namespace": "microsoft.documentdb/databaseaccounts",
                                                                "metricVisualization": {
                                                                    "displayName": "Total Requests"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Count Total Requests",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                "22": {
                                    "position": {
                                        "x": 0,
                                        "y": 23,
                                        "colSpan": 18,
                                        "rowSpan": 1
                                    },
                                    "metadata": {
                                        "inputs": [],
                                        "type": "Extension/HubsExtension/PartType/MarkdownPart",
                                        "settings": {
                                            "content": {
                                                "settings": {
                                                    "content": "# Redis Cache\n---",
                                                    "title": "",
                                                    "subtitle": ""
                                                }
                                            }
                                        }
                                    }
                                },
                                "23": {
                                    "position": {
                                        "x": 0,
                                        "y": 24,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisResource')]"
                                                                },
                                                                "name": "percentProcessorTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisSessionResource')]"
                                                                },
                                                                "name": "percentProcessorTime",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "CPU"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average CPU",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                "24": {
                                    "position": {
                                        "x": 6,
                                        "y": 24,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisResource')]"
                                                                },
                                                                "name": "connectedclients",
                                                                "aggregationType": 3,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "Connected Clients"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisSessionResource')]"
                                                                },
                                                                "name": "connectedclients",
                                                                "aggregationType": 3,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "Connected Clients"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Max Connected Clients",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                "25": {
                                    "position": {
                                        "x": 12,
                                        "y": 24,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisResource')]"
                                                                },
                                                                "name": "evictedkeys",
                                                                "aggregationType": 3,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "Evicted Keys"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisSessionResource')]"
                                                                },
                                                                "name": "evictedkeys",
                                                                "aggregationType": 3,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "Evicted Keys"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Max Evicted Keys",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                "26": {
                                    "position": {
                                        "x": 0,
                                        "y": 27,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisResource')]"
                                                                },
                                                                "name": "usedmemory",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "Used Memory"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisSessionResource')]"
                                                                },
                                                                "name": "usedmemory",
                                                                "aggregationType": 4,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "Used Memory"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Average Memory",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                "27": {
                                    "position": {
                                        "x": 6,
                                        "y": 27,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisResource')]"
                                                                },
                                                                "name": "operationsPerSecond",
                                                                "aggregationType": 3,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "Operations Per Second"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisSessionResource')]"
                                                                },
                                                                "name": "operationsPerSecond",
                                                                "aggregationType": 3,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "Operations Per Second"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Max Operations Per Second",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                                "28": {
                                    "position": {
                                        "x": 12,
                                        "y": 27,
                                        "colSpan": 6,
                                        "rowSpan": 3
                                    },
                                    "metadata": {
                                        "inputs": [
                                            {
                                                "name": "options",
                                                "isOptional": true
                                            },
                                            {
                                                "name": "sharedTimeRange",
                                                "isOptional": true
                                            }
                                        ],
                                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                                        "settings": {
                                            "content": {
                                                "options": {
                                                    "chart": {
                                                        "metrics": [
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisResource')]"
                                                                },
                                                                "name": "expiredkeys",
                                                                "aggregationType": 3,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "Expired Keys"
                                                                }
                                                            },
                                                            {
                                                                "resourceMetadata": {
                                                                    "id": "[variables('redisSessionResource')]"
                                                                },
                                                                "name": "expiredkeys",
                                                                "aggregationType": 3,
                                                                "namespace": "microsoft.cache/redis",
                                                                "metricVisualization": {
                                                                    "displayName": "Expired Keys"
                                                                }
                                                            }
                                                        ],
                                                        "title": "Max Expired Keys",
                                                        "titleKind": 2,
                                                        "visualization": {
                                                            "chartType": 2,
                                                            "legendVisualization": {
                                                                "isVisible": true,
                                                                "position": 2,
                                                                "hideSubtitle": false
                                                            },
                                                            "axisVisualization": {
                                                                "x": {
                                                                    "isVisible": true,
                                                                    "axisType": 2
                                                                },
                                                                "y": {
                                                                    "isVisible": true,
                                                                    "axisType": 1
                                                                }
                                                            },
                                                            "disablePinning": true
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "metadata": {
                        "model": {
                            "timeRange": {
                                "value": {
                                    "relative": {
                                        "duration": 24,
                                        "timeUnit": 1
                                    }
                                },
                                "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
                            },
                            "filterLocale": {
                                "value": "en-us"
                            },
                            "filters": {
                                "value": {
                                    "MsPortalFx_TimeRange": {
                                        "model": {
                                            "format": "utc",
                                            "granularity": "auto",
                                            "relative": "24h"
                                        },
                                        "displayCache": {
                                            "name": "UTC Time",
                                            "value": "Past 24 hours"
                                        },
                                        "filteredPartIds": [
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7828",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d782a",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d782c",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7830",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7832",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7836",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7838",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d783a",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d783c",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d783e",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7840",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7844",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7846",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d784a",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d784c",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d784e",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7852",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7854",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7856",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d7858",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d785a",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d785c",
                                            "StartboardPart-MonitorChartPart-f83c5eeb-d975-4d7a-9c5e-76409f7d78f0"
                                        ]
                                    }
                                }
                            }
                        }
                    }
                }
            }
        ]
    }  
    DEPLOY

    deployment_mode = "Incremental"
}