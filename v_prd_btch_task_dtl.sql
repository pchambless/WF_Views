create or replace view whatsfresh.v_prd_btch_task_dtl
as
select	b.ordr
,			b.name													task_name
,			ifnull(d.batch_number,'')							prd_btch_nbr
,			ifnull(a.workers,'') 								workers
,			whatsfresh.f_json_to_com_delim(a.workers) 	taskWrkrs
,			ifnull(a.measure_value,'') 						measure_value
,			ifnull(a.comments,'') 								comments
,			b.`active`  											task_active
,			ifnull(a.id,0)      									prd_task_id
,			ifnull(a.product_batch_id,0)						prd_btch_id
,			ifnull(d.product_id,0)								prd_id
,		   b.id														task_id
,        b.account_id											acct_id
from 		whatsfresh.tasks b
left join whatsfresh.product_batch_tasks a
on			b.id = a.task_id
left join whatsfresh.product_batches d
on			a.product_batch_id = d.id
order by  d.batch_number, b.product_type_id, b.ordr