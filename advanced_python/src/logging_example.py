"""
https://docs.python.org/3/howto/logging.html
"""
import logging
import pandas as pd

# load a csv file
e_commerce_data_path_csv = "/home/ubuntu/Desktop/Github/data-engineering/data/data.csv"

e_commerce_csv_df = pd.read_csv(
    e_commerce_data_path_csv, encoding='unicode_escape', nrows=1000
)

# create logger
# config the default level to debug - This debugs even the debug level
logging.basicConfig(
    filename="/home/ubuntu/Desktop/Github/data-engineering/advanced-python/reading_csvs.log",
    level=logging.DEBUG,
    format="%(asctime)s - %(levelname)s - %(message)s",
)

def is_positive(number):
    logging.debug(f"Checking if {number} is positive?")
    if number > 0:
        logging.info(f"{number} is positive?")
    else:
        logging.error(f"Error! Number {number} is negative!")

quantities = e_commerce_csv_df["Quantity"].to_list() 

for quantity in quantities:
    is_positive(quantity)