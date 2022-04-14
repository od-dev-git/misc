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
