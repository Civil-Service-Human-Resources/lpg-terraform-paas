java -jar schemaspy-6.1.0.jar -vizjs -db identity -s identity -o output/identity -norows -host "${DB_HOST}" -u "${DB_USER}" -p "${DB_PASS}"
java -jar schemaspy-6.1.0.jar -vizjs -db csrs -s csrs -o output/csrs -norows -host "${DB_HOST}" -u "${DB_USER}" -p "${DB_PASS}"
java -jar schemaspy-6.1.0.jar -vizjs -db learner_record -s learner_record -o output/learner_record -norows -host "${DB_HOST}" -u "${DB_USER}" -p "${DB_PASS}"

azcopy --source output/ --destination https://lpgdev.blob.core.windows.net/db-diagrams/output --dest-key "${STORAGEBLOBKEY}" --recursive --quiet