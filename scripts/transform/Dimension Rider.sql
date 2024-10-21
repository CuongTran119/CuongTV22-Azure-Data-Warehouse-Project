-- Create rider dimension table
IF OBJECT_ID('dbo.dim_rider') IS NOT NULL
BEGIN
	DROP EXTERNAL TABLE [dbo].[dim_rider];
END

CREATE EXTERNAL TABLE dbo.dim_rider
WITH (
    LOCATION = 'dim_rider',
	DATA_SOURCE = [cuongtv22-filesystem_cuongtv22_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT
	[rider_id],
	[is_member],
	[birthday],
	[account_start_date],
	DATEDIFF(year, birthday, account_start_date) as account_start_age
FROM [dbo].[staging_rider]

SELECT TOP 100 * FROM dbo.dim_rider
GO