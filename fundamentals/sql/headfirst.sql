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

/**/
DROP DATABASE 'HeadFirst';