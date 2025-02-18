--Data Combining
--create table of combined data
CREATE TABLE [dbo].[2024_tripdata.combined_data](
	[ride_id] [nvarchar](50) NOT NULL,
	[rideable_type] [nvarchar](50) NOT NULL,
	[started_at] [datetime2](7) NULL,
	[ended_at] [datetime2](7) NULL,
	[start_station_name] [varchar](max) NULL,
	[start_station_id] [varchar](50) NULL,
	[end_station_name] [varchar](max) NULL,
	[end_station_id] [varchar](50) NULL,
	[start_lat] [decimal](18, 12) NULL,
	[start_lng] [decimal](18, 12) NULL,
	[end_lat] [decimal](18, 12) NULL,
	[end_lng] [decimal](18, 12) NULL,
	[member_casual] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

--merge all data (combine the data from tables for 12 months, in order to get one table for a 2024 year)
INSERT INTO [2024_tripdata.combined_data] ([ride_id]
           ,[rideable_type]
           ,[started_at]
           ,[ended_at]
           ,[start_station_name]
           ,[start_station_id]
           ,[end_station_name]
           ,[end_station_id]
           ,[start_lat]
           ,[start_lng]
           ,[end_lat]
           ,[end_lng]
           ,[member_casual])
  SELECT * FROM [2024_tripdata.202401_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202402_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202403_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202404_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202405_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202406_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202407_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202408_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202409_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202410_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202411_tripdata]
  UNION ALL
  SELECT * FROM [2024_tripdata.202412_tripdata]
;

--checking number of rows which is 5860568
SELECT COUNT(*)
FROM [2024_tripdata.combined_data];

