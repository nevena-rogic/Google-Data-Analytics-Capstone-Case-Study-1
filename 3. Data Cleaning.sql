--Data Cleaning

--create a new table with the cleaned and filtered data -4138143 rows
SELECT 
    ride_id, 
    rideable_type, 
    started_at, 
    ended_at, 
    DATEDIFF(MINUTE, started_at, ended_at) AS ride_length, -- Calculate ride length in minutes
    CASE DATEPART(WEEKDAY, started_at) -- Get day of the week
        WHEN 1 THEN 'SUN'
        WHEN 2 THEN 'MON'
        WHEN 3 THEN 'TUE'
        WHEN 4 THEN 'WED'
        WHEN 5 THEN 'THU'
        WHEN 6 THEN 'FRI'
        WHEN 7 THEN 'SAT'
    END AS day_of_week,
    CASE DATEPART(MONTH, started_at) -- Get month
        WHEN 1 THEN 'JAN'
        WHEN 2 THEN 'FEB'
        WHEN 3 THEN 'MAR'
        WHEN 4 THEN 'APR'
        WHEN 5 THEN 'MAY'
        WHEN 6 THEN 'JUN'
        WHEN 7 THEN 'JUL'
        WHEN 8 THEN 'AUG'
        WHEN 9 THEN 'SEP'
        WHEN 10 THEN 'OCT'
        WHEN 11 THEN 'NOV'
        WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name, 
    end_station_name, 
    start_lat, 
    start_lng, 
    end_lat, 
    end_lng, 
    member_casual
INTO [2024_tripdata.cleaned_combined_data] -- Create a new table with the results
FROM [2024_tripdata.combined_data]
WHERE 
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    DATEDIFF(MINUTE, started_at, ended_at) > 1 AND -- Filter for rides longer than 1 minute
    DATEDIFF(MINUTE, started_at, ended_at) < 1440; -- Filter for rides shorter than 24 hours (1440 minutes)

--setting primary key 
--deleting duplicate ride_id rows-121 rows
--use a CTE to identify duplicates
WITH CTE AS (
    SELECT 
        ride_id,
        ROW_NUMBER() OVER (PARTITION BY ride_id ORDER BY ride_id) AS row_num
    FROM [2024_tripdata.cleaned_combined_data]
)
--delete rows where row_num > 1 (i.e., duplicates)
DELETE FROM CTE
WHERE row_num > 1;
--Setting primary key
ALTER TABLE [2024_tripdata.cleaned_combined_data]
ADD CONSTRAINT [PK_2024_tripdata.cleaned_combined_data] PRIMARY KEY (ride_id);

--counting number of rows
no_of_rows
4138022
SELECT COUNT(ride_id) AS no_of_rows
FROM [2024_tripdata.cleaned_combined_data];
