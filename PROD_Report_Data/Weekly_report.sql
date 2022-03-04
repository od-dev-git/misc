-- BPA application Report
select
	initcap(split_part(tenantid,'.',2)) as ulb,
	applicationno,
	businessservice,
	case
		when createdtime >0 then to_timestamp(createdtime / 1000)::date 
	end as createdtime,
	case
		when applicationdate >0 then to_timestamp(applicationdate / 1000)::date
	end as applicationdate,
	status,
	approvalno,
	case
		when approvaldate >0 then to_timestamp(approvaldate / 1000)::date
	end as approvaldate
from
	eg_bpa_buildingplan;
	
-- Collection Report
select
	initcap(split_part(tenantid,'.',2)) as ulb
	, to_timestamp(receiptdate/1000)::date as receiptdate
	, receiptnumber
	, to_timestamp(createdtime/1000)::date as createdtime
	, amountpaid
	, case
	   when businessservice='WS.ONE_TIME_FEE' then 'WS Application Fee'
	   when businessservice='WS' then 'WS Monthly Fee'
	   when businessservice='BPA.NC_SAN_FEE' then 'BPA Sanction Fee'
	   when businessservice='BPA.NC_APP_FEE' then 'BPA Application Fee'
	   when businessservice='PT.MUTATION' then 'PT Mutation Fee'
	   when businessservice='PT' then 'Property Tax'
	 end as feeType
from egcl_paymentdetail ep
where businessservice in ('WS', 'WS.ONE_TIME_FEE', 'BPA.NC_SAN_FEE','BPA.NC_APP_FEE', 'PT.MUTATION', 'PT');

-- WNS application Report
-- For other than new Connection on all connection
select
	initcap(split_part(tenantid,'.',2)) as ulb
	, applicationno
	, applicationstatus
	, connectionno
	, to_timestamp(createdtime/1000)::date as createddate
	, to_timestamp(lastmodifiedtime/1000)::date as lastmodifieddate
	, case
	   when applicationtype='NEW_WATER_CONNECTION' then 'New Connection'
	   when applicationtype='CONNECTION_OWNERSHIP_CHANGE' then 'Ownership Change'
	   when applicationtype='DISCONNECT_WATER_CONNECTION' then 'Disconnection'
	   when applicationtype='WATER_RECONNECTION' then 'Re-connection'
	   when applicationtype='MODIFY_WATER_CONNECTION' then 'Modify Connection'
	   when applicationtype='CLOSE_WATER_CONNECTION' then 'Close Connection'
	  end as applicationtype
	, additionaldetails ->> 'ward' as Ward
from eg_ws_connection
where 
applicationtype not in ('NEW_WATER_CONNECTION');

-- For new Connection other than migrated connection
select
	initcap(split_part(tenantid,'.',2)) as ulb
	, applicationno
	, applicationstatus
	, connectionno
	, to_timestamp(createdtime/1000)::date as createddate
	, to_timestamp(lastmodifiedtime/1000)::date as lastmodifieddate
	, case
	   when applicationtype='NEW_WATER_CONNECTION' then 'New Connection'
	   when applicationtype='CONNECTION_OWNERSHIP_CHANGE' then 'Ownership Change'
	   when applicationtype='DISCONNECT_WATER_CONNECTION' then 'Disconnection'
	   when applicationtype='WATER_RECONNECTION' then 'Re-connection'
	   when applicationtype='MODIFY_WATER_CONNECTION' then 'Modify Connection'
	   when applicationtype='CLOSE_WATER_CONNECTION' then 'Close Connection'
	  end as applicationtype
	, additionaldetails ->> 'ward' as Ward
from eg_ws_connection
where oldconnectionno is null
and applicationtype in ('NEW_WATER_CONNECTION');

-- PT application report
select 
initcap(split_part(epp.tenantid,'.',2)) as ulb,
ward,
epp.propertyid ,
epp.oldpropertyid ,
epp.acknowldgementnumber,
case
  when propertytype='BUILTUP.SHAREDPROPERTY' then 'Shared Property'
  when propertytype='VACANT' then 'Vacant Land'
  when propertytype='BUILTUP.INDEPENDENTPROPERTY' then 'Independent Property'
end as propertytype,
case
  when usagecategory='NONRESIDENTIAL.COMMERCIAL' then 'Non Residentials Commercial'
  when usagecategory='MIXED' then 'Mixed'
  when usagecategory='RESIDENTIAL' then 'Independent Property'
  when usagecategory='NONRESIDENTIAL.INSTITUTIONAL' then 'Non Residentials Institutional'
  when usagecategory='NONRESIDENTIAL.INDUSTRIAL' then 'Non Residentials Industrial'
  when usagecategory='NONRESIDENTIAL.OTHERS' then 'Non Residentials Others'
  when usagecategory='RESIDENTIAL' then 'Independent Property'
end as usagecategory,
epp.creationreason,
epp.status,
to_timestamp(epp.createdtime/1000)::date as createdtime
from eg_pt_property epp
join eg_pt_address epa on epa.propertyid = epp.id 
where to_timestamp(epp.createdtime/1000)::date > '2021-11-01'
and epp.oldpropertyid is null
order by epp.createdtime;


-- PT Assessment report
select 
initcap(split_part(epaa.tenantid,'.',2)) as ulb,ward,
epaa.assessmentnumber,
to_timestamp(epaa.assessmentdate/1000)::date as assessmentdate,
to_timestamp(epaa.createdtime/1000)::date as createdtime,
epaa.financialyear,
epaa.status
from eg_pt_asmt_assessment epaa
join eg_pt_property epp on epaa.propertyid  = epp.propertyid 
join eg_pt_address epa on epa.propertyid = epp.id
where to_timestamp(epaa.createdtime/1000)::date > '2021-11-01'
order by epaa.createdtime;


