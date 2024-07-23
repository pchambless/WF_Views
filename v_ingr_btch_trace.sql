create or replace view whatsfresh.v_ingr_btch_trace
as
select  		a.ingr_type
,				a.ingr_name
,				a.purch_date
,				a.vndr_name
,				a.brnd_name
,				a.ingr_btch_nbr 
,				ifnull(b.prd_btch_nbr,'') 														prd_btch_nbr
,				ifnull(cast(date_format(b.batch_start, '%Y-%m-%d') as date),'') 	prd_btch_date
,				ifnull(concat(b.prd_type,'-',b.prd_name),'No Product Batches')		prd
,				ifnull(b.location,'')        													location
,				a.unit_qty																			purch_qty
,				a.purch_meas
,				ifnull(b.prd_qty_meas,'')  													prd_qty_meas
,				ifnull(b.btch_qty,0)																prd_btch_qty
,				ifnull(b.unit_meas,'')															prd_btch_meas
,				a.purch_amt 	
,				a.purch_dtl
,				a.acct_id
,				a.ingr_id
,				b.prd_id
,				a.ingr_btch_id
,				b.prd_btch_id
,				b.prd_btch_ingr_id
from			whatsfresh.v_ingr_btch_dtl a
left join	v_prd_btch_ingr_dtl b
on				a.ingr_btch_id = b.ingr_btch_id
