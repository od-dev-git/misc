-- Update round off collection
update egbs_demanddetail_v1 set collectionamount=0.00 where demandid='a9bd3910-89bb-46e4-ba5d-b3126924f5a3'
and taxheadcode='WS_Round_Off';

-- expire bill
update egbs_billdetail_v1 set expirydate=1643673599000 where consumercode='WS/BMC/1569912' and expirydate=1643846399896 order by expirydate;
