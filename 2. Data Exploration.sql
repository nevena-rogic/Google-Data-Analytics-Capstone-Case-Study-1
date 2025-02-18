--Data Exploration

--checking for number of null values in all columns
SELECT 
	COUNT(CASE WHEN ride_id IS NULL then 1 END) AS ride_id_nulls,
	COUNT(CASE WHEN rideable_type IS NULL then 1 END) AS  rideable_type_nulls,
	COUNT(CASE WHEN started_at IS NULL then 1 END) AS  started_at_nulls,
	COUNT(CASE WHEN ended_at IS NULL then 1 END) AS  ended_at_nulls,
	COUNT(CASE WHEN start_station_name IS NULL then 1 END) AS  start_station_name_nulls,
	COUNT(CASE WHEN start_station_id IS NULL then 1 END) AS  start_station_id_nulls,
	COUNT(CASE WHEN end_station_name IS NULL then 1 END) AS  end_station_name_nulls,
	COUNT(CASE WHEN end_station_id IS NULL then 1 END) AS  end_station_id_nulls,
	COUNT(CASE WHEN start_lat IS NULL then 1 END) AS  start_lat_nulls,
	COUNT(CASE WHEN start_lng IS NULL then 1 END) AS  start_lng_nulls,
	COUNT(CASE WHEN end_lat IS NULL then 1 END) AS  end_lat_nulls,
	COUNT(CASE WHEN end_lng IS NULL then 1 END) AS  end_lng_nulls,
	COUNT(CASE WHEN member_casual IS NULL then 1 END) AS  member_casual_nulls
  FROM [2024_tripdata.combined_data]
GO

--checking for duplicate rows -211 rows found
SELECT ride_id, COUNT(*) AS duplicate_count
FROM [2024_tripdata.combined_data]
GROUP BY ride_id
HAVING COUNT(*)>1;

--length of ride_id -all of the rows of column ride_id have the length of 16
SELECT 
    LEN(ride_id) AS text_length,
    COUNT(*) AS row_count
FROM [2024_tripdata.combined_data]
GROUP BY LEN(ride_id)
ORDER BY text_length;

--rideable_type -3 unique types of bikes
SELECT 
    rideable_type,
    COUNT(*) AS count
FROM [2024_tripdata.combined_data]
GROUP BY rideable_type
ORDER BY count DESC;

--counting the number of rides longer then day and less then minute and longer then day
--rides_longer_than_a_day -7490
SELECT 
    COUNT(*) AS rides_longer_than_a_day
FROM [2024_tripdata.combined_data]
WHERE DATEDIFF(HOUR, started_at, ended_at) > 24;
--rides_less_than_a_minute -131256
SELECT 
    COUNT(*) AS rides_less_than_a_minute
FROM [2024_tripdata.combined_data]
WHERE DATEDIFF(SECOND, started_at, ended_at) < 60;

--numbers of different staring stations by names -1809 stations
SELECT DISTINCT start_station_name
FROM [2024_tripdata.combined_data]
ORDER BY start_station_name;

--start_station_name, start_station_id -total 1073951 rows with start station name or id missing
SELECT COUNT(ride_id) AS rows_with_start_station_null          
FROM [2024_tripdata.combined_data]
WHERE start_station_name IS NULL OR start_station_id IS NULL;

--numbers of different ending stations by names -1816 stations
SELECT DISTINCT end_station_name
FROM [2024_tripdata.combined_data]
ORDER BY end_station_name;

--end_station_name, end_station_id -total 1104653 rows with end station name or id missing
SELECT COUNT(ride_id) AS rows_with_end_station_null          
FROM [2024_tripdata.combined_data]
WHERE end_station_name IS NULL OR end_station_id IS NULL;

--start_lat, start_lng -total 0 rows with either of them is missing
SELECT COUNT(ride_id) AS rows_with_null_start_loc
FROM [2024_tripdata.combined_data]
WHERE start_lat IS NULL OR start_lng IS NULL;

--end_lat, end_lng -total 7232 rows with either of them is missing
SELECT COUNT(ride_id) AS rows_with_null_end_loc
FROM [2024_tripdata.combined_data]
WHERE end_lat IS NULL OR end_lng IS NULL;

--member_casual -2 unique types of members
SELECT 
    member_casual,
    COUNT(*) AS count
FROM [2024_tripdata.combined_data]
GROUP BY member_casual
ORDER BY count DESC;

