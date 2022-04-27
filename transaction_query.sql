select 
	txn_status, txn_status_msg,
	txn_amount, 
	gateway_txn_id, gateway_status_code, gateway_status_msg,
	consumer_code,
	to_timestamp(created_time/1000) txn_initiate_time,
	to_timestamp(last_modified_time /1000) txn_last_updated_time
from eg_pg_transactions ept 
where txn_status ='FAILURE'
and date(to_timestamp(created_time/1000)) > date(current_timestamp)-30 ;
