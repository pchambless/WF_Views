create or replace view v_prdBtchIngr_Map as
select a.prd_btch_nbr, b.ingr_ordr, b.ingr_name, ifnull(b.ingr_qty_meas,'') ingr_qty_meas
, f_json_to_com_delim(ingrMaps) ingrMaps, b.prd_ingr_desc, b.ingr_id, a.prd_id, a.prd_type_id
	, b.prd_rcpe_id, a.prd_btch_id
	, a.qty_meas btch_qty_meas
	from   v_prd_btch_dtl a
	join v_prd_rcpe_active b
	on a.prd_id = b.prd_id
	left join (select prd_btch_id, prd_rcpe_id, json_arrayagg(ingr_btch_srce) ingrMaps
	           from v_prd_btch_ingr_dtl
	           group by prd_btch_id, prd_rcpe_id) c
	on a.prd_btch_id = c.prd_btch_id
	and b.prd_rcpe_id = c.prd_rcpe_id
	order by a.prd_btch_nbr, ingr_ordr
	;
	