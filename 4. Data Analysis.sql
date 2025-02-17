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
