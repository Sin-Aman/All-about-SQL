-- Codecademy
-- Contents of the tables
SELECT * FROM places;

SELECT * FROM reviews;

-- If each dollar sign ($) represents $10, how could you find all places that cost $20 or less?
SELECT * FROM places
WHERE price_point = '$$' OR
      price_point = '$';

--  Write a query to do an INNER JOIN on the two tables to show all reviews for restaurants that have at least one review.
SELECT * FROM places INNER JOIN reviews
ON places.id = reviews.place_id
WHERE total_reviews >= 1;

--Modify your previous query to select only the most important columns in order to display a log of reviews by selecting the following: From the places table: name, average_rating. From the reviews table: username, rating, review_date, note
SELECT places.name, places.average_rating,
       reviews.username, reviews.rating, reviews.review_date, reviews.note
FROM places INNER JOIN reviews
ON places.id = reviews.place_id;

-- Now write a query to do a LEFT JOIN on the tables, selecting the same columns as the previous question.
SELECT places.name, places.average_rating,
       reviews.username, reviews.rating, reviews.review_date, reviews.note
FROM places LEFT JOIN reviews
ON places.id = reviews.place_id;

-- Write a query to find all the ids of places that currently do not have any reviews in our reviews table.
SELECT places.id, places.name
FROM places LEFT JOIN reviews 
ON places.id = reviews.place_id
WHERE reviews.place_id IS NULL;

-- Write a query using the WITH clause to select all the reviews that happened in 2020. JOIN the places to your WITH query to see a log of all reviews from 2020.
SELECT * FROM places 
INNER JOIN (SELECT * FROM reviews 
WHERE strftime('%Y', review_date) = '2020') AS reviews_in_2020
ON places.id = reviews_in_2020.place_id
ORDER BY id ;

-- Write a query that finds the reviewer with the most reviews that are BELOW the average rating for places.
SELECT username, COUNT(total_reviews), rating 
FROM reviews JOIN places
ON reviews.place_id = places.id
WHERE rating < average_rating
GROUP BY username
ORDER BY 2 DESC LIMIT 1;