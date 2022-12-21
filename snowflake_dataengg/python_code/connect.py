"""
With this snippet you can connect to snowflake with python

More docs
https://docs.snowflake.com/en/user-guide/python-connector-pandas.html
In your .bashrc or .zshrc make sure you add the following variables

export user='MYUSERNAME'
export password='MYPASSWORD'
export account='hi68877'

Dependecies to run the script:
pip install "snowflake_connector_python[pandas]==2.8.2"
pip install jwt==1.3.1

To run it (after doing the other tasks):
python worksheets/connect.py

"""
import os
import pandas as pd
from snowflake import connector

print('starting connection')
snowflake_id = os.environ['account']
region= 'ap-southeast-1',
ctx = connector.connect(
    user=os.environ['user'],
    password=os.environ['password'],
    region= 'ap-southeast-1',
    # snowflake_id is like jh59432
    # snowflake account-url 'jh59432.ap-southeast-1.snowflakecomputing.com'
    account=f'{snowflake_id}.{region}.snowflakecomputing.com',
    warehouse='SMALLWAREHOUSE',
    database='TESTDB',
    schema ='ECOMMERCE',
    autocommit=True
    )
print('ok')

db_cursor_eb = ctx.cursor()
res = db_cursor_eb.execute("""
SELECT CUSTOMERID, COUNT(DISTINCT INVOICENO) AS N_ORDERS
FROM DATA
GROUP BY COUNTRY, CUSTOMERID
ORDER BY N_ORDERS DESC
LIMIT 10;
"""
)
# Fetches all records retrieved by the query and formats them in pandas DataFrame
df = res.fetch_pandas_all()
print(df)
