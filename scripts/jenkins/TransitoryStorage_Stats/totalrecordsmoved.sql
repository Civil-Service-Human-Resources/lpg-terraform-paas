# Total number of records moved to Cold Storage since (just before to ensure all records are captured) the job started
use db_archiver;
select count(*) from db_archiver.statements_history where inserted_date >= (select date_add(date_sub(curdate(), interval 1 day),interval '19:00' HOUR_MINUTE));