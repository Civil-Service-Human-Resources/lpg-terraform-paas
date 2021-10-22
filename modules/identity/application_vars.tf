locals {
  application_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    APPLICATIONINSIGHTS_ROLE_NAME = var.identity_name
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.application_insights_connection_string
    DATASOURCE = var.datasource
    OAUTH_SERVICE_URL = var.authentication_service_url
    WEBSITES_PORT = var.websites_port
    WEBSITES_CONTAINER_START_TIME_LIMIT = "600"
    ENV_PROFILE = var.env_profile
    GOV_NOTIFY_API_KEY = var.gov_notify_api_key
    DOCKER_ENABLE_CI = "true"
    GOV_NOTIFY_INVITE_TEMPLATE_ID = var.gov_notify_invite_template_id
    GOV_NOTIFY_RESET_TEMPLATE_ID = var.gov_notify_reset_template_id
    GOV_NOTIFY_RESET_SUCCESSFUL_TEMPLATE_ID = var.gov_notify_reset_successful_template_id
    INVITE_SIGNUP_URL = var.invite_signup_url
    RESET_URL = var.reset_url
    REDIS_HOST = var.redis_host
    REDIS_PASSWORD = var.redis_password
    REDIS_PORT = var.redis_port
    SESSION_TIMEOUT = "3600"
    LPG_UI_URL = var.lpg_ui_url
    WHITELISTED_DOMAINS = var.whitelisted_domains
    DOCKER_REGISTRY_SERVER_URL = "https://${var.docker_registry_server_url}"
    DOCKER_REGISTRY_SERVER_USERNAME = var.docker_registry_server_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.docker_registry_server_password
    REGISTRY_SERVICE_URL = var.registry_service_url
    JWT_KEY = var.jwt_key
    INVITE_VALIDITY = var.invite_validity
    DURATION_AFTER_REREG_ALLOWED_SECONDS = var.duration_after_rereg_allowed_seconds
    MAINTENANCE_PAGE_ENABLED = var.maintenance_page_enabled
    MAINTENANCE_PAGE_CONTENT_LINE_1 = var.maintenance_page_content_line_1
    MAINTENANCE_PAGE_CONTENT_LINE_2 = var.maintenance_page_content_line_2
    MAINTENANCE_PAGE_CONTENT_LINE_3 = var.maintenance_page_content_line_3
    MAINTENANCE_PAGE_CONTENT_LINE_4 = var.maintenance_page_content_line_4
  }
}