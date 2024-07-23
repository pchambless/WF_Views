CREATE OR REPLACE VIEW v_wf_usr_dtl
as
SELECT	case when c.NAME IS NULL then '' ELSE c.NAME end  account_name
,        a.first_name
,			CONCAT(a.first_name, ' ', a.last_name) user_name
,			case when a.role = 1 then 'Global' ELSE '' END role	
,			case when b.is_owner then 'Owner' ELSE '' END owner
,        a.email
,			a.id												user_id
,			b.account_id									acct_id
,        b.is_owner	
,			b.id												acct_user_id
,			a.default_account_id							dflt_acct_id
,			b.`active`										acct_usr_active
FROM    		whatsfresh.users a
JOIN			whatsfresh.accounts_users b
ON				a.id = b.user_id
JOIN			whatsfresh.accounts c
ON				b.account_id = c.id
where a.active = 'Y'
and   c.active = 'Y'
ORDER BY 1
,			4 DESC
, 			2