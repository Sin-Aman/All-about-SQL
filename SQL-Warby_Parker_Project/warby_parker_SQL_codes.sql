 -- check out columns from survey table
 SELECT * FROM survey LIMIT 10;

-- number of responses for each quetion
 SELECT question, COUNT(DISTINCT user_id) 
 FROM survey
 GROUP BY question;

--checking out columns 
 SELECT * FROM quiz LIMIT 5;

 SELECT * FROM home_try_on LIMIT 5;

 SELECT * FROM purchase LIMIT 5;

-- creating a custom table for checking coversion rate
SELECT DISTINCT q.user_id,CASE 
WHEN h.user_id IS NOT NULL 
THEN 'True'
ELSE 'False'
END AS 'is_home_try_on',
h.number_of_pairs, CASE
WHEN p.user_id IS NOT NULL 
THEN 'True'
ELSE 'False'
END AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
ON q.user_id = h.user_id
LEFT JOIN purchase p
ON p.user_id = q.user_id
LIMIT 10;

-- adding other columns
SELECT DISTINCT q.user_id,
CASE 
WHEN h.user_id IS NOT NULL 
THEN 'True'
ELSE 'False'
END AS 'is_home_try_on',
h.number_of_pairs, p.model_name,p.color,p.price,
CASE
WHEN p.user_id IS NOT NULL 
THEN 'True'
ELSE 'False'
END AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
ON q.user_id = h.user_id
LEFT JOIN purchase p
ON p.user_id = q.user_id
LIMIT 10
;

-- To find the difference in purchase rates between customers of 3 pairs and 5 pairs
WITH conversion_table AS (
SELECT q.user_id,
h.user_id IS NOT NULL AS 'is_home_try_on',
h.number_of_pairs,
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
ON q.user_id = h.user_id
LEFT JOIN purchase p
ON p.user_id = q.user_id)
SELECT 'number_of_pairs' AS 'A/B_Test',
SUM(is_home_try_on) AS 'home_trial',
SUM(is_purchase) AS 'purchase'
FROM conversion_table
WHERE 'number_of_pairs' IS NOT NULL
GROUP BY 'number_of_pairs';

-- the most common style from the quiz - women's style - 469
SELECT style, COUNT(DISTINCT user_id) AS 'total'
FROM quiz 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- the most common fit from the quiz - narrow - 408
SELECT fit, COUNT(DISTINCT user_id) AS 'total'
FROM quiz 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- the most common shape from the quiz - rectangular - 397 
SELECT shape, COUNT(DISTINCT user_id) AS 'total'
FROM quiz 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- the most common color - tortoise - 292
SELECT color, COUNT(DISTINCT user_id) AS 'total'
FROM quiz 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- the most common types of purchases made
SELECT style, model_name, color, COUNT(*) AS 'Total'
FROM purchase
GROUP BY model_name
ORDER BY Total DESC;