select count(*) from egbs_demand_v1 
where businessservice='WS' 
and tenantid='od.angul';


select * from egbs_demand_v1 where consumercode='PT-RRG-510457';

select * from egbs_demanddetail_v1 where demandid in (select id from egbs_demand_v1 where consumercode='PT-RRG-510457');

select * from egcl_paymentdetail where receiptnumber = '11/2021-22/001491';

--456bbda6-ae13-496c-95c8-29fbf7602b00
select * from egcl_bill where id = '456bbda6-ae13-496c-95c8-29fbf7602b00';

select * from egbs_billdetail_v1 where billid = '456bbda6-ae13-496c-95c8-29fbf7602b00';

select * from egcl_billdetial where billid = '456bbda6-ae13-496c-95c8-29fbf7602b00';

select * from egbs_bill_v1 where id = '456bbda6-ae13-496c-95c8-29fbf7602b00';



select count(*) from egbs_demand_v1 
where businessservice='WS' 
and tenantid='od.attabira';

select * from egbs_demand_v1 where consumercode='PT-RRG-510457';

select * from egbs_demanddetail_v1 where demandid in (select id from egbs_demand_v1 where consumercode='PT-RRG-510457');

select * from egcl_paymentdetail where receiptnumber = '11/2021-22/001491';

--456bbda6-ae13-496c-95c8-29fbf7602b00
select * from egcl_bill where id = '456bbda6-ae13-496c-95c8-29fbf7602b00';

select * from egbs_billdetail_v1 where billid = '456bbda6-ae13-496c-95c8-29fbf7602b00';

select * from egcl_billdetial where billid = '456bbda6-ae13-496c-95c8-29fbf7602b00';

select * from egbs_bill_v1 where id = '456bbda6-ae13-496c-95c8-29fbf7602b00';

select count(*) from eg_pt_property where tenantid='od.chatrapur' and status='ACTIVE';

select * from eg_pt_property where oldpropertyid='005000070' and tenantid='od.chatrapur';

select * from eg_pt_address where propertyid='d1ca15b2-dc73-4fa2-a543-2bc1f5f8a74b';

select * from eg_pt_owner epo
left outer join eg_user eu on epo.userid=eu.uuid
where
--epo.tenantid='od.chatrapur'
eu.username is null;

select tenantid, count(*) from eg_pt_address where ward is null group by tenantid;

=====================================================================================

select
	tenantid,
	applicationno,
	businessservice,
	to_timestamp(createdtime / 1000)::date as createdtime,
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

-------------------------------------------------------------------------------------------------------------
select
	tenantid,
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


-----------------------------------------------------------------------------------------------------

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
	and dmd.consumercode in ('WS/BMC/1467124')
	and dmd.taxPeriodFrom >= '1635724800000'
	and dmd.taxPeriodTo <= '1638296940000'
order by
	dmd.taxperiodfrom
=========================================================

