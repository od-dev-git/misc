-- Update workflow
INSERT INTO public.eg_wf_processinstance_v2 (id, tenantid, businessservice, businessid, "action", status, assigner,createdby, lastmodifiedby, createdtime, lastmodifiedtime, modulename, businessservicesla) VALUES('d94e80a0-12c8-425c-b41d-858d5d1c06c3','od.rourkela',
'BPA1','BP-RRK-2022-05-05-003240','PAY','a5bb57a7-5154-4d3f-a94f-a7d2db265dd5',
'c03bf043-7a29-4b74-b4de-6d3a2047ada6','c03bf043-7a29-4b74-b4de-6d3a2047ada6','c03bf043-7a29-4b74-b4de-6d3a2047ada6',1651818144065,1651818144065,'bpa-services',5183152167);

-- Update application
update public.eg_bpa_buildingplan set status = 'DOC_VERIFICATION_INPROGRESS' where applicationno ='BP-RRK-2022-05-05-003240';
