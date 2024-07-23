create or replace view whatsfresh.v_ingr_btch_sum
as
select	
a.ingr_name
,	count(a.ingr_btch_id) 			batches
,	sum(a.purch_qty)  tot_qty
,	min(a.unit_rate) 	min_rate
,	max(a.unit_rate)  max_rate
,	cast(avg((ifnull(a.unit_price,0) / ifnull(a.unit_qty,1))) as decimal(5,2)) avg_rate
,	a.purch_meas      units
,	sum(a.purch_total_amt) total_cost		
from    	whatsfresh.v_ingr_btch_dtl a
WHERE 	a.acct_id = 1
and 		a.purch_date > now() - interval 365 day
AND		a.purch_meas <> '-'
group BY a.ingr_name
,	a.purch_meas