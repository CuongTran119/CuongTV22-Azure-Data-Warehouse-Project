-- Create payment fact table
IF OBJECT_ID('dbo.fact_payment') IS NOT NULL
BEGIN
	DROP EXTERNAL TABLE [dbo].[fact_payment];
END

CREATE EXTERNAL TABLE dbo.fact_payment
WITH (
    LOCATION = 'fact_payment',
	DATA_SOURCE = [cuongtv22-filesystem_cuongtv22_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT
	pa.[payment_id],
	pa.[date],
	pa.[amount],
	pa.[rider_id],
	da.[date_id]
FROM [dbo].[staging_payment] as pa
JOIN [dbo].[dim_date] as da ON DATEPART(WEEKDAY, pa.[date]) = da.[day_of_week]
AND DATEPART(MONTH, pa.[date]) = da.[month]
AND DATEPART(YEAR, pa.[date]) = da.[year]
AND DATEPART(QUARTER, pa.[date]) = da.[quarter]

SELECT TOP 100 * FROM dbo.fact_payment
GO