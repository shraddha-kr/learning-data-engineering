-- on an ubuntu machine, follow the following commands to install snowsql, download the latest linux rpm from https://developers.snowflake.com/snowsql/, refer https://www.snowdba.com/install-snowsql-on-linux/
sudo apt-get install alien
sudo alien snowflake-snowsql-1.2.23-1.x86_64.rpm
which snowsql
snowsql -v
-- local log file location
/home/ubuntu/Desktop/Setups/usr/lib64/snowflake/snowsql
-- file name
snowsql.cnf

-- login
snowsql -a jh59432.ap-southeast-1 -u SHRADDHAKR -w SMALLWAREHOUSE -d TESTDB;

-- set the warehouse manually
USE WAREHOUSE SMALLWAREHOUSE;
-- set database manually
USE DATABASE TESTDB;
-- select the schema
use schema ECOMMERCE
-- create stage use the file format
create stage my_upload 
    file_format = ECOMMERCECSVFORMAT;

-- stage file | linux put file syntax
put file:///home/ubuntu/Desktop/Github/learning-data-engineering/snowflake_dataengg/python_code/upload.csv @my_upload;

-- describe the stage to check parameters
DESCRIBE STAGE my_upload;

-- validate before copy with 2 rows
copy into DATA from @my_upload validation_mode = 'RETURN_2_ROWS';

--copy staged file into table
copy into ECOMMERCE.DATA from @my_upload on_error = CONTINUE;
-- remove staged files, because copy always copies everything
remove @my_upload;

-- see your table is populated now
SHOW TABLES;

-- Do this in case you don't have a format specified
-- create stage
create stage my_upload FILE_Format = (TYPE = CSV skip_header = 1);

-- alter timestamp format
alter session set timestamp_input_format='MM/DD/YYYY HH24:MI';