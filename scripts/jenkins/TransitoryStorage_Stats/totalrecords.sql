# Total number of records in Cold Storage

use db_archiver;
select count(*) from db_archiver.statements_history;