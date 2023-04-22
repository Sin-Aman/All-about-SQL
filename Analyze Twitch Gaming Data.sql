-- Select the first 20 rows from each of the two tables; stream and chat.
SELECT * FROM stream LIMIT 20;
SELECT * FROM chat LIMIT 20;

-- What are the unique games in the stream table?
SELECT DISTINCT(game) FROM stream;

-- What are the unique channels in the stream table?
SELECT DISTINCT(channel) FROM stream;

-- What are the most popular games in the stream table? Create a list of games and their number of viewers using GROUP BY.
SELECT game, COUNT(*)
FROM stream
GROUP BY 1
ORDER BY 2 DESC; 

-- Where are these LoL stream viewers located? Create a list of countries and their number of LoL viewers using WHERE and GROUP BY.
SELECT country, COUNT(*) FROM stream
WHERE game = 'League of Legends' 
GROUP BY country
ORDER BY 2 DESC;

-- The player column contains the source the user is using to view the stream (site, iphone, android, etc). Create a list of players and their number of streamers.
SELECT player, COUNT(player)
FROM stream
GROUP BY 1
ORDER BY 2 DESC;

-- Create a new column named genre for each of the games. Group the games into their genres: Multiplayer Online Battle Arena (MOBA), First Person Shooter (FPS), Survival, and Other.
-- Using CASE, your logic should be:
-- If League of Legends → MOBA
-- If Dota 2 → MOBA
-- If Heroes of the Storm → MOBA
-- If Counter-Strike: Global Offensive → FPS
-- If DayZ → Survival
-- If ARK: Survival Evolved → Survival
-- Else → Other
-- Use GROUP BY and ORDER BY to showcase only the unique game titles.
SELECT game, CASE 
             WHEN game = 'League of Legends' THEN 'MOBA'
             WHEN game = 'Dota 2' THEN 'MOBA'
             WHEN game = 'DayZ' THEN 'MOBA'
             WHEN game = 'Heroes of the Strom' THEN 'MOBA'
             WHEN game = 'Counter-Strike: Global Offensive' THEN 'FPS'
             WHEN game = 'Survival Evolved' THEN 'Survival'
             ELSE 'Other'
             END AS genre,
             COUNT(game)            
FROM stream
GROUP BY game
ORDER BY COUNT(game) DESC;

-- write a query that returns two columns:
-- The hours of the time column
-- The view count for each hour
-- Lastly, filter the result with only the users in your country using a WHERE clause.
SELECT strftime('%H', time), COUNT(1)
FROM stream
WHERE COUNTRY = 'US'
GROUP BY 1;

-- Use JOIN; The stream table and the chat table share a column: device_id.
SELECT * FROM stream JOIN chat 
ON stream.device_id = chat.device_id
LIMIT 20;