#!/usr/bin/env bash -evx

# Set the initial parameters for mysql server, needed before the container will correctly start
# Also create the initial "identity" database
# As always, Azure CLI needs to be installed and you need to be logged in
#
# Required parameters: resource group name, mysql server name
#
# Example: ./mysql_properties.sql lpgdev lpg-lpgdev-mysql

timezone=$(az mysql server configuration set -g $1 -s $2 -n time_zone --value +00:00)
slowlog=$(az mysql server configuration set -g $1 -s $2 -n slow_query_log --value on)
queriesnotusingindex=$(az mysql server configuration set -g $1 -s $2 -n log_queries_not_using_indexes --value on)
charset=$(az mysql server configuration set -g $1 -s $2 -n character_set_server --value UTF8)
