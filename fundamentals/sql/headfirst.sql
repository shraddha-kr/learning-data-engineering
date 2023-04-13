/*Check service status*/
sudo systemctl status postgresql.service

/*Start postgres cli*/
sudo -u postgres psql

/*Create DB*/
CREATE DATABASE "HeadFirst"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

/*List all databases on a postgres server*/   
\l

/*Delete a Database*/
DROP DATABASE 'HeadFirst';

/*Create DB*/
CREATE DATABASE gregs_list;

/*Switch or Connect to a Database*/
\connect gregs_list;  

/*Create Table*/
CREATE Table doughnut_list(
    doughnut_name VARCHAR(10),
    doughnut_type VARCHAR(6)
);

/*Describe Table*/  
\d  doughnut_list;