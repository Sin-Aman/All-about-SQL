-- Codecademy
-- select first 10 rows from each table.
SELECT * FROM users LIMIT 10;
SELECT * FROM posts LIMIT 10;
SELECT * FROM subreddits LIMIT 10;

-- query to find out how many different subreddits are there.
SELECT COUNT(*) FROM subreddits;

-- What user has the highest score?
SELECT username, MAX(score) FROM users;

-- What post has the highest score?
SELECT title, MAX(score) FROM posts;
-- What are the top 5 subreddits with the highest subscriber_count?
SELECT name, subscriber_count FROM subreddits
ORDER BY 2 DESC LIMIT 5;

-- Use a LEFT JOIN with the users and posts tables to find out how many posts each user has made. Have the users table as the left table and order the data by the number of posts in descending order.
SELECT users.username, COUNT(posts.title) AS 'posts_made'
FROM users LEFT JOIN posts
ON users.id = posts.user_id 
GROUP BY users.id
ORDER BY 2;

-- We only want to see existing posts where the users are still active, so use an INNER JOIN to write a query to get these posts. Have the posts table as the left table.
SELECT * FROM posts INNER JOIN users
ON posts.user_id = users.id;

-- Stack the new posts2 table under the existing posts table to see them.
SELECT * FROM posts UNION
SELECT * FROM posts2;

-- find out which subreddits have the most popular posts.
WITH popular_posts AS (
  SELECT *
  FROM posts
  WHERE score >= 5000
)
SELECT subreddits.name, popular_posts.title, popular_posts.score
FROM subreddits
INNER JOIN popular_posts
  ON subreddits.id = popular_posts.subreddit_id
ORDER BY popular_posts.score DESC;

-- find out the highest scoring post for each subreddit.
SELECT 
  posts.title, 
  subreddits.subscriber_count AS 'subreddit_name', 
  MAX(score) AS 'highest_score'
FROM posts
INNER JOIN subreddits
  ON posts.subreddit_id = subreddits.id
GROUP BY subreddits.id;

--  write a query to calculate the average score of all the posts for each subreddit.
SELECT 
  subreddits.name, 
  AVG(posts.score) AS 'average_score'
FROM subreddits
INNER JOIN posts
ON subreddits.id = posts.subreddit_id
GROUP BY subreddits.name
ORDER BY 2 DESC;