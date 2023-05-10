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

/*P14 - Write a query that surfaces the top-ranked records in 1990, 2000, and 2010.*/
SELECT * 
  FROM tutorial.billboard_top_100_year_end
  WHERE year IN (1990, 2000, 2010)
  AND year_rank = 1;
  
/*P15 - Write a query that lists all songs from the 1960s with "love" in the title.*/
SELECT * 
  FROM tutorial.billboard_top_100_year_end
  WHERE song_name ILIKE '%love%'
  AND year BETWEEN 1960 AND 1969;

SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank = 5 OR artist = 'Gotye';
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2013
   AND ("group" ILIKE '%macklemore%' OR "group" ILIKE '%timberlake%');
   
/*P16 - Write a query that returns all rows for top-10 songs that featured either Katy Perry or Bon Jovi.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year_rank <= 10
  AND ("group" ILIKE '%katy perry%' OR "group" ILIKE '%bon jovi%');

/*P17 - Write a query that returns all songs with titles that contain the word "California" in either the 1970s or 1990s.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE song_name  ILIKE '%California%'
  AND (year BETWEEN 1970 AND 1979 OR
       year BETWEEN 1990 AND 1999);
       
/*P18 - Write a query that lists all top-100 recordings that feature Dr. Dre before 2001 or after 2009.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" ILIKE '%dr. dre%'
   AND (year <= 2000 OR year >= 2010);
   
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2013
  AND year_rank NOT BETWEEN 2 AND 3;
   
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2013
  AND year_rank NOT > 3;
  
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2013
  AND "group" NOT ILIKE '%macklemore%';
  
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2013
  AND artist IS NOT NULL;
  
/*P19 - Write a query that returns all rows for songs that were on the charts in 2013 and do not contain the letter "a".*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE song_name NOT ILIKE '%a%'
  AND year = 2013;
  
SELECT * FROM tutorial.billboard_top_100_year_end;

SELECT *
  FROM tutorial.billboard_top_100_year_end
  ORDER BY artist;
  
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2013
  ORDER BY year_rank;
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2013
  ORDER BY year_rank DESC;
  
/*P20 - Write a query that returns all rows from 2012, ordered by song title from Z to A.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2013
  ORDER BY song_name DESC;

-- Query returns the most recent years come first but orders top-ranks songs before lower-ranked songs
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year_rank <= 3
  ORDER BY year DESC, year_rank;

-- Ordering by column numbers
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year_rank <= 3
  ORDER BY 2, 1 DESC;

/*P21 - Write a query that returns all rows from 2010 ordered by rank, 
with artists ordered alphabetically for each song.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2010
  ORDER BY year_rank, artist;
  
/*P22 - Write a query that shows all rows for which T-Pain was a group member, 
ordered by rank on the charts, from lowest to highest rank (from 100 to 1).*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE "group" ILIKE '%T-Pain%'
  ORDER BY year_rank DESC;
  
/*P23 - Write a query that returns songs that ranked between 10 and 20 (inclusive) 
in 1993, 2003, or 2013. Order the results by year and rank, and leave a comment on 
each line of the WHERE clause to indicate what that line does*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year_rank BETWEEN 10 AND 20
  AND year IN (1993, 2003, 2013)
  ORDER BY year, year_rank;

