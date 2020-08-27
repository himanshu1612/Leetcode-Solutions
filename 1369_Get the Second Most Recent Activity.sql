-- https://leetcode.com/problems/get-the-second-most-recent-activity/
-- Oracle

Select 
	username, 
	activity, 
	to_char(startdate, 'YYYY-MM-DD') as startdate, 
	to_char(enddate, 'YYYY-MM-DD') as enddate 
From 
	(Select username, activity , startdate, enddate,  
		row_number() over (partition by username order by startdate desc) as activity_number,
		lead(startdate, 1) over (partition by username order by startdate desc) as next_activity 
	from 
		useractivity 
	order by username, activity_number)
where 
	activity_number = 2 or (activity_number = 1 and next_activity is null)