select
	INITCAP(SPLIT_PART(EWC.TENANTID, '.', 2))as ULB,
	EWC.ADDITIONALDETAILS ->> 'ward' as WARD,
	name,
	mobilenumber,
	address,
	EWC.CONNECTIONNO,
	EWC.OLDCONNECTIONNO,
	ews.connectiontype,
	DM.DEMANDCREATIONDATE,
	DM.MONTHOFTAXPERIODTO,
	DM.TAXPERIODFROM,
	DM.TAXPERIODTO,
	DM.DEMANDID,
	DM.TAXAMOUNT as CURRENTDEMAND,
	DM.COLLECTIONAMOUNT as collectionamount,
	coalesce(arreardtl.totalcollectableinarrears, 0) - coalesce(arreardtl.totalcollectedinarrears, 0) as arrear,
	DM.REBATEAMOUNT,
	DM.PENALTYAMOUNT,
	-DM.ADVANCEAMOUNT as ADVANCEAMOUNT ,
	case
		when (DM.TAXAMOUNT-DM.COLLECTIONAMOUNT + DM.PENALTYAMOUNT + DM.ADVANCEAMOUNT + coalesce(arreardtl.totalcollectableinarrears, 0) - coalesce(arreardtl.totalcollectedinarrears, 0))>0 then DM.TAXAMOUNT-DM.COLLECTIONAMOUNT + DM.PENALTYAMOUNT + DM.ADVANCEAMOUNT + coalesce(arreardtl.totalcollectableinarrears, 0) - coalesce(arreardtl.totalcollectedinarrears, 0)
		else 0
	end as TOTALDUE,
	case
		when (round(((DM.TAXAMOUNT-DM.COLLECTIONAMOUNT)* 0.98)+ DM.ADVANCEAMOUNT + DM.REBATEAMOUNT + coalesce(arreardtl.totalcollectableinarrears, 0) - coalesce(arreardtl.totalcollectedinarrears, 0))) >0 then round(((DM.TAXAMOUNT-DM.COLLECTIONAMOUNT)* 0.98)+ DM.ADVANCEAMOUNT + DM.REBATEAMOUNT + coalesce(arreardtl.totalcollectableinarrears, 0) - coalesce(arreardtl.totalcollectedinarrears, 0))
		else 0
	end as AMOUNTBEFOREDUEDATE,
	case
		when (round(((DM.TAXAMOUNT-DM.COLLECTIONAMOUNT)* 1.05)+ DM.ADVANCEAMOUNT + DM.PENALTYAMOUNT + coalesce(arreardtl.totalcollectableinarrears, 0) - coalesce(arreardtl.totalcollectedinarrears, 0)))>0 then round(((DM.TAXAMOUNT-DM.COLLECTIONAMOUNT)* 1.05)+ DM.ADVANCEAMOUNT + DM.PENALTYAMOUNT + coalesce(arreardtl.totalcollectableinarrears, 0) - coalesce(arreardtl.totalcollectedinarrears, 0))
		else 0
	end as AMOUNTAFTERDUEDATE
from
	EG_WS_CONNECTION EWC
inner join EG_WS_SERVICE EWS on
	EWC.ID = EWS.CONNECTION_ID
left outer join(
	select
		edv.consumercode,
		to_char(to_timestamp(edv.createdtime / 1000), 'DD-MM-YYYY')as DemandCreationDate,
		TO_CHAR(to_timestamp(edv.taxperiodto / 1000), 'Mon')as MONTHOFTAXPERIODTO,
		to_char(to_timestamp(edv.taxperiodfrom / 1000), 'DD-MM-YYYY')as TaxPeriodFrom,
		to_timestamp(edv.taxperiodto / 1000)as formattedtaxperiodto,
		to_char(to_timestamp(edv.taxperiodto / 1000), 'DD-MM-YYYY')as TaxPeriodTo,
		edv2.demandid,
		edv2.taxamount,
		edv2.collectionamount,
		edv2.rebateamount,
		edv2.penaltyamount,
		edv2.advanceamount,
		edv.status,
		edv.businessservice
	from
		EGBS_DEMAND_V1 EDV
	inner join(
		select
			egb1.demandid,
			egb1.taxheadcode,
			egb1.taxamount,
			coalesce(egb1.collectionamount, 0) as collectionamount,
			coalesce(egb2.rebateamount, 0)as rebateamount,
			coalesce(egb3.penaltyamount, 0)as penaltyamount,
			coalesce(egb4.advanceamount, 0)as advanceamount
		from
			egbs_demanddetail_v1 egb1
		left join(
			select
				demandid,
				taxamount as rebateamount
			from
				egbs_demanddetail_v1
			where
				taxheadcode = 'WS_TIME_REBATE'
				and tenantid = 'od.bhubaneswar')egb2 on
			egb1.demandid = egb2.demandid
		left join(
			select
				demandid,
				taxamount as penaltyamount
			from
				egbs_demanddetail_v1
			where
				taxheadcode = 'WS_TIME_PENALTY'
				and tenantid = 'od.bhubaneswar')egb3 on
			egb1.demandid = egb3.demandid
		left join(
			select
				demandid,
				taxamount as advanceamount
			from
				egbs_demanddetail_v1
			where
				taxheadcode = 'WS_ADVANCE_CARRYFORWARD'
				and tenantid = 'od.bhubaneswar')egb4 on
			egb1.demandid = egb4.demandid
		where
			egb1.taxheadcode = 'WS_CHARGE'
			and egb1.tenantid = 'od.bhubaneswar')edv2 on
		EDV.ID = EDV2.DEMANDID)DM on
	EWC.connectionno = DM.CONSUMERCODE
