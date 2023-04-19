--Attribution Queries

-- How many campaigns and sources does CoolTShirts use? Which source is used for each campaign?

-- one for the number of distinct campaigns,
SELECT COUNT(DISTINCT utm_campaign) FROM  page_visits;

-- one for the number of distinct sources,
SELECT COUNT(DISTINCT utm_source) FROM page_visits;

-- one to find how they are related.
SELECT DISTINCT utm_campaign, utm_source FROM page_visits;

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- What pages are on the CoolTShirts website? Find the distinct values of the page_name column.
SELECT DISTINCT page_name FROM page_visits;

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- How many first touches is each campaign responsible for? use the first-touch query ; Group by campaign and count the number of first touches for each.
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
        pv.utm_campaign,
        COUNT(utm_campaign)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
    GROUP BY utm_campaign
    ORDER BY 5 DESC;

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- How many last touches is each campaign responsible for? use the last-touch query ; group by campaign and count the number of last touches for each.
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
        pv.utm_campaign,
        COUNT(utm_campaign)
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
    GROUP BY utm_campaign
    ORDER BY 5 DESC;

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- How many visitors make a purchase? Count the distinct users who visited the page named 4 - purchase.
SELECT COUNT(DISTINCT user_id)
FROM page_visits 
WHERE page_name = '4 - purchase';

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- How many last touches on the purchase page is each campaign responsible for?
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
        pv.utm_campaign,
        COUNT(utm_campaign)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
    GROUP BY utm_campaign
    ORDER BY 5 DESC;

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++