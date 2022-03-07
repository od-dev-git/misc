select * from eg_ws_meterreading mrr where id in (
select id from eg_ws_meterreading mr1
inner join 
(select m1.connectionno, max(m1.currentreadingdate) as curr  from eg_ws_meterreading m1
where m1.connectionno in (
'WS/BMC/1551791','WS/BMC/1498972','WS/BMC/1551768'
) group by m1.connectionno) mr2
on mr1.connectionno=mr2.connectionno and mr1.currentreadingdate=mr2.curr);
