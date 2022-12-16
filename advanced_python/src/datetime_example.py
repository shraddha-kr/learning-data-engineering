"""
https://docs.python.org/3/library/datetime.html#datetime.timedelta

https://docs.python.org/3/library/datetime.html#strftime-and-strptime-behavior

"""
from datetime import datetime
from datetime import timedelta
import time

# Generate the datetime now
datetime_now = datetime.now()
print(datetime_now)


# Modify datetime now minus one hour
datetime_now_minus_one_hour = datetime_now - timedelta(hours=1)
print(datetime_now_minus_one_hour)

# Delete the decimals from the timestamp
datetime_minus_one_reformatted = datetime_now_minus_one_hour.strftime("%d/%m/%y %H:%M:%S")
print(datetime_minus_one_reformatted)

# Convert datetime to epoch using timestamp()
epoch = datetime_now.timestamp()
print(epoch)

# Turn epoch into custom datetime and format
ts_from_epoch = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(epoch))
print(ts_from_epoch)