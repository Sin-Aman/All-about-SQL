-- SQL Coding Challenge Prep
-- Select the title, author, and average_rating of each book with an average_rating between 3.5 and 4.5.
SELECT title,
       author,
       average_rating
FROM books
WHERE average_rating BETWEEN 3.5 AND 4.5;

-- Select all the unique authors from the table.
SELECT DISTINCT(author) FROM books;

-- Given the final scores of several NBA games, use CASE to return the results for each game:
-- If home team won, return ‘HOME WIN’.
-- If away team won, return ‘AWAY WIN’.
-- Select the id column and the CASE result.
SELECT id, CASE
           WHEN home_points > away_points
           THEN 'HOME WIN'
           ELSE 'AWAY WIN'
           END AS 'CASE'
FROM nba_matches;

-- Find the number of apps by genre.
SELECT genre, COUNT(id) FROM apps
GROUP BY genre;

-- Get the total number of reviews of all apps by genre. 
-- Limit the results for genres where the total number of app reviews is over 30 million.
SELECT genre, SUM(reviews) FROM apps
GROUP by genre 
HAVING SUM(reviews) > 30000000;

-- Select the name, genre, and rating of apps in descending order of their rating, and limit the result to 20 rows.
SELECT name, genre, rating 
FROM apps
ORDER BY rating DESC
LIMIT 20;

-- Find the lowest and highest rating for all apps using two different queries.
SELECT MIN (rating) FROM apps;
SELECT MAX(rating) FROM apps;

-- Get the average rating of all apps, rounded to 2 decimal places. Alias the result column as ‘average rating’.
SELECT ROUND(AVG(rating), 2) AS 'average rating' FROM apps;

-- The projects table has the following columns: id, employee_id
-- The employees table has the following columns: id, first_name, last_name
-- The projects table stores the employee_id for the employee assigned to each project.
-- Perform an inner join on the two tables, matching on the primary key and foreign key described above, and select all columns.
SELECT * FROM projects INNER JOIN employees
ON projects.employee_id = employees.id;

-- Perform a join between the two tables, such that it selects all projects even if there is no employee assigned to it.
SELECT * FROM projects LEFT JOIN employees
ON projects.employee_id = employees.id;

-- Using a subquery, get all students in math who are also enrolled in english.
SELECT * FROM math_students
WHERE student_id IN (
  SELECT student_id FROM english_students);

-- Using a subquery, find out which students in math are in the same grade level as the student with id 7.
SELECT * from math_students WHERE grade IN
(SELECT grade FROM math_students
WHERE student_id = 7);

-- Using a subquery, find all students enrolled in english class who are not also enrolled in math class.
SELECT * FROM english_students
 WHERE student_id NOT IN 
(SELECT student_id FROM math_students);

-- Using a subquery, find out what grade levels are represented in both the math and english classes.
SELECT grade FROM math_students
WHERE EXISTS(SELECT grade FROM english_students);

-- Using a window function with PARTITION BY, get the running total in gross for each movie up to the current week 
-- and display it next to the current week column along with the title, week, and gross columns.
SELECT title, week, gross, SUM(gross) 
       OVER (PARTITION BY title
       ORDER BY week) AS 'running_total_gross'
FROM box_office;

-- Given an orders table, calculate the price times quantity of each order. Include the id and product_id columns in the result.
SELECT id, product_id, price * quantity 
FROM orders;

-- Utilize CAST to calculate the average of the low and high temperatures for each date such that the result is of type REAL.
-- Select the date column and alias this result column as ‘average’.
SELECT date, (CAST(high AS 'REAL') +
             CAST(low AS 'REAL')) / 2.0 AS 'average'
FROM weather;

-- After a purchase is created, it can be returned within 7 days for a full refund.
-- Using modifiers, get the date of each purchase offset by 7 days in the future.
SELECT purchase_id, DATE(purchase_date, '+7 days')
FROM purchases;

-- Get the hour that each purchase was made.
SELECT STRFTIME('%H', purchase_date)
FROM purchases;

-- Using string formatting and substitutions, get the month and day for each purchase in the form ‘mm-dd’.
-- Give this new column a name of ‘reformatted’.
SELECT STRFTIME('%m-%d', purchase_date) AS 'reformatted'
FROM purchases;