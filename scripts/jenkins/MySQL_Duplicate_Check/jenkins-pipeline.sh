pipeline {
    agent { label 'master' }
    
    stages {
        stage('Run SQL Query') {
            steps{
                sh '''#!/bin/bash
                 result=$(mysql --defaults-file=/home/myperf.cnf < /home/query.sql)

                if [ "$result" == "" ]; then
                    echo "There are no duplicates"
                    exit 0
                else
                    echo "There are duplicate entries"
                    clear=$(mysql --defaults-file=/home/myperf.cnf < /home/duplicatefix.sql)
                    echo "Duplicate entries have been cleared."
                    echo $clear
                    exit 1
                fi
                '''
            }
        }
    }
}