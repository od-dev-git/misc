-- Remove Dupplicate BPA document dupplicate record	
select * from eg_bpa_document where id in (
select id from 
(select id,
ROW_NUMBER() OVER(PARTITION BY documenttype order by id) as row_num
from eg_bpa_document where buildingplanid=(select id from eg_bpa_buildingplan
where applicationno='BP-BAM-2022-04-14-002532')) bpa_doc
where bpa_doc.row_num > 1);
