CREATE or REPLACE VIEW v_acct_usrs
aswhatsfresh_dev
select
			batchtrax.f_acct_name(account_id)					acct_name
,			batchtrax.f_usr_name(b.user_id)					usr_name
,			batchtrax.f_usr_email(b.user_id)					usr_email
,			batchtrax.f_usr_type(b.global_user_type_id) 	user_type	
,			case when b.is_owner = 1 then 'Owner' else '' end owner
,			b.id											acct_usr_id
,			b.account_id								acct_id
,			b.user_id									usr_id		
from		batchtrax.account_users b
order by 1,2