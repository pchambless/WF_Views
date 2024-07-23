create or replace view v_prd_type_tasks_active
as
select *	
from v_prd_type_tasks a
where  a.prd_type_del is null
and    a.task_del is null