list @my_upload;

remove @my_upload;

create or replace TABLE TESTDB.ECOMMERCE.DATA (
	INVOICENO VARCHAR(38),
	STOCKCODE VARCHAR(38),
	DESCRIPTION VARCHAR(60),
	QUANTITY NUMBER(38,0),
	INVOICEDATE TIMESTAMP,
	UNITPRICE NUMBER(38,0),
	CUSTOMERID VARCHAR(10),
	COUNTRY VARCHAR(20)
);
create or replace task TESTDB.ECOMMERCE.import_from_stage
	warehouse=SMALLWAREHOUSE
	schedule='1 MINUTE'
	as copy into ECOMMERCE.DATA from @my_upload
              ;

-- create a dependent task on the first one
create or replace task TESTDB.ECOMMERCE.clean_stage
	warehouse=SMALLWAREHOUSE
	after TESTDB.ECOMMERCE.import_from_stage
	as remove @my_upload
              ;


-- RESUME to let it run / SUSPEND (default) to stop it
ALTER TASK TESTDB.ECOMMERCE.clean_stage RESUME;
ALTER TASK TESTDB.ECOMMERCE.import_from_stage RESUME;

-- A child task cannot be altered unless the parent has been, and the task has to be in suspended state inorder for it to be dropped.
ALTER TASK TESTDB.ECOMMERCE.CLEAN_STAGE SUSPEND;
ALTER TASK TESTDB.ECOMMERCE.IMPORT_FROM_STAGE SUSPEND;
DROP TASK IF EXISTS TESTDB.ECOMMERCE.CLEAN_STAGE;
DROP TASK IF EXISTS TESTDB.ECOMMERCE.IMPORT_FROM_STAGE;

