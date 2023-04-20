/*DataSet - https://www.census.gov/econ_datasets*/

/*Mode Database*/
CREATE DATABASE mode;

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