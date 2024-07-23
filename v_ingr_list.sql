create or replace view v_ingr_list
as
select 	
	a.ingr_type
,	a.ingr_name
,  a.ingr_code
,  a.gms_per_oz
,	a.ingr_desc
,  f_measure_unit(a.dflt_meas_id)                    	dflt_meas
,	f_vendor(a.dflt_vndr_id)									dflt_vndr
,	count(a.ingr_btch_id) 										ingr_btch_cnt
,	sum(a.prd_btch_cnt)	 										prd_btch_cnt
,	ifnull(max(a.purch_date),'') 								last_btch_date 
,	ifnull(max(a.ingr_btch_nbr), 'No Batches') 				last_btch_nbr
,	a.acct_id
,  a.ingr_type_id
,	a.ingr_id

from		v_ingr_btch_dtl a
where    a.ingr_active = 'Y'
and      f_acctActive(a.acct_id) = 'Y'
group by a.acct_id
, a.ingr_id
, a.ingr_type_id
, a.ingr_name
, a.ingr_code
, a.gms_per_oz
, a.ingr_desc
order by a.acct_id, a.ingr_type, a.ingr_name