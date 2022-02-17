-- update connection execution date and set to 1st Aug if have after 1st Aug date
update eg_ws_service
set connectionexecutiondate=1627815600000
where connection_id in (select id from eg_ws_connection
where oldconnectionno is not null)
and connectionexecutiondate>1627815600000;
