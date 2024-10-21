-- Based on date and time factors such as day of week and time of day
SELECT 
    avg(tr.duration) as avg_duration,
    tr.time_day,
    da.day_of_week 
FROM [dbo].[fact_trip] tr
JOIN [dbo].[dim_date] da ON tr.date_id = da.date_id
GROUP BY tr.time_day, da.day_of_week
ORDER BY da.day_of_week, tr.time_day;

-- Based on which station is the starting and / or ending station
SELECT 
    avg(tr.duration) as avg_duration,
    st.[name]
FROM [dbo].[fact_trip] tr
JOIN [dbo].[dim_station] st ON tr.start_station_id = st.station_id
GROUP BY st.[name];

-- Based on age of the rider at time of the ride
SELECT 
    avg(tr.duration) as avg_duration,
    ri.is_member
FROM [dbo].[fact_trip] tr
JOIN [dbo].[dim_rider] ri ON tr.rider_id = ri.rider_id
GROUP BY ri.is_member;


-- Based on whether the rider is a member or a casual rider
SELECT 
    avg(tr.duration) as avg_duration,
    tr.age_at_time_of_trip
FROM [dbo].[fact_trip] tr
JOIN [dbo].[dim_rider] ri ON tr.rider_id = ri.rider_id
GROUP BY tr.age_at_time_of_trip
ORDER BY tr.age_at_time_of_trip;