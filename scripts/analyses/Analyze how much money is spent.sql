-- Per month, quarter, year
SELECT
    AVG(pa.[amount]) as avg_amount,
    SUM(pa.[amount])as sum_amount,
    da.[year],
    da.[quarter],
    da.[month]
FROM [dbo].[fact_payment] pa
JOIN [dbo].[dim_date] da ON pa.date_id = da.date_id
JOIN [dbo].[dim_rider] ri ON pa.rider_id = ri.rider_id
GROUP BY da.[year], da.[quarter], da.[month]
ORDER BY da.[year], da.[quarter], da.[month];

-- Per member, based on the age of the rider at account start
SELECT
    AVG(pa.[amount]) as avg_amount,
    SUM(pa.[amount])as sum_amount,
    COUNT(pa.[amount])as count,
    ri.[account_start_age]
FROM [dbo].[fact_payment] pa
JOIN [dbo].[dim_rider] ri ON pa.rider_id = ri.rider_id
GROUP BY ri.[account_start_age]
ORDER BY ri.[account_start_age];