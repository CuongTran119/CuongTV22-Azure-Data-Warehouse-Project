IF OBJECT_ID('dbo.dim_date') IS NOT NULL
BEGIN
	DROP EXTERNAL TABLE [dbo].[dim_date];
END

CREATE EXTERNAL TABLE dbo.dim_date
WITH (
    LOCATION = 'dim_date',
	DATA_SOURCE = [cuongtv22-filesystem_cuongtv22_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
WITH date_data AS (SELECT DISTINCT
	DATEPART(WEEKDAY,  [date]) as [day_of_week],
	DATEPART(MONTH, [date]) as [month],
	DATEPART(YEAR, [date]) as [year],
	DATEPART(QUARTER, [date]) as [quarter]
FROM [dbo].[staging_payment])
SELECT
	CONCAT([day_of_week], [month], [year], [quarter]) as date_id,
	[day_of_week],
	[month],
	[year],
	[quarter]
FROM date_data

SELECT TOP 100 * FROM dbo.dim_date
GO