import csv
from wsgiref import headers

from numpy import number

with open('data.csv') as f:
    myreader=csv.DictReader(f)
    # headers=next(myreader) using this will skip the first row of name
    totalrows = 1
    for row in myreader:         
        print(totalrows, ' ' ,row['name'])
        # print(row['name'])
        totalrows += 1       
        