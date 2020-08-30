-- https://leetcode.com/problems/second-degree-follower/
-- Oracle

Select f1.followee as follower, Count(distinct f1.follower) as num from follow f1, follow f2 
where f1.followee = f2.follower group by f1.followee
order by f1.followee