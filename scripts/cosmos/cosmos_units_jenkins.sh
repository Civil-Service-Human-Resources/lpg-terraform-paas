#!/bin/bash -e

#######################################
##
## This script will update the cosmos units for all cosmos DBs based on time frame
##
## WARNING - This will only work on with Az CLI 2.0.28 currently!
##
## Usage:
## ./cosmos_units_jenkins.sh
##
## Created by:       Robert Marks
## Creation date:    2018/08/01
## Last updated:     2019/03/07
##
########################################

az login --service-principal --username "" --password "" --tenant ""

subs=$(az account list | grep -i \"id\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
read -a subsarr <<< $subs

time=$(date +%H:%M)
echo $time

intStgProdMin=400
intStgDay=1000
prodQueryBuilderCaches=7000
prodQueryBuilderCacheValues=7000
prodStatements=24000


if [[ $time > "06:59" ]] && [[ $time < "18:59" ]]; then
    echo "Scaling Up"
    for s in "${subsarr[@]}"; do

        az account set --subscription "${s}"
        collection=$(az cosmosdb list | grep -i \"name\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
        read -a col <<< $collection

        for c in "${col[@]}"; do
            g=$(echo $c | cut -d'-' -f 2)
            key=$(az cosmosdb list-keys -g ${g} -n ${c} -o tsv | awk -F ' ' '{print $1}')
            exists=$(az cosmosdb database exists --db-name admin -n ${c} --key "$key")

            if [[ "$exists" == true ]] ; then
                if [[ "$c" == "lpg-lpgprod-cosmos" ]] ; then
                    echo "admin database exists - changing RUs per collection for $c"
                    db=$(az cosmosdb collection list --db-name admin -n ${c} --key "$key" | grep -i \"id\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
                    read -a arr <<< $db

                    for i in "${arr[@]}"; do
                        if [[ "$i" == "queryBuilderCaches" ]] ; then
                        	echo "Updating $i to $prodQueryBuilderCaches RU"
                            az cosmosdb collection update --c "$i" -d admin --throughput "$prodQueryBuilderCaches" --key "$key" -n ${c} &>/dev/null
                        elif [[ "$i" == "queryBuilderCacheValues" ]] ; then
                        	echo "Updating $i to $prodQueryBuilderCacheValues RU"
                            az cosmosdb collection update --c "$i" -d admin --throughput "$prodQueryBuilderCacheValues" --key "$key" -n ${c} &>/dev/null
                        elif [[ "$i" == "statements" ]] ; then
                        	echo "Updating $i to $prodStatements RU"
                            az cosmosdb collection update --c "$i" -d admin --throughput "$prodStatements" --key "$key" -n ${c} &>/dev/null
                        else
                        	echo "Updating $i to $intStgProdMin RU"
                            az cosmosdb collection update --c "$i" -d admin --throughput "$intStgProdMin" --key "$key" -n ${c} &>/dev/null
                        fi
                    done
                else
                    echo "admin database exists - changing RUs per collection for $c"
                    db=$(az cosmosdb collection list --db-name admin -n ${c} --key "$key" | grep -i \"id\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
                    read -a arr <<< $db

                    for i in "${arr[@]}"; do
                        echo "Updating $i to $intStgDay RU"
                        az cosmosdb collection update --c "$i" -d admin --throughput "$intStgDay" --key "$key" -n ${c} &>/dev/null
                    done
                fi
             else
                echo "admin database does not exist for $c"
            fi
        done
    done
else
    echo "Scaling Down"
    for s in "${subsarr[@]}"; do

        az account set --subscription "${s}"
        collection=$(az cosmosdb list | grep -i \"name\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
        read -a col <<< $collection

        for c in "${col[@]}"; do
            g=$(echo $c | cut -d'-' -f 2)
            key=$(az cosmosdb list-keys -g ${g} -n ${c} -o tsv | awk -F ' ' '{print $1}')
            exists=$(az cosmosdb database exists --db-name admin -n ${c} --key "$key")

            if [[ "$exists" == true ]] ; then
                echo "admin database exists - changing RUs per collection for $c"
                db=$(az cosmosdb collection list --db-name admin -n ${c} --key "$key" | grep -i \"id\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
                read -a arr <<< $db

                for i in "${arr[@]}"; do
                    echo "Updating $i to $intStgProdMin RU"
                    az cosmosdb collection update --c "$i" -d admin --throughput "$intStgProdMin" --key "$key" -n ${c} &>/dev/null
                done
             else
                echo "admin database does not exist for $c"
            fi
        done
    done
fi
