-- Meter reading to delete for OTHERS usageCategory logged from 9-SEP-2021
delete from eg_ws_meterreading where
id not in (select distinct on (connectionno) id from eg_ws_meterreading order by connectionno, currentreadingdate)
and connectionno in (select distinct connectionno from eg_ws_connection where id in (
select connection_id from eg_ws_service where usagecategory='OTHERS')
and isoldapplication=false and applicationstatus='CONNECTION_ACTIVATED')
and date(to_timestamp(currentreadingdate/1000)) >= to_date('2021-09-09', 'yyyy-MM-dd');

-- Update OTHERS to BPL
update eg_ws_service set usagecategory='BPL' where connection_id in (
select ews.connection_id
from eg_ws_connection ewc
	inner join eg_ws_service ews on ews.connection_id=ewc.id
where ews.usagecategory='OTHERS'
	and ewc.isoldapplication=false
	and ewc.applicationstatus='CONNECTION_ACTIVATED');
