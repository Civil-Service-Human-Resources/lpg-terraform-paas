#!/usr/bin/env bash -ev

# Set the initial parameters for mysql server, needed before the container will correctly start
# As always, Azure CLI needs to be installed and you need to be logged in
#
# Required parameters: resource group name, mysql server name
#
# Example: ./mysql_properties.sql lpgdev lpg-lpgdev-mysql

timezone=$(az mysql server configuration set -g $1 -s $2 -n time_zone --value +00:00)
slowlog=$(az mysql server configuration set -g $1 -s $2 -n slow_query_log --value on)
queriesnotusingindex=$(az mysql server configuration set -g $1 -s $2 -n log_queries_not_using_indexes --value on)
