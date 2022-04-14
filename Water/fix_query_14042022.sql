-- WS/CTC/1780572
update egbs_demand_v1 
set ispaymentcompleted=true
where id in ('02aae1ee-e194-4258-8a8c-9e9fb4b60625',
'32b98b6e-a510-43ff-a642-bbec5ac38a76',
'50ba4ab7-9091-419d-bc1a-71215318c8f2',
'88fe1155-a659-4b74-9081-82e3a619df13',
'a7871154-4bea-40a3-8ef6-4c73bc9df3a9',
'ea3d6c5c-0027-4dce-a66e-7c925b6adf84');

update egbs_demanddetail_v1
set collectionamount=taxamount
where demandid in ('02aae1ee-e194-4258-8a8c-9e9fb4b60625',
'32b98b6e-a510-43ff-a642-bbec5ac38a76',
'50ba4ab7-9091-419d-bc1a-71215318c8f2',
'88fe1155-a659-4b74-9081-82e3a619df13',
'a7871154-4bea-40a3-8ef6-4c73bc9df3a9',
'ea3d6c5c-0027-4dce-a66e-7c925b6adf84');
===============================

-- Insert the workflow
-- Assigner keep same as previous
INSERT INTO eg_wf_processinstance_v2 (id,tenantid,businessservice,businessid,"action",status,"comment",assigner,assignee,statesla,previousstatus,createdby,lastmodifiedby,createdtime,lastmodifiedtime,modulename,businessservicesla,rating) values
('2040984b-76e0-4226-84af-0ec542cef2f4','od.hinjilicut','NewWS1','WS_AP/HNL/2021-22/2217477','PAY','856e04f3-9195-464b-8c07-b6ae33a4b66d',NULL,'f6b78427-9fcc-46c7-aedd-0606b9b39ae5',NULL,NULL,NULL,'f6b78427-9fcc-46c7-aedd-0606b9b39ae5','f6b78427-9fcc-46c7-aedd-0606b9b39ae5',1649923254000,1649923254000,'ws-services',258971850,NULL);

-- Update application status
update eg_ws_connection
set applicationstatus='PENDING_FOR_CONNECTION_ACTIVATION'
where applicationno='WS_AP/HNL/2021-22/2217477' ;
