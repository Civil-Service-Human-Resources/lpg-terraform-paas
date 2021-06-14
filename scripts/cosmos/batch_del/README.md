# Mongo scripts to batch update statements collection in batch

## Requires

* Node (only for generating module list)
* Mongo CLI (see [here](https://dba.stackexchange.com/questions/196330/is-it-possible-to-install-just-the-mongo-shell) to install by homebrew)

## Scripts

* modules.js - list of modules to include in query
* dates.js - list of from/to dates to iterate query over to run in batches
* query.js - mongo query to execute against Mongo DB
* batch-delete.js - mongo query to delete elearning experienced statements
* generate-elearning-modules-list.js - Javascript to take raw course data JSON (taken from ElasticSearch) and extract the list of elearning modules

## Run

1. Generate modules list via `node generate-elearning-modules-list.js <course.json>`
2. Update dates.js for the date ranges you wish to batch process statements.
3. Update modules.js for the list of modules (url as recorded in statement) to the modules to wish query to include.
4. Run the command below with connection details set for DB (can get from Portal "Connection Strings")

```
# get counts
mongo --host XXX.documents.azure.com --port 10255 --username XXX --password YYY --ssl dates.js modules.js query.js

# batch delete
mongo --host XXX.documents.azure.com --port 10255 --username XXX --password YYY --ssl dates.js modules.js batch-delete.js
```

## Notes

* Batch delete size is set to 1000 to avoid timeouts