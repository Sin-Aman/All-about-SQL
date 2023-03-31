 --What are the column names?
 SELECT * FROM met LIMIT 10;

-- How many pieces are in the American Decorative Art collection?
 SELECT COUNT(*) FROM met;

 -- Count the number of pieces where the category includes ‘celery’.
 SELECT COUNT(*) FROM met 
 WHERE category LIKE '%celery%';

-- Find the title and medium of the oldest piece(s) in the collection.
SELECT MIN(date) FROM met;
SELECT date, title, medium FROM met
WHERE date LIKE '%1600%';

--Find the top 10 countries with the most pieces in the collection.
SELECT country, COUNT(*) FROM met
GROUP BY 1
ORDER BY COUNT(*) DESC LIMIT 10;

-- Find the categories HAVING more than 100 pieces.
SELECT category, COUNT(*) FROM met
GROUP BY 1
HAVING COUNT(*) > 100;

-- Count the number of pieces where the medium contains ‘gold’ or ‘silver’.And sort in descending order.
SELECT CASE
WHEN medium LIKE '%gold%' THEN 'Gold'
WHEN medium LIKE '%SILVER%' THEN 'Silver'
ELSE NULL END AS 'Medium', COUNT(*) FROM met
WHERE medium IS NOT NULL
GROUP BY 1
ORDER BY COUNT(*) DESC;