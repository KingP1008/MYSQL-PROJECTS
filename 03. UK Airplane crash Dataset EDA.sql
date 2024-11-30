-- EDA FOR PLANE CRASH DATA:

SELECT *
FROM crash_records;

-- What is the total number of airplane crashes in the UK?
select count(*)
from crash_records;

-- Which airport has the highest number of crashes?
select count(Accident_Number), airport_name
from crash_records
where airport_name is not null
group by airport_name
order by count(airport_name) desc;

-- What is the most common aircraft make involved in crashes?
select count(Accident_Number), Make
from crash_records
group by Make
order by count(Accident_Number) desc;

-- What is the total number of fatal injuries in all crashes?
select sum(total_fatal_injuries)
from crash_records;

select *
from crash_records
order by event_date asc;

-- What is the average number of engines in aircraft involved in crashes?
select round(avg(number_of_engines))
from crash_records
where number_of_engines is not null;

-- What engine type is most commonly involved in crashes?
select count(Accident_Number), Engine_type
from crash_records
where Engine_type is not null and Engine_type != 'Unknown'
group by Engine_type
order by count(Accident_Number) desc;

-- Which locations have the highest crash rates per year?
select location, round(count(Accident_Number)/count(distinct year(event_date)),2) as crash_rate
from crash_records
group by location
order by crash_rate desc;

-- What is the trend of crashes over time?
select year(event_date) as `year`, count(Accident_Number) as crash_count
from crash_records
where event_date is not null
group by `year`
order by `year` desc;