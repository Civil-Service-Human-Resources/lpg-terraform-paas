variable "subscription_name" {
	type = string
	description = "Subscription to apply the update to"
	default = "CSL-Staging"
}

variable "rg_name" {
	default = "lpgintegration"
}

variable "rg_prefix" {
	default =  "lpg"
}

variable "rg_location" {
	default =  "UK South"
}

variable "serviceplan_suffix_lpgui" {
	default =  ""
}

variable "domain" {
	default =  "integration.learn.civilservice.gov.uk"
}

variable "env_profile" {
	default =  "integration"
}

## Redis

variable "redis_session_capacity" {
	default =  "0"
}

variable "redis_session_family" {
	default =  "C"
}

variable "redis_org_capacity" {
	default =  "0"
}

variable "redis_org_family" {
	default =  "C"
}

variable "redis_csl_service_capacity" {
	default =  "0"
}

variable "redis_csl_service_family" {
	default =  "C"
}

## Identity

variable "identity_horizontal_scale" {
	default = 1
}

variable "identity_vertical_scale" {
	default = "P1v2"
}

## Learner record

variable "learner_record_horizontal_scale" {
	default = 1
}

variable "learner_record_vertical_scale" {
	default = "P1v2"
}

## LPG-services

variable "lpg_ui_horizontal_scale" {
	default = 1
}

variable "lpg_ui_vertical_scale" {
	default = "P1v2"
}

## Learning catalogue

variable "learning_catalogue_horizontal_scale" {
	default = 1
}

variable "learning_catalogue_vertical_scale" {
	default = "P1v2"
}

variable "mysql_name_gp" {
	default =  "gp"
}

variable "mysql_storage" {
	default =  "4194304"
}

## CSRS

variable "civil_servant_registry_horizontal_scale" {
	default = 1
}

variable "civil_servant_registry_vertical_scale" {
	default = "P1v2"
}

## Report service

variable "report_service_horizontal_scale" {
	default = 1
}

variable "report_service_vertical_scale" {
	default = "P1v2"
}

## Identity management

variable "identity_management_horizontal_scale" {
	default = 1
}

variable "identity_management_vertical_scale" {
	default = "P1v2"
}

## LPG-management

variable "lpg_management_horizontal_scale" {
	default = 1
}

variable "lpg_management_vertical_scale" {
	default = "P1v2"
}

variable "content_container" {
	default =  "lpgdevcontent"
}

## Notification service

variable notification_service_horizontal_scale {
	type = number
	default = 1
}

variable notification_service_vertical_scale {
	type = string
	default = "P1v2"
}

## CSL-Service ##

variable "csl_service_vertical_scale" {
	type = string
	default = "P1v2"
}

variable "csl_service_horizontal_scale" {
	type = number
	default = 1
}

## Postgres ##

variable "pg_database_sku" {
	type = string
	default = "B_Standard_B1ms"
}

variable "pg_database_size_mb" {
	type = number
	default = 32768
}


## Rustici ##

variable "rustici_engine_vertical_scale" {
	type = string
	default = "P1v2"
}

variable "rustici_engine_horizontal_scale" {
	type = string
	default = 1
}

variable "rustici_mysql_size_gb" {
	type = string
	default = 20
}

variable "rustici_mysql_sku" {
	type = string
	default = "GP_Standard_D2ds_v4"
}

## APP COMMAND LINES ##

variable "learner_record_app_command_line" {
	type = string
	default = "java -Xmx256m -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "identity_app_command_line" {
	type = string
	default = "java -Xmx256m -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "report_service_app_command_line" {
	type = string
	default = "java -Xmx256m -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "learning_catalogue_app_command_line" {
	type = string
	default = "java -Xmx256m -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "civil_servant_registry_app_command_line" {
	type = string
	default = "java -Xmx256m -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "notification_service_app_command_line" {
	type = string
	default = "java -Xmx256m -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "csl_service_app_command_line" {
	type = string
	default = "java -Xmx256m -javaagent:/opt/appinsights/applicationinsights-agent-3.4.4.jar -jar /data/app.jar"
}
