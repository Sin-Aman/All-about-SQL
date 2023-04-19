
SELECT * FROM state_climate;

-- Write a query that returns the state, year, tempf or tempc, and running_avg_temp (in either Celsius or Fahrenheit) for each state.
SELECT state, year, tempf, tempc,
       AVG(tempf) OVER (PARTITION BY state 
       ORDER BY YEAR) AS 'running_avg_tempf',
       AVG(tempc) OVER (PARTITION BY state 
       ORDER BY YEAR) AS 'running_avg_tempc'
FROM state_climate;

-- Write a query that returns state, year, tempf or tempc, and the lowest temperature (lowest_temp) for each state.
SELECT state, year, tempf,tempc, 
MIN(tempf) OVER (PARTITION BY state) AS lowest_tempf
FROM state_climate
ORDER BY state, year;

-- Write a query that returns state, year, tempf or tempc, except now we will also return the highest temperature (highest_temp) for each state.
SELECT state, year, tempf,tempc, 
MIN(tempf) OVER (PARTITION BY state) AS lowest_tempf,
MAX(tempf) OVER (PARTITION BY state) AS highest_tempf
FROM state_climate
ORDER BY state, year;

-- Write a query to select the same columns but now you should write a window function that returns the change_in_temp from the previous year
SELECT state, year, tempf, tempc, 
       (tempf - LAG(tempf) OVER (PARTITION BY state ORDER BY year)) AS change_in_tempf,
       (tempc - LAG(tempc) OVER (PARTITION BY state ORDER BY year)) AS change_in_tempc
FROM state_climate
ORDER BY state, year;

-- Write a query to return a rank of the coldest temperatures on record (coldest_rank) along with year, state, and tempf or tempc.
SELECT state, year, tempf, 
       RANK() OVER(PARTITION BY state ORDER BY tempf ASC) AS coldest_rank
FROM state_climate
ORDER BY state, tempf ASC;

-- Modify your coldest_rank query to now instead return the warmest_rank for each state, meaning your query should return the warmest temp/year for each state.
SELECT state, year, tempf, 
       RANK() OVER(PARTITION BY state 
       ORDER BY tempf DESC) AS warmest_rank
FROM state_climate
ORDER BY state, tempf DESC;

-- write a query that will return the average yearly temperatures in quartiles instead of in rankings for each state.
-- Your query should return quartile, year, state and tempf or tempc. The top quartile should be the coldest years.
SELECT NTILE(4) OVER (PARTITION BY state 
ORDER BY tempf ASC) AS quartile,
       year, state, tempf, tempc
FROM state_climate
ORDER BY tempf ASC, year;

-- Write a query that will return the average yearly temperatures in quintiles (5).
-- Your query should return quintile, year, state and tempf or tempc. The top quintile should be the coldest years overall, not by state.
SELECT NTILE(5) OVER (PARTITION BY state 
ORDER BY tempf ASC) AS quintile,
       year, state, tempf, tempc
FROM state_climate
ORDER BY tempf ASC, year;