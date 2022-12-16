"""
https://docs.python.org/3/tutorial/errors.html

https://docs.python.org/3/library/exceptions.html

Python Inheritance: https://www.w3schools.com/python/python_inheritance.asp
"""
import pandas as pd

# load a csv file
e_commerce_data_path_csv = "/home/ubuntu/Desktop/Github/data/data.csv"
e_commerce_data_fake_path_csv = "./data/fake_data.csv"

#1 try - except example, raise a BaseException

try:
    e_commerce_csv_df = pd.read_csv(
    # wrong dataset
        # e_commerce_data_fake_path_csv, encoding='unicode_escape', nrows=1000
    # good dataset
          e_commerce_data_path_csv, encoding='unicode_escape', nrows=1000
    ) 
    e_commerce_csv_df.info(verbose=False)
except:
    print("Please provide a correct path tot he file!")

#2 show with exception value
try:
    e_commerce_csv_df = pd.read_csv(
        e_commerce_data_fake_path_csv, encoding='unicode_escape', na_values=1000
    )
except FileNotFoundError as error:
    print(
        # fstrings for better formating
        f"{error}, please provide a correct path to the file!"
    )

#3 create a user defined exception
class FileHasToManyRows(Exception):
    """Exception raised if file has too many rows

    Attributes:
        salary -- input csv file
        message -- error description
    """

    def __init__(self, number_of_rows):
        self.number_of_rows = number_of_rows
        self.message = f"Csv file has too many rows, max rows is 1000 and the file has {self.number_of_rows}"

        super().__init__(self.message)

try:
    e_commerce_csv_df = pd.read_csv(
        e_commerce_data_path_csv, encoding='unicode_escape', nrows=1100
    )
    number_of_rows = len(e_commerce_csv_df)

    if number_of_rows > 1000:
        raise FileHasToManyRows(number_of_rows)

except FileNotFoundError as error:       
    print(
        f"{error}, please provide a correct path to the file!"
    )