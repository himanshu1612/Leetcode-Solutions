Select 
	b.request_at as day, 
  nvl(round(a.calcelled_per_day/b.request_per_day, 2), 0.00) as "Cancellation Rate" 
from 
	(Select 
    Distinct t.request_at, count(id) over (partition by t.request_at) as calcelled_per_day 
	from 
    trips t, users c, users d
	where 
    t.client_id = c.users_id
	 and t.driver_id = d.users_id
	 and lower(c.banned) = 'no' and lower(d.banned)='no' 
   and lower(t.status) like 'cancelled%') a, 
	(Select 
    Distinct t.request_at, count(id) over (partition by t.request_at) as request_per_day 
	from 
    trips t, users c, users d
	where 
    t.client_id = c.users_id
	 and t.driver_id = d.users_id
	 and lower(c.banned) = 'no' and lower(d.banned)='no') b
where 
	b.request_at = a.request_at (+)
	and b.request_at >='2013-10-01' 
	and b.request_at < '2013-10-04'