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
