-- What are the top five stories with the highest scores?
SELECT title, score FROM hacker_news 
ORDER BY score DESC LIMIT 5;

-- find the total score of all the stories.
SELECT SUM(score) FROM hacker_news;

-- Find the individual users who have gotten combined scores of more than 200, and their combined scores.
SELECT user, SUM(score) FROM hacker_news
GROUP BY user
HAVING SUM(score) > 200;

-- add these users’ scores together and divide by the total to get the percentage.
SELECT (309 + 304 + 282 + 517) / 6366.0;

-- The url of the video is: https://www.youtube.com/watch?v=dQw4w9WgXcQ. How many times has each offending user posted this link?
How many times has each offending user posted this link?
SELECT user, COUNT(*) FROM hacker_news
WHERE url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
GROUP BY user ORDER BY 2 DESC;

-- we want to categorize each story based on their source.
SELECT CASE
WHEN url LIKE '%github.com%' THEN 'GitHub'
WHEN url LIKE '%medium.com%' THEN 'Medium'
WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
ELSE 'Other'
END AS 'Source'
FROM hacker_news;

-- Add a column for the number of stories from each URL using COUNT(). Also, GROUP BY the CASE statement.
SELECT CASE
WHEN url LIKE '%github.com%' THEN 'GitHub'
WHEN url LIKE '%medium.com%' THEN 'Medium'
WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
ELSE 'Other'
END AS 'Source', COUNT(*)
FROM hacker_news
GROUP BY 1;

-- test strftime 
SELECT timestamp, strftime('%H', timestamp) FROM hacker_news
GROUP BY 1 LIMIT 20;

-- query that returns three columns: The hours of the timestamp, The average score for each hour, The count of stories for each hour.
SELECT strftime('%H', timestamp) AS 'Hour', AVG(score), COUNT(*)
FROM  hacker_news
GROUP BY 1
ORDER BY 2;

-- Round the average scores (ROUND()). Rename the columns to make it more readable (AS). Add a WHERE clause to filter out the NULL values in timestamp.
SELECT strftime('%H', timestamp) AS 'Hour', 
ROUND(AVG(score)) AS 'Average Score', 
COUNT(*) AS 'Number of Stories'
FROM  hacker_news
WHERE timestamp IS NOT NULL
GROUP BY 1
ORDER BY 2;