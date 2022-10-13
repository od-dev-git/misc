select 
	'PT' as service_availed,
	usr."name" as person_name,
	usr.mobilenumber as contact_no,
	usr.emailid as contact_email,
	concat(epa.doorno,',',epa.plotno,',',epa.buildingname,',',epa.street,',',epa.landmark,',',epa.city,',','PIN-',epa.pincode,',',epa.district),
	TO_CHAR(to_timestamp(pt.lastmodifiedtime / 1000),'DD-MM-YYYY') as service_availed_date,
	pt.acknowldgementnumber as application_number,
	pt.propertyid as property_id 
from eg_pt_property pt 
left outer join eg_pt_owner ownr on ownr.propertyid = pt.id 
left outer join eg_pt_address epa on epa.propertyid = pt.id 
left outer join eg_user usr on usr.uuid = ownr.userid 
where pt.status='ACTIVE' and pt.creationreason ='CREATE'
and pt.oldpropertyid is null
and pt.createdtime >= 1648751401000 and pt.createdtime <= 1665649132000;

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
where epp.createdtime>=1648751401000
and epp.oldpropertyid is null
and epp.status='ACTIVE' and epp.creationreason ='CREATE'
order by epp.createdtime;
