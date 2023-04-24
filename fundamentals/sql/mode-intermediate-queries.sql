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