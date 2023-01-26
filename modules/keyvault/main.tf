data "azurerm_client_config" "current" {}

data "azurerm_linux_web_app" "CSRSAppData" {
  name                = "lpg-${var.rg_name}-civil-servant-registry"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "IdentityAppData" {
  name                = "lpg-${var.rg_name}-identity"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "IdentityManagementAppData" {
  name                = "lpg-${var.rg_name}-identity-management"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "LearningLockerUIAppData" {
  name                = "lpg-${var.rg_name}-learning-locker-ui"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "LearningLockerWorkerAppData" {
  name                = "lpg-${var.rg_name}-learning-locker-api-worker"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "LearningLockerXapiAppData" {
  name                = "lpg-${var.rg_name}-learning-locker-xapi"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "LearnerRecordAppData" {
  name                = "lpg-${var.rg_name}-lpg-learner-record"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "LearningCatalogueAppData" {
  name                = "lpg-${var.rg_name}-lpg-learning-catalogue"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "LPGManagementAppData" {
  name                = "lpg-${var.rg_name}-lpg-management"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "ReportServiceAppData" {
  name                = "lpg-${var.rg_name}-lpg-report-service"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "LPGUIAppData" {
  name                = "lpg-${var.rg_name_lpg_ui}-lpg-ui"
  resource_group_name = var.rg_name_lpg_ui
}

data "azurerm_linux_web_app" "NotificationServiceAppData" {
  name                = "lpg-${var.rg_name}-notification-service"
  resource_group_name = var.rg_name
}

data "azuread_group" "KeyVaultUsersGroup" {
  display_name     = var.keyvault_users_group
  security_enabled = true
}

resource "azurerm_key_vault" "csl-vars-key-vault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.IdentityAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.CSRSAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.IdentityManagementAppData.identity[0].principal_id


    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.LearningLockerWorkerAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.LearningLockerUIAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.LearningLockerXapiAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.LearnerRecordAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.LearningCatalogueAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.LPGManagementAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.ReportServiceAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.LPGUIAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_linux_web_app.NotificationServiceAppData.identity[0].principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_group.KeyVaultUsersGroup.object_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get", 
      "List", 
      "Set", 
      "Delete", 
      "Recover", 
      "Backup", 
      "Restore"
    ]

    storage_permissions = [
      "Get"
    ]
  }
}