select
	INITCAP(SPLIT_PART(ep.tenantid, '.', 2)) as ULB,
	ce.username empuserid,
	ce."name" empname,
	'Water' as head,
	to_char(to_timestamp(ep.transactiondate / 1000), 'DD-Mon-YYYY HH:mm:SS') as paymentdate,
	ep.paymentmode,
	ep2.receiptnumber,
	ep2.amountpaid,
	ep2.businessservice as businessservice,
	ebv.consumercode as ApplicationOrConsumerNo
from
	egcl_payment ep
inner join egcl_paymentdetail ep2 on
	ep2.paymentid = ep.id
inner join eg_user ce on
	ce.id = cast(ep.createdby as INTEGER)
inner join egcl_bill ebv on
	ep2.billid = ebv.id
where
	ep2.businessservice like 'WS%'
	and ce."type" = 'EMPLOYEE'
	AND ep2.tenantid = 'od.puri'
	AND date(to_timestamp(ep.transactiondate/1000)) = date('2022-01-20')+1
	AND ep.paymentmode = 'ONLINE';
	