left outer join(
	select
		consumercode,
		sum(totaltaxamt)as totalcollectableinarrears,
		sum(totalcollectedamt)as totalcollectedinarrears
	from
		egbs_demand_v1 egdm1
	inner join(
		select
			d_detail.DEMANDID,
			SUM(d_detail.TAXAMOUNT)as TOTALTAXAMT,
			SUM(d_detail.COLLECTIONAMOUNT)as TOTALCOLLECTEDAMT
		from
			EGBS_DEMANDDETAIL_V1 d_detail
			--,egbs_demand_v1 dd
		where
			--dd.id = d_detail.demandid
			--and 
			d_detail.tenantid = 'od.bhubaneswar'
			and d_detail.taxheadcode like 'WS%'
			--and dd.tenantid = 'od.bhubaneswar'
		group by
			d_detail.DEMANDID)egdd1 on
		egdm1.id = egdd1.demandid
	where
		date(to_timestamp(taxperiodto / 1000))< date('2021-11-01')
		and ispaymentcompleted = false
		and businessservice = 'WS'
		and STATUS = 'ACTIVE'
		and tenantid = 'od.bhubaneswar'
	group by
		consumercode)arreardtl on
	EWC.connectionno = arreardtl.consumercode
left outer join(
	select
		name,
		mobilenumber,
		address,
		connectionid
	from
		eg_ws_connectionholder ewch
	inner join(
		select
			name,
			mobilenumber,
			address,
			egu.uuid
		from
			eg_user egu
		inner join eg_user_address eguad on
			eguad.userid = egu.id
		where
			eguad.type = 'CORRESPONDENCE')usr on
		ewch.userid = usr.uuid)conholder on
	ewc.id = conholder.connectionid
where
	EWC.APPLICATIONSTATUS = 'CONNECTION_ACTIVATED'
	and DM.STATUS = 'ACTIVE'
	and DM.BUSINESSSERVICE = 'WS'
	and ewc.tenantid = 'od.bhubaneswar'
	and ews.connectiontype = 'Non Metered'
	and
	case
		when LOWER('01') = 'nil' then EWC.ADDITIONALDETAILS ->> 'ward' is null
		else EWC.ADDITIONALDETAILS ->> 'ward' = '33'
	end
	and (date(formattedtaxperiodto) >= date('2021-11-01')
	and date(formattedtaxperiodto) <= date('2021-11-30'));


======================================================================

BPA Production Issue Queries
===================================
-- Application status
select * from eg_bpa_buildingplan ebb where applicationno ='BP-RRK-2021-12-15-000197';


-- Workflow status
select * from eg_wf_processinstance_v2 ewpv where businessid ='BP-RRK-2021-12-15-000197';

-- Bill details
select * from egbs_billdetail_v1 ebv where consumercode ='BP-RRK-2021-12-15-000197';

-- Payment status
select * from egcl_payment ep where id in (select paymentid from egcl_paymentdetail ep where receiptnumber ='12/2021-22/005397') ;
select * from egcl_paymentdetail ep where receiptnumber ='12/2021-22/005397';

---NOC Query---
select * from public.eg_noc en where sourcerefid ='BPA APPlication id'
delete from public.eg_noc where sourcerefid ='BPA APPlication id'

-- Application status
select applicationno, status, lastmodifiedtime, businessservice from eg_bpa_buildingplan ebb where applicationno ='BP-RRK-2021-12-15-000197';

-- Workflow status
select businessservice , businessid, "action" from eg_wf_processinstance_v2 ewpv where businessid ='BP-RRK-2021-12-15-000197';

--Demand
select consumercode, businessservice, ispaymentcompleted from egbs_demand_v1 edv where consumercode ='BP-RRK-2021-12-15-000197';
select demandid, taxheadcode, taxamount, collectionamount from egbs_demanddetail_v1 edv where demandid in (select id from egbs_demand_v1 edv where consumercode ='BP-RRK-2021-12-15-000197');

--========================================================================

-- Status uuid will come from here
select uuid from eg_wf_state_v2 ewsv where businessserviceid =(select uuid from eg_wf_businessservice_v2 ewbv where businessservice='BPA1') and state='DOC_VERIFICATION_PENDING';

