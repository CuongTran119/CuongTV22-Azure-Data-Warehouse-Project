-- Create station dimension table
IF OBJECT_ID('dbo.dim_station') IS NOT NULL
BEGIN
	DROP EXTERNAL TABLE [dbo].[dim_station];
END

CREATE EXTERNAL TABLE dbo.dim_station
WITH (
    LOCATION = 'dim_station',
	DATA_SOURCE = [cuongtv22-filesystem_cuongtv22_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT
	[station_id],
	[name]
FROM [dbo].[staging_station]

SELECT TOP 100 * FROM dbo.dim_station
GO