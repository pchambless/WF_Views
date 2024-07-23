create or replace view whatsfresh.v_prd_btch_dtl
as
select 
 concat(prd.name ,' ',c.name)							prd_type_and_name
,prd.name													prd_name
,prd.code 													prd_code
,c.name								 						prd_type
,prd.recipe_quantity										rcpe_qty
,whatsfresh.f_measure_unit(prd.global_measure_unit_id) 		rcpe_meas
,pb.recipe_multiply_factor 							rcpe_mult_fctr
,ifnull(d.ingr_maps,0)									ingr_maps
,ifnull(e.task_maps,0)									task_maps
,ifnull(d.ingr_maps + e.task_maps,0)				total_maps
,ifnull(pb.location,'')									location
,ifnull(pb.batch_quantity,0)							btch_qty											
,ifnull(whatsfresh.f_measure_unit(pb.global_measure_unit_id),'') btch_meas
,ifnull(concat(pb.batch_quantity,' ',whatsfresh.f_measure_unit(pb.global_measure_unit_id),'s'),'') qty_meas 
,ifnull(cast(date_format(pb.batch_start, '%Y-%m-%d') as date),'') 		prd_btch_date
,ifnull(pb.batch_start,'')								batch_start
,ifnull(pb.comments,'')									comments
,ifnull(pb.batch_number,'No Batches')				prd_btch_nbr
,ifnull(date_format(pb.best_by_date, '%Y-%m-%d'),'') best_by_date
,prd.active													prd_active
,pb.active													prd_btch_active
,c.`active`													prd_type_active
,pb.created_at												prd_btch_cre
,prd.product_type_id										prd_type_id
,prd.id														prd_id
,pb.id 														prd_btch_id
,prd.account_id											acct_id
,pb.global_measure_unit_id								meas_unit_id
from	 	whatsfresh.products 				prd 
left join 		whatsfresh.product_batches 		pb
on			prd.id = pb.product_id
join		whatsfresh.product_types			c
on			prd.product_type_id = c.id
left join (select product_batch_id, count(*) ingr_maps 
           from product_batch_ingredients
			  group by product_batch_id) d
on  pb.id = d.product_batch_id  
left join (select product_batch_id, count(*) task_maps 
           from product_batch_tasks
			  group by product_batch_id) e
on  pb.id = e.product_batch_id       
order by prd.account_id
,			pb.batch_start	desc
,			pb.batch_number		