-- Insert the workflow
-- Assigner keep same as previous
INSERT INTO eg_wf_processinstance_v2 (id,tenantid,businessservice,businessid,"action",status,"comment",assigner,assignee,statesla,previousstatus,createdby,lastmodifiedby,createdtime,lastmodifiedtime,modulename,businessservicesla,rating) values
('1cd7071b-6854-4ce4-8821-c642d08f37d9','od.rourkela','BPA1','BP-RRK-2021-12-15-000197','PAY','a5bb57a7-5154-4d3f-a94f-a7d2db265dd5',NULL,'0d2957d0-4736-4b49-8640-1605e5d0a041',NULL,NULL,NULL,'0d2957d0-4736-4b49-8640-1605e5d0a041','0d2957d0-4736-4b49-8640-1605e5d0a041',1640329362000,1640329362000,'bpa-services',5181630506,NULL);

-- Update application
update eg_bpa_buildingplan set status='DOC_VERIFICATION_INPROGRESS' where applicationno ='BP-RRK-2021-12-15-000197';

--========================================================
select
	INITCAP(SPLIT_PART(EWC.TENANTID, '.', 2))as ULB,
	EWC.ADDITIONALDETAILS ->> 'ward' as WARD,
	name,
	mobilenumber,
	address,
	EWC.CONNECTIONNO,
	EWC.OLDCONNECTIONNO,
	ews.connectiontype,
	DM.DEMANDCREATIONDATE,
	DM.MONTHOFTAXPERIODTO,
	DM.TAXPERIODFROM,
	DM.TAXPERIODTO,
	DM.DEMANDID,
	DM.CURRENTDEMAND as CURRENTDEMAND,
	coalesce(arreardtl.totalcollectableinarrears, 0) - coalesce(arreardtl.totalcollectedinarrears, 0) as arrear,
	case
		when (DM.CURRENTDEMAND + coalesce(arreardtl.totalcollectableinarrears, 0) - coalesce(arreardtl.totalcollectedinarrears, 0))>0 then DM.CURRENTDEMAND + coalesce(arreardtl.totalcollectableinarrears, 0) - coalesce(arreardtl.totalcollectedinarrears, 0)
		else 0
	end as TOTALDUE
from
	EG_WS_CONNECTION EWC
inner join EG_WS_SERVICE EWS on
	EWC.ID = EWS.CONNECTION_ID
left outer join(
	select
		edv.consumercode,
		to_char(to_timestamp(edv.createdtime / 1000), 'DD-MM-YYYY')as DemandCreationDate,
		TO_CHAR(to_timestamp(edv.taxperiodto / 1000), 'Mon')as MONTHOFTAXPERIODTO,
		to_char(to_timestamp(edv.taxperiodfrom / 1000), 'DD-MM-YYYY')as TaxPeriodFrom,
		to_timestamp(edv.taxperiodto / 1000)as formattedtaxperiodto,
		to_char(to_timestamp(edv.taxperiodto / 1000), 'DD-MM-YYYY')as TaxPeriodTo,
		edv2.demandid,
		edv2.TAXAMTPERDEMAND - edv2.COLLECTEDAMTPERDEMAND as CURRENTDEMAND,
		edv.status,
		edv.businessservice
	from
		EGBS_DEMAND_V1 EDV
		--inner join 
		--EGBS_DEMANDDETAIL_V1 EDV2 
		--on 	EDV.tenantid='od.cuttack' and EDV.ID=EDV2.DEMANDID group by EDV.CONSUMERCODE
		inner join (
			select
			SUM(case when egb1.taxheadcode != 'WS_ADVANCE_CARRYFORWARD' then egb1.TAXAMOUNT else 0 end) as TAXAMTPERDEMAND,
			SUM(case when egb1.taxheadcode != 'WS_ADVANCE_CARRYFORWARD' then egb1.COLLECTIONAMOUNT else -egb1.TAXAMOUNT end) as COLLECTEDAMTPERDEMAND,
			egb1.demandid
			from
				egbs_demanddetail_v1 egb1
			where
			egb1.tenantid = 'od.cuttack' and egb1.taxheadcode like 'WS%' group by egb1.demandid) edv2 on
		EDV.ID = EDV2.DEMANDID)DM on
	EWC.connectionno = DM.CONSUMERCODE
	--old-		
	--inner join(
		--select
		--	egb1.demandid,
		--	egb1.taxheadcode,
		--	egb1.taxamount
		--from
		--	egbs_demanddetail_v1 egb1
		--where
		--	egb1.taxheadcode = 'WS_CHARGE'
		--	and egb1.tenantid = 'od.cuttack')edv2 on
		--EDV.ID = EDV2.DEMANDID)DM on
	--EWC.connectionno = DM.CONSUMERCODE
