INSERT INTO public.eg_wf_processinstance_v2 (id, tenantid, businessservice, businessid, "action", status, assigner,createdby, lastmodifiedby, createdtime, lastmodifiedtime, modulename, businessservicesla) VALUES('c8bed5db-42ee-48ac-ad4c-665f72a131ee',(select tenantid from public.eg_bpa_buildingplan ebb where applicationno ='BP-RRK-2021-12-16-000200'),
'BPA2','BP-RRK-2021-12-16-000200','PAY',
(select nextstate from public.eg_wf_action_v2 ewav where currentstate in (select uuid from public.eg_wf_state_v2 where businessserviceid in (select uuid from public.eg_wf_businessservice_v2 ewbv where businessservice = 'BPA2'))  and  currentstate = (select status from public.eg_wf_processinstance_v2 ewpv where businessid ='BP-RRK-2021-12-16-000200' order by createdtime desc limit 1) and "action" ='PAY'),
'801845ad-9cc4-4eb6-99b9-5c87fc4dc35f','801845ad-9cc4-4eb6-99b9-5c87fc4dc35f','801845ad-9cc4-4eb6-99b9-5c87fc4dc35f',1647935583956,1647935583956,'bpa-services',-3111494172);

update public.eg_bpa_buildingplan set status = (select applicationstatus from public.eg_wf_state_v2 ewsv where uuid =(select currentstate from public.eg_wf_action_v2 ewav where currentstate = (select status from public.eg_wf_processinstance_v2 ewpv where businessid ='BP-RRK-2021-12-16-000200' order by createdtime desc limit 1) limit 1)
) where applicationno ='BP-RRK-2021-12-16-000200';


-- need to update the permit number as this formate  BP/[CITY.CODE]/[SEQ_EG_BP_PN] eg: BP/RRK/000121

--get seq query 
seq = select nextval('seq_eg_bp_pn')

update public.eg_bpa_buildingplan set approvalno = 'BP/RRK/{seq-with 6 digit}' where  applicationno ='BP-RRK-2021-12-16-000200';