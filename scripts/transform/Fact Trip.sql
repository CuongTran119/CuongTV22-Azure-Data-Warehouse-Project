-- Create trip fact table
IF OBJECT_ID('dbo.fact_trip') IS NOT NULL
BEGIN
	DROP EXTERNAL TABLE [dbo].[fact_trip];
END

CREATE EXTERNAL TABLE dbo.fact_trip
WITH (
    LOCATION = 'fact_trip',
	DATA_SOURCE = [cuongtv22-filesystem_cuongtv22_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT
	tr.[trip_id],
	tr.[start_at],
	tr.[end_at],
	tr.[start_station_id],
	tr.[end_station_id],
	DATEPART(HOUR, tr.start_at) as [time_day],
    DATEDIFF(MINUTE, tr.start_at, tr.end_at) as [duration],
    DATEDIFF(YEAR, ri.birthday, tr.start_at) as [age_at_time_of_trip],
	tr.[rider_id],
	da.[date_id]
FROM [dbo].[staging_trip] as tr
JOIN [dbo].[dim_rider] as ri ON tr.rider_id = ri.rider_id
JOIN [dbo].[dim_date] as da ON DATEPART(WEEKDAY, tr.[start_at]) = da.[day_of_week]
AND DATEPART(MONTH, tr.[start_at]) = da.[month]
AND DATEPART(YEAR, tr.[start_at]) = da.[year]
AND DATEPART(QUARTER, tr.[start_at]) = da.[quarter]

SELECT TOP 100 * FROM dbo.fact_trip
GO