left outer join(
	select
		consumercode,
		sum(totaltaxamt)as totalcollectableinarrears,
		sum(totalcollectedamt)as totalcollectedinarrears
	from
		egbs_demand_v1 egdm1
	inner join(
		select
			d_detail.DEMANDID,
			SUM(d_detail.TAXAMOUNT)as TOTALTAXAMT,
			SUM(d_detail.COLLECTIONAMOUNT)as TOTALCOLLECTEDAMT
		from
			EGBS_DEMANDDETAIL_V1 d_detail
		where
			d_detail.tenantid = 'od.cuttack'
			and d_detail.taxheadcode like 'WS%'
		group by
			d_detail.DEMANDID)egdd1 on
		egdm1.id = egdd1.demandid
	where
		date(to_timestamp(taxperiodto / 1000))< date('2021-09-01')
		and ispaymentcompleted = false
		and businessservice = 'WS'
		and STATUS = 'ACTIVE'
		and tenantid = 'od.cuttack'
	group by
		consumercode)arreardtl on
	EWC.connectionno = arreardtl.consumercode
left outer join(
	select
		name,
		mobilenumber,
		address,
		connectionid
	from
		eg_ws_connectionholder ewch
	inner join(
		select
			name,
			mobilenumber,
			address,
			egu.uuid
		from
			eg_user egu
		inner join eg_user_address eguad on
			eguad.userid = egu.id
		where
			eguad.type = 'CORRESPONDENCE')usr on
		ewch.userid = usr.uuid)conholder on
	ewc.id = conholder.connectionid
where
	EWC.APPLICATIONSTATUS = 'CONNECTION_ACTIVATED'
	and DM.STATUS = 'ACTIVE'
	and DM.BUSINESSSERVICE = 'WS'
	and ewc.tenantid = 'od.cuttack'
	and ews.connectiontype = 'Non Metered'
	and
	case
		when LOWER('01') = 'nil' then EWC.ADDITIONALDETAILS ->> 'ward' is null
		else EWC.ADDITIONALDETAILS ->> 'ward' = '01'
	end
	and (date(formattedtaxperiodto) >= date('2021-09-01')
	and date(formattedtaxperiodto) <= date('2021-09-30'));
--===========================================
-- Collection amount ULB wise
-- Property: PT
-- Water monthly: WS
-- Water application: WS.ONE_TIME_FEE
-- BPA: 'BPA.NC_SAN_FEE', 'BPA.NC_APP_FEE'
select tenantid, sum(amountpaid) as paidAmt from egcl_paymentdetail ep
where businessservice in ('WS', 'WS.ONE_TIME_FEE')
and EXTRACT(MONTH FROM to_timestamp(receiptdate/1000))=11
and EXTRACT(YEAR FROM to_timestamp(receiptdate/1000))=2021
group by tenantid;

-- ulb wise application count
-- Application Type
-- NEW_WATER_CONNECTION
-- CONNECTION_OWNERSHIP_CHANGE
-- DISCONNECT_WATER_CONNECTION
-- WATER_RECONNECTION
-- MODIFY_WATER_CONNECTION
-- CLOSE_WATER_CONNECTION
select tenantid, count(*) from eg_ws_connection ewc
where applicationtype='CLOSE_WATER_CONNECTION'
and applicationstatus not in ('CONNECTION_ACTIVATED', 'REJECTED')
GROUP BY tenantid;

--======================================================================
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
	 end as feeType
from egcl_paymentdetail ep
where businessservice in ('WS', 'WS.ONE_TIME_FEE', 'BPA.NC_SAN_FEE','BPA.NC_APP_FEE');

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
from eg_ws_connection
where oldconnectionno is null
and applicationtype in ('NEW_WATER_CONNECTION');


