--Data Analysis
--bikes types used by riders
SELECT TOP 100
    member_casual,          -- Type of rider (member or casual)
    rideable_type,          -- Type of bike used
    COUNT(*) AS total_trips -- Total number of trips
FROM 
    [2024_tripdata.cleaned_combined_data] -- Source table
GROUP BY 
    member_casual,          -- Group by rider type
    rideable_type           -- Group by bike type
ORDER BY 
    member_casual,          -- Order by rider type
    total_trips             -- Order by total trips

--distribution of users per month    
SELECT TOP 100
    DATEFROMPARTS(YEAR(started_at), MONTH(started_at), 1) AS month_date,  
    member_casual,  
    COUNT(ride_id) AS total_trips
FROM 
    [2024_tripdata.cleaned_combined_data]
GROUP BY 
    DATEFROMPARTS(YEAR(started_at), MONTH(started_at), 1), 
    member_casual
ORDER BY 
    month_date, member_casual

--distribution of users per day of week 
SELECT TOP 100
    day_of_week, 
    member_casual, 
    COUNT(ride_id) AS total_trips
FROM 
    [2024_tripdata.cleaned_combined_data]
GROUP BY 
    day_of_week, 
    member_casual
ORDER BY 
    CASE day_of_week
        WHEN 'SUN' THEN 1
        WHEN 'MON' THEN 2
        WHEN 'TUE' THEN 3
        WHEN 'WED' THEN 4
        WHEN 'THU' THEN 5
        WHEN 'FRI' THEN 6
        WHEN 'SAT' THEN 7
    END,  
    member_casual -- Keep member_casual order after day sorting
	
--distribution of users per hour 
SELECT TOP 100
    DATEPART(HOUR, started_at) AS hour_of_day,  -- Use DATEPART to extract the hour
    member_casual, 
    COUNT(ride_id) AS total_trips
FROM 
    [2024_tripdata.cleaned_combined_data]  -- Correct table reference for T-SQL
GROUP BY 
    DATEPART(HOUR, started_at),  -- Group by the same DATEPART expression
    member_casual
ORDER BY 
    hour_of_day, member_casual

--duration of a ride per month
SELECT TOP 100
    month, 
    member_casual, 
    AVG(ride_length) AS avg_ride_duration
FROM [2024_tripdata.cleaned_combined_data]
GROUP BY month, member_casual
ORDER BY member_casual,
    CASE month
        WHEN 'JAN' THEN 1
        WHEN 'FEB' THEN 2
        WHEN 'MAR' THEN 3
        WHEN 'APR' THEN 4
        WHEN 'MAY' THEN 5
        WHEN 'JUN' THEN 6
        WHEN 'JUL' THEN 7
        WHEN 'AUG' THEN 8
        WHEN 'SEP' THEN 9
        WHEN 'OCT' THEN 10
        WHEN 'NOV' THEN 11
        WHEN 'DEC' THEN 12
    END

--duration of a ride per day of week
SELECT TOP 100
    day_of_week, 
    member_casual, 
    AVG(ride_length) AS avg_ride_duration
FROM 
    [2024_tripdata.cleaned_combined_data]
GROUP BY 
    day_of_week, 
    member_casual
ORDER BY 
    member_casual,  -- First, order by member type
    CASE day_of_week  -- Then, order days in correct sequence
        WHEN 'SUN' THEN 1
		WHEN 'MON' THEN 2
        WHEN 'TUES' THEN 3
        WHEN 'WED' THEN 4
        WHEN 'THURS' THEN 5
        WHEN 'FRI' THEN 6
        WHEN 'SAT' THEN 7
    END

--duration of a ride per hour
SELECT TOP 100
    DATEPART(HOUR, started_at) AS hour_of_day, 
    member_casual, 
    AVG(ride_length) AS avg_ride_duration
FROM 
    [2024_tripdata.cleaned_combined_data]
GROUP BY  
    DATEPART(HOUR, started_at), 
    member_casual
ORDER BY  
    hour_of_day,  -- Ensures hours are in ascending order for a proper line graph
    member_casual  -- Keeps casual and member data grouped separately

--start stations
SELECT 
    start_station_name, 
    member_casual, 
    AVG(CAST(start_lat AS FLOAT)) AS start_lat, 
    AVG(CAST(start_lng AS FLOAT)) AS start_lng, 
    COUNT(ride_id) AS total_trips
FROM 
    [2024_tripdata.cleaned_combined_data]
GROUP BY 
    start_station_name, 
    member_casual

--end stations
SELECT 
    end_station_name, 
    member_casual, 
    AVG(CAST(end_lat AS FLOAT)) AS end_lat, 
    AVG(CAST(end_lng AS FLOAT)) AS end_lng, 
    COUNT(ride_id) AS total_trips
FROM 
    [2024_tripdata.cleaned_combined_data]  -- Ensure the correct schema name
GROUP BY 
    end_station_name, 
    member_casual
