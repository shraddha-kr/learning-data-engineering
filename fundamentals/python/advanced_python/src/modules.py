"""
https://docs.python.org/3/tutorial/modules.html
"""
# import custom class (as module) that we created before
# and use it
from classes import MyAge
my_age = MyAge("1980-07-17", "Mr.J")
print(my_age.show_me_my_age())
