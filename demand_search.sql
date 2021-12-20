select
	dmd.id as did,
	dmd.consumercode as dconsumercode,
	dmd.consumertype as dconsumertype,
	dmd.businessservice as dbusinessservice,
	dmd.payer,
	dmd.billexpirytime as dbillexpirytime,
	dmd.fixedBillExpiryDate as dfixedBillExpiryDate,
	dmd.taxperiodfrom as dtaxperiodfrom,
	dmd.taxperiodto as dtaxperiodto,
	dmd.minimumamountpayable as dminimumamountpayable,
	dmd.createdby as dcreatedby,
	dmd.lastmodifiedby as dlastmodifiedby,
	dmd.createdtime as dcreatedtime,
	dmd.lastmodifiedtime as dlastmodifiedtime,
	dmd.tenantid as dtenantid,
	dmd.status,
	dmd.additionaldetails as demandadditionaldetails,
	dmd.ispaymentcompleted as ispaymentcompleted,
	dmdl.id as dlid,
	dmdl.demandid as dldemandid,
	dmdl.taxheadcode as dltaxheadcode,
	dmdl.taxamount as dltaxamount,
	dmdl.collectionamount as dlcollectionamount,
	dmdl.createdby as dlcreatedby,
	dmdl.lastModifiedby as dllastModifiedby,
	dmdl.createdtime as dlcreatedtime,
	dmdl.lastModifiedtime as dllastModifiedtime,
	dmdl.tenantid as dltenantid,
	dmdl.additionaldetails as detailadditionaldetails +
from
	egbs_demand_v1 dmd
inner join egbs_demanddetail_v1 dmdl on
	dmd.id = dmdl.demandid
	and dmd.tenantid = dmdl.tenantid
where
	dmd.tenantid = 'bhubaneswar'
	and dmd.consumercode in ('')
	and dmd.taxPeriodFrom >= ''
	and dmd.taxPeriodTo <= ''
order by
	dmd.taxperiodfrom