snowflake_id='jh59432'
region= 'ap-southeast-1'
# snowflake_id is like hi88777
# account-url 'jh59432.ap-southeast-1.snowflakecomputing.com'
# account='{snowflake_id}.{region}.snowflakecomputing.com'.format(snowflake_id=snowflake_id, region=region)
account=f'{snowflake_id}.{region}.snowflakecomputing.com'
print(account)