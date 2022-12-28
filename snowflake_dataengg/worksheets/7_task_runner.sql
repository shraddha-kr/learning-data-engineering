create or replace task TESTDB.ECOMMERCE.SPLIT_TABLE_AUTOMATIC
	warehouse=SMALLWAREHOUSE
	schedule='1 MINUTE'
	as CREATE OR REPLACE TABLE TESTDB.ECOMMERCE.INVOICES AS( SELECT DISTINCT CUSTOMERID, COUNTRY, INVOICEDATE, INVOICENO
               FROM TESTDB.ECOMMERCE.DATA
              );
-- create a dependent task on the first one
create or replace task TESTDB.ECOMMERCE.SPLIT_TABLE_AUTOMATIC_SECOND
	warehouse=SMALLWAREHOUSE
	after TESTDB.ECOMMERCE.SPLIT_TABLE_AUTOMATIC
	as CREATE OR REPLACE TABLE TESTDB.ECOMMERCE.ITEMS AS ( SELECT STOCKCODE, DESCRIPTION, UNITPRICE,QUANTITY, INVOICENO
               FROM TESTDB.ECOMMERCE.DATA
              );
              
              
-- RESUME to let it run / SUSPEND (default) to stop it
ALTER TASK TESTDB.ECOMMERCE.SPLIT_TABLE_AUTOMATIC RESUME;
ALTER TASK TESTDB.ECOMMERCE.SPLIT_TABLE_AUTOMATIC SUSPEND;
ALTER TASK TESTDB.ECOMMERCE.SPLIT_TABLE_AUTOMATIC_SECOND RESUME;
ALTER TASK TESTDB.ECOMMERCE.SPLIT_TABLE_AUTOMATIC_SECOND SUSPEND;