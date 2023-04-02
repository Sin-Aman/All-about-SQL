-- @Codecademy
-- Find out the column names from the three tables
SELECT * FROM trips;
SELECT * FROM riders;
SELECT * FROM cars;

-- Cross join riders and cars;
SELECT * FROM riders CROSS JOIN cars;

-- left join trips and users table on selective columns
SELECT trips.date,
       riders.first, riders.last,
       trips.pickup, trips.dropoff,
       trips. type, trips.cost, riders.rating
FROM trips LEFT JOIN riders
ON trips.rider_id = riders.id;

-- Create a link between trips and the cars table used during those trips. Comnbine both tables using Inner join.
SELECT *
FROM trips INNER JOIN cars
ON trips.car_id = cars.id;

SELECT * FROM riders UNION
SELECT * FROM riders2;

-- Find the Average cost for a trip
SELECT ROUND(AVG(cost),2) FROM trips;

-- Find all users who have used Lfyt less than 500 times.
SELECT id, first, last, total_trips FROM riders 
WHERE total_trips < 500;

-- Calculate the number of cars that are active.
SELECT COUNT(*) FROM cars
WHERE status = 'active';

-- Write a query that finds the two cars that have the highest trips_completed.
SELECT id,model,trips_completed
FROM cars
ORDER BY 3 DESC 
LIMIT 2;
