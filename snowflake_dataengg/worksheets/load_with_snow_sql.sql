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

