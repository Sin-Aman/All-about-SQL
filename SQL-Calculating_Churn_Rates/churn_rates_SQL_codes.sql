-- first 100 rows of 'subscriptions' table.
SELECT * 
FROM subscriptions
LIMIT 100;

-- range of months to calculate churn rates for
SELECT MAX(subscription_start) FROM subscriptions;
SELECT MIN(subscription_start) FROM subscriptions;

-- creating temporary table 'months'
WITH months AS
(SELECT 
'2017-01-01' AS first_day,
'2017-01-31' AS last_day
UNION
SELECT 
'2017-02-01' AS first_day,
'2017-02-28' AS last_days
UNION
SELECT 
'2017-03-01' AS first_day,
'2017-03-31' AS last_day),
cross_join AS(          -- temporary table cross join 
  SELECT * FROM subscriptions
  CROSS JOIN months),
status AS(              -- temporary table status 
  SELECT id, 
  first_day AS month,
  CASE 
    WHEN (subscription_start < first_day) 
    AND (subscription_end > first_day OR 
    subscription_end IS NULL)
    AND (segment = 87)
    THEN 1 ELSE 0 
    END AS is_active_87,
  CASE 
    WHEN (subscription_start < first_day) 
    AND (subscription_end > first_day OR 
    subscription_end IS NULL)
    AND (segment = 30)
    THEN 1 ELSE 0 
    END AS is_active_30,
  CASE
    WHEN (subscription_end BETWEEN first_day AND last_day)
    AND (segment = 87) 
    THEN 1 ELSE 0
    END AS is_canceled_87,
  CASE
    WHEN (subscription_end BETWEEN first_day AND last_day)
    AND (segment = 30) 
    THEN 1 ELSE 0
    END AS is_canceled_30
    FROM cross_join),
  status_aggregate AS(        -- temporary table status_aggregate 
  SELECT month,
  SUM(is_active_87) AS sum_active_87,
  SUM(is_active_30) AS sum_active_30,
  SUM(is_canceled_87) AS sum_canceled_87,
  SUM(is_canceled_30) AS sum_canceled_30
  FROM status
  GROUP BY month
  )
-- calculating churn rates for two segnments over JAN-MAR
SELECT month,
1.0 * sum_canceled_87/ sum_active_87 AS churn_rate_87,
1.0 * sum_canceled_30/ sum_active_30 AS churn_rate_30
FROM status_aggregate;
