#Query 1
select topic.id, topic.description, count(topic.id) as id_count
from topic, blurt_analysis
where blurt_analysis.topicid = topic.id
group by topic.id
order by topic.id;

#Query 2
select user.name, count(follow.follower) as follower_number
from user, celebrity, follow
where user.email = celebrity.email and
follow.followee = celebrity.email
group by user.name;

#Query 3
select user.name, count(blurt.blurtid) as blurt_count
from user, celebrity, blurt
where user.email = celebrity.email and
blurt.email = celebrity.email
group by user.email
order by blurt_count desc;

#Query 4
select user.name
from user, celebrity
where user.email = celebrity.email and
celebrity.email not in 
(select x.email
from celebrity x, follow
where x.email = follow.follower);

#Query 5
select vendor.name, vendor_ambassador.email, count(follow.follower) as follower_count
from vendor, vendor_ambassador, follow
where vendor.id = vendor_ambassador.vendorid and
vendor_ambassador.email = follow.followee
group by vendor.name, vendor_ambassador.email;

#Query 6
select v1.name, count(distinct blurt_analysis.email) as gap
from vendor v1, vendor_topics, blurt_analysis
where blurt_analysis.topicid = vendor_topics.topicid
and vendor_topics.vendorid = v1.id
and blurt_analysis.email not in(
select distinct u_a.email
from user_ad u_a, advertisement a, vendor v, vendor_topics v_t, blurt_analysis b_a
where u_a.email = b_a.email and
v.id = v1.id and
u_a.adid = a.id and a.vendorid = v.id and
v_t.topicid = b_a.topicid and v.id = v_t.vendorid)
group by v1.name
order by gap desc;


#Query 7
select distinct a.name, b.name
from user as a, user as b, blurt_analysis as baa, blurt_analysis as bab
where a.email = baa.email and b.email = bab.email and
baa.topicid = bab.topicid and
a.email != b.email and 
(a.email, b.email) not in (select * from follow)
order by a.name, b.name;

#Query 8
select a.email, b.email, c.email
from user a, user b, user c, follow fa, follow fb
where a.email = fa.follower and b.email = fa.followee and
b.email = fb.follower and c.email = fb.followee and
a.email != b.email and
b.email != c.email and
a.email != c.email and
(fa.follower, fb.followee) not in (select * from follow)
order by a.email, b.email, c.email;

#Query 9
select topic.id, topic. description, blurt.location, count(blurt.blurtid)as blurt_count, 
avg(blurt_analysis.sentiment) as sentiment_avg
from blurt_analysis, topic, blurt
where blurt_analysis.topicid = topic.id and blurt_analysis.blurtid = blurt.blurtid
group by topic.id, blurt.location
having sentiment_avg < 0;

