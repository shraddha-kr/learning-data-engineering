/*Intermediate SQl Queries*/
SELECT * FROM tutorial.aapl_historical_stock_price;

/*Non NULL rows*/
SELECT COUNT(high)
  FROM tutorial.aapl_historical_stock_price;
  
/*P1 - Write a query to count the number of non-null rows in the low column.*/
SELECT COUNT(low) AS low_count
  FROM tutorial.aapl_historical_stock_price;
-- The above query returns the same result as the previous: 3555. It's hard to tell because each row has a different date value, but COUNT simply counts the total number of non-null rows, not the distinct values.

SELECT COUNT(year) AS year,
       COUNT(month) AS month,
       COUNT(open) AS open,
       COUNT(high) AS high,
       COUNT(low) AS low,
       COUNT(close) AS close,
       COUNT(volume) AS volume
  FROM tutorial.aapl_historical_stock_price;
  
  /*P2 - Write a query to calculate the average opening price*/
  SELECT SUM(open)/COUNT(open) AS avg_open_price FROM tutorial.aapl_historical_stock_price;
  
  /*P3 - What was Apple's lowest stock price */
  SELECT MIN(low) FROM tutorial.aapl_historical_stock_price;
  
  /*P4 - What was the highest single-day increase in Apple's share value?*/
  SELECT MAX(close - open) FROM tutorial.aapl_historical_stock_price;
  
  SELECT AVG(high)
  FROM tutorial.aapl_historical_stock_price
  WHERE high IS NOT NULL;

/*P5 - Write a query that calculates the average daily trade volume for Apple stock.*/
 SELECT AVG(volume) AS avg_volume
  FROM tutorial.aapl_historical_stock_price;
  
/*GROUP BY*/
--SQL aggregate function like COUNT, AVG, and SUM have something in common: they all aggregate across the entire table. But what if you want to aggregate only part of a table? For example, you might want to count the number of entries for each year.
SELECT year,
       COUNT(*) AS count
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year;
 
 -- GROUPBY multiple columns
 SELECT year,
       month,
       COUNT(*) AS count
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month;

/*P6 - Calculate the total number of shares traded each month. Order your results chronologically.*/
SELECT year,
       month,
       SUM(volume) AS volume_sum
  FROM tutorial.aapl_historical_stock_price
  GROUP BY year, month
  ORDER BY year, month;
  
SELECT year,
       month,
       COUNT(*) AS count
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month
 ORDER BY month, year;
 
/*P7 - Write a query to calculate the average daily price change in Apple stock, grouped by year.*/
SELECT year, AVG(open - close) AS avg_daily_change
  FROM tutorial.aapl_historical_stock_price
  GROUP BY year
  ORDER BY year;
  
/*P8 - Write a query that calculates the lowest and highest prices that Apple stock achieved each month.*/
SELECT year,
       month,
       MIN(low) AS lowest_price,
       MAX(high) AS highest_price
  FROM tutorial.aapl_historical_stock_price
 GROUP BY 1, 2
 ORDER BY 1, 2;
 
SELECT year,
       month,
       MAX(high) AS month_high
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month
HAVING MAX(high) > 400
 ORDER BY year, month;
 
SELECT * FROM benn.college_football_players;

SELECT player_name,
       year,
       CASE WHEN year = 'SR' THEN 'yes'
            ELSE NULL END AS is_a_senior
  FROM benn.college_football_players;
  
SELECT player_name,
       year,
       CASE WHEN year = 'SR' THEN 'yes'
            ELSE 'no' END AS is_a_senior
  FROM benn.college_football_players;
  
/*P9 - Write a query that includes a column that is flagged "yes" when a player is from California, 
and sort the results with those players first.*/
SELECT player_name,
       state,
       CASE WHEN state = 'CA' THEN 'yes'
            ELSE NULL END AS from_california
  FROM benn.college_football_players
 ORDER BY 3;

SELECT player_name,
       weight,
       CASE WHEN weight > 250 THEN 'over 250'
            WHEN weight > 200 THEN '201-250'
            WHEN weight > 175 THEN '176-200'
            ELSE '175 or under' END AS weight_group
  FROM benn.college_football_players;
  
SELECT player_name,
       weight,
       CASE WHEN weight > 250 THEN 'over 250'
            WHEN weight > 200 AND weight <= 250 THEN '201-250'
            WHEN weight > 175 AND weight <= 200 THEN '176-200'
            ELSE '175 or under' END AS weight_group
  FROM benn.college_football_players;
  
