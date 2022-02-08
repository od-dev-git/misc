-- Update demand to payment completed
update egbs_demand_v1
set ispaymentcompleted=true
where id in ('87b63ba1-a047-4268-936e-9a3169e71bd1',
			'040ef8d7-49e7-41c6-ab21-0d9f150b5de3',
			'bf4b2c76-5538-4c71-9d40-28d3b3eccc54',
			'4f3c0251-d4c6-4f89-8c81-0566e68ce16b');

-- Update time rebate to adjusted amount
update egbs_demanddetail_v1
set taxamount=-6
where demandid='4f3c0251-d4c6-4f89-8c81-0566e68ce16b'
and taxheadcode='WS_TIME_REBATE';

-- update collected amount
update egbs_demanddetail_v1
set collectionamount=taxamount
where demandid in ('87b63ba1-a047-4268-936e-9a3169e71bd1',
			'040ef8d7-49e7-41c6-ab21-0d9f150b5de3',
			'bf4b2c76-5538-4c71-9d40-28d3b3eccc54',
			'4f3c0251-d4c6-4f89-8c81-0566e68ce16b');
