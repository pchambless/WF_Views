create or replace view v_ingr_btch_metrics as
select
  a.ingr_type	
,	a.ingr_name
, a.ingr_code
, a.ingr_desc
, a.gms_per_oz
,	count(ingr_btch_id) batches
, 	ifnull(sum(a.prd_btch_cnt),0) prod_batches
,	ifnull(sum(a.purch_qty),0)  tot_qty
,  ifnull(max(a.purch_date),'')  last_purchase
,	cast(min(a.unit_rate) as dec(5,2)) 	min_rate
,	cast(max(a.unit_rate) as dec(5,2)) max_rate
,	cast(avg((ifnull(a.unit_price,0) / ifnull(a.unit_qty,1))) as dec(5,2)) avg_rate
,	a.purch_meas      units
,	concat('$',format(ifnull(sum(a.purch_total_amt),0),2)) total_cost
, 	a.ingr_type_id
,  a.ingr_id
,  a.acct_id
,	a.ingr_active		
from    	whatsfresh.v_ingr_btch_dtl a	
group BY a.ingr_type, a.ingr_name, ingr_code, ingr_desc, a.purch_meas, a.ingr_id, a.acct_id
order by a.acct_id, a.ingr_type, a.ingr_name