/*P10 - Write a query that includes players' names and a column that classifies them into four categories based on height.
Keep in mind that the answer we provide is only one of many possible answers, since you could divide players' heights in many ways.*/
SELECT player_name,
       height, -- don't forget the comma, before the case since its treated as a col result
       CASE WHEN height < 60 THEN 'less than 60'
            WHEN height > 60 AND height < 70 THEN 'more than 60'
            WHEN height > 70 AND height < 80 THEN 'more than 70'
            ELSE '80 or above' END AS height_group
  FROM benn.college_football_players
  ORDER BY 3;
  
/*P11 - Write a query that selects all columns from benn.college_football_players and adds an additional column that displays 
the player's name if that player is a junior or senior.*/
SELECT *,
       CASE WHEN year IN ('JR', 'SR') THEN player_name ELSE NULL END AS upperclass_player_name
  FROM benn.college_football_players;

SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' END AS year_group,
            COUNT(1) AS count
  FROM benn.college_football_players
 GROUP BY year_group;
 
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' END AS year_group,
            *
  FROM benn.college_football_players;

/*P12 - Write a query that counts the number of 300lb+ players for each of the following regions: West Coast (CA, OR, WA), Texas, and Other (everywhere else).*/
SELECT CASE WHEN state = 'CA'  OR state = 'OR' OR state = 'WA' THEN 'West Coast'
            WHEN state = 'TX' THEN 'Texas'
            ELSE 'Other' END AS player_region,
            COUNT(*) AS players
  FROM benn.college_football_players
  WHERE weight >= 300
  GROUP BY 1;
  
/*P13 - Write a query that calculates the combined weight of all underclass players (FR/SO) in California as well as the combined weight 
of all upperclass players (JR/SR) in California.*/
SELECT CASE WHEN year IN ('FR', 'SO') THEN 'underclass'
            WHEN year IN ('JR', 'SR') THEN 'upperclass'
            ELSE NULL END AS class_group,
       SUM(weight) AS combined_player_weight
  FROM benn.college_football_players
 WHERE state = 'CA'
 GROUP BY 1;
 
/*P14 - Write a query that displays the number of players in each state, with FR, SO, JR, and SR players in separate columns 
and another column for the total number of players. 
Order results such that states with the most players come first.*/
SELECT COUNT(CASE WHEN state = 'FR' THEN 1 END) AS FR,
       COUNT(CASE WHEN state = 'SO' THEN 1 END) AS SO,
       COUNT(CASE WHEN state = 'JR' THEN 1 END) AS JR,
       COUNT(CASE WHEN state = 'SR' THEN 1 END) AS SR,
       COUNT(1) AS total_players
  FROM benn.college_football_players
  GROUP BY state 
  ORDER BY total_players DESC;

/*P15 - Write a query that shows the number of players at schools with names that start with A through M, and the number at schools with names starting with N - Z.*/
SELECT CASE WHEN school_name < 'n' THEN 'A-M'
            WHEN school_name >= 'n' THEN 'N-Z'
            ELSE NULL END AS school_name_group,
       COUNT(1) AS players
  FROM benn.college_football_players
 GROUP BY 1;
 
/*DISTINCT*/
SELECT DISTINCT month
FROM tutorial.aapl_historical_stock_price;

SELECT DISTINCT year, month
FROM tutorial.aapl_historical_stock_price;

/*Write a query that returns the unique values in the year column, in chronological order.*/
SELECT DISTINCT year 
FROM tutorial.aapl_historical_stock_price
ORDER BY year ASC;

SELECT COUNT(DISTINCT month) AS unique_months
  FROM tutorial.aapl_historical_stock_price;
  
SELECT month,
       AVG(volume) AS avg_trade_volume
  FROM tutorial.aapl_historical_stock_price
 GROUP BY month
 ORDER BY 2 DESC;
 
/*P16 - Write a query that counts the number of unique values in the month column for each year.*/
SELECT year,
       COUNT(DISTINCT month) AS months_count
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year
 ORDER BY year;
 
/*P17 - Write a query that separately counts the number of unique values in the month column and the number of unique values in the `year` column.*/
SELECT COUNT(DISTINCT year) AS years_count,
       COUNT(DISTINCT month) AS months_count
  FROM tutorial.aapl_historical_stock_price;