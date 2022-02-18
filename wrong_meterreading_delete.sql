-- WS/PRI/1835192
delete from eg_ws_meterreading where connectionno='WS/PRI/1835192'
	and id='e6dd6097-72db-4322-8659-202595d38bc2';
delete egbs_demanddetail_v1 where demandid='9cf611f0-0fa5-48d1-b8e0-ab0b39ad5ea2';
delete egbs_demand_v1 where id='9cf611f0-0fa5-48d1-b8e0-ab0b39ad5ea2';

-- WS/PRI/1836688
delete eg_ws_meterreading where connectionno='WS/PRI/1836688'
	and id='12a67a06-9951-46c2-ad2c-6953c923c155';
delete egbs_demanddetail_v1 where demandid='bd1f77d3-06a9-4725-a583-19a7c4e80d5b';
delete egbs_demand_v1 where id='bd1f77d3-06a9-4725-a583-19a7c4e80d5b';

-- WS/PRI/2146052
delete eg_ws_meterreading where connectionno='WS/PRI/2146052'
	and id='73ac951d-eb48-4b78-80b2-3ff8b69b9afd';
delete egbs_demanddetail_v1 where demandid in (
	select id from egbs_demand_v1 where consumercode='WS/PRI/2146052')
	and demandid not in ('0713c562-9f9d-41f0-8c90-94a087d7bcdd');
delete egbs_demand_v1 where consumercode='WS/PRI/2146052'
	and id not in ('0713c562-9f9d-41f0-8c90-94a087d7bcdd');

-- WS/PRI/1836230
delete eg_ws_meterreading where connectionno='WS/PRI/1836230'
	and id not in ('88c5e7fa-8b52-4350-a685-acd2b1effd26');
delete egbs_demanddetail_v1 where demandid in (
	select id from egbs_demand_v1 where consumercode='WS/PRI/1836230'
	and id not in ('a3a839c8-f6c1-47dd-8428-100de52ac839'));
delete egbs_demand_v1 where consumercode='WS/PRI/1836230'
	and id not in ('a3a839c8-f6c1-47dd-8428-100de52ac839');
