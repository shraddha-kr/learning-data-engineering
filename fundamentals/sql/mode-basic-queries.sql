/*DataSet - https://www.census.gov/econ_datasets*/

/*Mode Database*/
CREATE DATABASE postgres;

\c mode;

/*Import a datset csv file in PostgreSQL*/
CREATE TABLE us_housing_units (
  year FLOAT,
  month FLOAT,
  month_name VARCHAR(20),
  south FLOAT,
  west FLOAT,
  midwest FLOAT,
  northeast FLOAT
);

commit;

SELECT * FROM us_housing_units LIMIT 10;

COPY us_housing_units(year, month, month_name, south, west, midwest, northeast)
FROM '/home/ubuntu/Desktop/Github/learning-data-engineering/fundamentals/sql/mode-dataset.csv'
DELIMITER ','
CSV HEADER;

/*Limit the select result to 10 queries*/
SELECT year,
       month,
       west
  FROM tutorial.us_housing_units LIMIT 10;
  
/*Re-name columns*/  
SELECT year, month, west 
  AS "west-region"
  FROM tutorial.us_housing_units LIMIT 10;

/*WHERE Clause*/
SELECT *
  FROM tutorial.us_housing_units
  WHERE month = 1;
 
/*Comparison Operators*/
/*Numerical*/ 
/*P1 - Did the West Region ever produce more than 50,000 housing units in one month?*/
SELECT *
  FROM tutorial.us_housing_units
  WHERE west > 50;
  
/*P2 - Did the South Region ever produce 20,000 or fewer housing units in one month?*/
SELECT *
  FROM tutorial.us_housing_units
  WHERE south <= 20; 

/*Non-Numerical*/
SELECT *
  FROM tutorial.us_housing_units
  WHERE month_name != 'January'
 
SELECT *
  FROM tutorial.us_housing_units
  WHERE month_name > 'January'
 
SELECT *
  FROM tutorial.us_housing_units
  WHERE month_name > 'J';

/*P3 - Write a query that only shows rows for which the month name is February.*/
SELECT *
  FROM tutorial.us_housing_units
  WHERE month_name = 'February';
 
/*P4 - Write a query that only shows rows for which the month_name starts with the letter "N" or an earlier letter in the alphabet.*/
SELECT *
  FROM tutorial.us_housing_units
  WHERE month_name <= 'N' ;
 /*month_name < 'o'*/
 
SELECT year,
       month,
       west,
       south,
       west + south AS south_plus_west
  FROM tutorial.us_housing_units;
  
SELECT year,
       month,
       west,
       south,
       west + south - 4 * year AS nonsense_column
  FROM tutorial.us_housing_units;
  
/*P5 - Write a query that calculates the sum of all four regions in a separate column.*/
SELECT year,
       month,
       (west + south + midwest + northeast) AS sum_of_all_regions
  FROM tutorial.us_housing_units;
  
SELECT year,
       month,
       west,
       south,
       (west + south)/2 AS south_west_avg
  FROM tutorial.us_housing_units;
  
/*P6 - Write a query that returns all rows for which more units were produced in the West region 
than in the Midwest and Northeast combined.*/
SELECT year,
       month
  FROM tutorial.us_housing_units
  WHERE west > (midwest + northeast);

/*P7 - Write a query that calculates the percentage of all houses completed in the United States represented by each region. Only return results from the year 2000 and later.*/
SELECT year,
       month,
       west/(west + south + midwest + northeast)*100 AS west_pct,
       south/(west + south + midwest + northeast)*100 AS south_pct,
       midwest/(west + south + midwest + northeast)*100 AS midwest_pct,
       northeast/(west + south + midwest + northeast)*100 AS northeast_pct
  FROM tutorial.us_housing_units
  WHERE year >= 2000;
  
/*Logical Operators*/
SELECT * FROM tutorial.billboard_top_100_year_end;

SELECT *
  FROM tutorial.billboard_top_100_year_end
 ORDER BY year DESC, year_rank;

/*Col name same as sql reserved words*/
/*"group" appears in quotations above because GROUP is actually the name of a function in SQL. 
The double quotes (as opposed to single: ') are a way of indicating that you are referring to the column name "group", not the SQL function. 
In general, putting double quotes around a word or phrase will indicate that you are referring to that column name.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" LIKE 'Snoop%';
 
/*Wildcards*/
/*The % used above represents any character or set of characters. 
In this case, % is referred to as a "wildcard." 
In the type of SQL that Mode uses, LIKE is case-sensitive, meaning that the above query will only capture matches that start with a capital "S" and lower-case "noop." 
To ignore case when you're matching values, you can use the ILIKE command
You can also use _ (a single underscore) to substitute for an individual character*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" ILIKE 'snoop%';
 
/*P8 - Write a query that returns all rows for which Ludacris was a member of the group.*/
SELECT  * 
  FROM  tutorial.billboard_top_100_year_end
  WHERE "group" ilike '%ludacris%';
  
/*P9 - Write a query that returns all rows for which the first artist listed in the 
group has a name that begins with "DJ".*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" LIKE 'DJ%'

SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank IN (1, 2, 3);
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE artist IN ('Taylor Swift', 'Usher', 'Ludacris');

/*P10 - Write a query that shows all of the entries for Elvis and M.C. Hammer.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE "group" IN ('M.C. Hammer', 'Hammer', 'Elvis Presley');

SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year_rank BETWEEN 5 AND 10;
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year_rank >= 5 AND year_rank <= 10;

/*P11 - Write a query that shows all top 100 songs from January 1, 1985 through December 31, 1990.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year BETWEEN 1985 AND 1990;
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE artist IS NULL;

/*P12 - Write a query that shows all of the rows for which song_name is null.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE song_name IS NULL;
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2012 AND year_rank <= 10;
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2012
  AND year_rank <= 10
  AND "group" ILIKE '%feat%';
   
/*P13 - Write a query that surfaces all rows for top-10 hits for which Ludacris is part of the Group.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year_rank <= 10
  AND "group" ILIKE '%ludacris%';  
