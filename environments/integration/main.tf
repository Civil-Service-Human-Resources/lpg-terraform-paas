module "integration-environment" {
    source = "../master"
    rg_name = "lpgintegration"
    rg_name_lpg_ui =  "lpgintegration"
    rg_prefix =  "lpg"
    rg_location =  "UK South"
    serviceplan_suffix =  "serviceplan"
    serviceplan_suffix_lpgui =  "serviceplan"
    webapp_sku_tier =  "Basic"
    webapp_sku_tier_p2 =  "PremiumV2"
    webapp_sku_name_1 =  "B1"
    webapp_sku_name_2 =  "B2"
    webapp_sku_name_3 =  "B3"
    webapp_sku_name_p1 =  "P1v2"
    webapp_sku_name_p2 =  "P1v2"
    webapp_sku_name_p3 =  "P1v2"
    identity_capacity =  "2"
    csrs_capacity =  "1"
    xapi_capacity =  "1"
    learner_record_capacity =  "1"
    learning_catalogue_capacity =  "1"
    lpg_ui_capacity =  "2"
    notification_capacity =  "1"
    lpg_management_capacity =  "1"
    envurl =  ""
    domain =  "integration.learn.civilservice.gov.uk"
    scaling_enabled =  "false"
    env_profile =  "integration"
    google_analytics_id =  "UA-22141655-3"

    cosmos_name =  "cosmos"
    cosmos_offer_type =  "Standard"
    cosmos_consistency_policy_level =  "Strong"
    cosmos_failover_policy_location =  "West Europe"

    redis_queue_provider =  "REDIS"
    redis_queue_namespace =  "learninglocker"
    redis_prefix =  "learninglocker"
    redis_use_tls =  "1"
    redis_capacity =  "0"
    redis_session_capacity =  "0"
    redis_org_capacity =  "0"

    identity_name =  "identity"

    lpg_learner_record_name =  "lpg-learner-record"
    lpg_learner_record_websites_port =  "9000"
    learner_record_command_line =  "java -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"

    lpg_testing =  "1"

    lpg_learning_locker_xapi_name =  "learning-locker-xapi"
    ll_xapi_express_port =  "8083"

    lpg_learning_locker_worker_name =  "learning-locker-api-worker"
    worker_api_env_app =  "learning-locker-api-worker"

    lpg_learning_locker_ui_name =  "learning-locker-ui"
    lpg_learning_locker_api_port =  "8082"
    ll_ui_port =  "80"

    lpg_ui_name =  "lpg-ui"
    ui_websites_port =  "3001"
    ui_server_timeout_ms =  "235000"
    ui_static_asset_ttl =  "86400000"
    ui_static_asset_root =  "https://asset-cdn.integration.learn.civilservice.gov.uk"

    lpg_learning_catalogue_name =  "lpg-learning-catalogue"
    azure_account_name =  "lpgdev"

    mysql_name_gp =  "gp"

    mysql_name_ll =  "ll"
    mysql_storage =  "4194304"

    civil_servant_registry_name =  "civil-servant-registry"
    agency_token_max_capacity =  "5000"
    agency_token_min_capacity =  "1"
    lpg_report_service_name =  "lpg-report-service"
    report_service_websites_port =  "9004"
    report_service_command_line =  "java -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
    spring_profiles_active =  "test,production"

    identity_management_data_retention_cron_schedule =  "0 0 5 * * *"
    identity_management_data_retention_enabled =  "true"### lpg-management ###
    lpg_management_name =  "lpg-management"
    lpg_management_websites_port =  "3005"
    content_container =  "lpgdevcontent"
    lpg_management_report_service_timeout_ms =  "235000"
    lpg_management_request_timeout_ms =  "60000"
    lpg_management_server_timeout_ms =  "235000"
    lpg_management_authentication_service_timeout_ms =  "60000"
    lpg_management_youtube_timeout_ms =  "60000"
    lpg_management_course_catalogue_timeout_ms =  "60000"
    lpg_management_learner_record_timeout_ms =  "60000"
    lpg_management_civil_servant_registry_service_timeout_ms =  "60000"

    notification_service_name =  "notification-service"

    data_transchiver_name =  "lpg-data-transchriver"
    job_schedule =  "0 1 21 * * *"
    invite_validity =  "259200"
    duration_after_rereg_allowed_seconds =  "86400"
    maintenance_page_enabled =  "false"
    maintenance_page_content_line_1 =  "The learning website is undergoing scheduled maintenance."
    maintenance_page_content_line_2 =  "It will be unavailable between the hours of 7pm to 9pm on Wednesday 24th February 2021."
    maintenance_page_content_line_3 =  "Apologies for the inconvenience."
    maintenance_page_content_line_4 =  "If the maintenance period is extended, further information will be provided here."
    backend_api_call_batch_size =  "50"
    identity_base_url =  "https://identity.integration.learn.civilservice.gov.uk"

    vaultresourcegroup = "lpg-prod-keyvault"
    vaultname = "lpg-prod-kv"
    custom_emails = "robertm@kainos.com"

    docker_registry_server_url = "lpgregistry.azurecr.io"

    existingkeyvaultsecretname ="star-integration-learn-civil-service-gov-uk-pfxsecret-2022"
    certificatename = "star-integration-learn-civil-service-gov-uk-2022"
    ui_existingkeyvaultsecretname = "star-integration-learn-civil-service-gov-uk-pfxsecret-2022"
    identity_management_name = "identity-management"
}