"""
Unit Test 
https://docs.pytest.org/en/6.2.x/getting-started.html

JSON Validation
Great introduction to JSON strings: https://www.guru99.com/json-tutorial-example.html

Python JSON library: https://docs.python.org/3/library/json.html

https://python-jsonschema.readthedocs.io/en/stable/
"""
import json
# jsonschema is an implementation of the JSON schema specification for Python
import jsonschema
from jsonschema import validate
from pprint import pprint

transaction_schema = {
    "schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties":{
             "InvoiceNo": {"type": "integer"},
             "StockCode": {"type": "integer"},
             "Description": {"type": "string"},
             "Quantity": {"type": "integer"},
             "InvoiceDate": {"type": "string"},
             "UnitPrice": {"type": "number"},
             "CustomerID": {"type": "integer"},
             "Country": {"type": "string"},                     
    },
    "required":[
              "InvoiceNo",
              "StockCode",
              "Quantity",
              "CustomerID",
              "InvoiceDate",
              "UnitPrice"
    ]
}

# Create a validation function
def validate_json(json_data):
    try:
        json.loads(json_data)
    except ValueError as err:
        return False
    return True

def validate_json_schema(json_data, my_schema):
    """ 
    REF: https//json-schema.org/
    """
    schema = my_schema
    try:
        validate(instance=json_data, schema=schema)
    except jsonschema.exceptions.ValidationError as err:
        print(err)
        err = "Given JSON data is not valid."
        return False, err
    message = "Given JSON is valid."
    return True, message

if __name__ == '__main__':

# Create JSOn schema with attributes and types

# JSON Validation
    with open("/home/ubuntu/Desktop/Github/learning-data-engineering/data/data_subset.json") as json_file:
        data = json.load(json_file)       

# Below is an example of a json array of objects in data_subset.json file
    # Dictionary in the list of dictionaries:
    #     {
    #         "InvoiceNo": 536370,
    #         "StockCode": 22492,
    #         "Description": "MINI PAINT SET VINTAGE",
    #         "Quantity": 36,
    #         "InvoiceDate": "12/1/2010 8:45",
    #         "UnitPrice": 0.65,
    #         "CustomerID": 12583,
    #         "Country": "France"
    #     }

    valid_transaction_dict = data[0]
    # pprint(valid_transaction_dict)

    res = validate(instance=valid_transaction_dict, schema=transaction_schema)
    # print(res)    
# --------------------------------------------------------------------------------
# Tests with the default validate function that throws an error directly]
# --------------------------------------------------------------------------------
    # [1] jsonschema.exceptions.ValidationError: 'CustomerID' is a required property
    customer_id_missing_dict = {
        "InvoiceNo": 536370,
        "StockCode": 22492,
        "Description": "MINI PAINT SET VINTAGE",
        "Quantity": 36,
        "InvoiceDate": "12/1/2010 8:45",
        "UnitPrice": 0.65,
        "Country": "France"
    }
    # validate(instance=customer_id_missing_dict, schema=transaction_schema)
    
    # [2] jsonschema.exceptions.ValidationError: '536370' is not of type 'integer',Failed validating 'type' in schema['properties']['InvoiceNo']:
    invoiceNo_is_a_string = {
        "InvoiceNo": "536370",
        "StockCode": 22492,
        "Description": "MINI PAINT SET VINTAGE",
        "Quantity": 36,
        "InvoiceDate": "12/1/2010 8:45",
        "UnitPrice": 0.65,
        "CustomerID": 12583,
        "Country": "France",
        "CustomerID": 12583,
    }
    # validate(instance=invoiceNo_is_a_string, schema=transaction_schema)

# --------------------------------------------------------------------------------
# Tests with the custom validate function that throws an error directly]
# --------------------------------------------------------------------------------
    # Load valid JSON string
    valid_json_string = json.dumps(valid_transaction_dict)

    # Create invalid JSON string - missing ',' delimiter
    invalid_json_string = '{"InvoiceNo": 536370 "StockCode": 22492, "Description":  "MINI PAINT SET VINTAGE", "Quantity": 36, "InvoiceDate": "12/1/2010 8:45",   "UnitPrice": 0.65, "CustomerID": 12583, "Country": "France"}'

    # Validate valid json string
    res = validate_json(valid_json_string)
    # True
    print(res)
    print("\n")
    
    # Validate INVALID json string 
    res = validate_json(invalid_json_string)
    # False
    print(res)
    print("\n")

    # Validate data with valid schema
    res = validate_json_schema(valid_transaction_dict, my_schema=transaction_schema)
    # (True, 'Given JSON is valid.')
    print(res)
    print("\n")

    # Validate data with invalid schema
    res = validate_json_schema(invoiceNo_is_a_string, my_schema=transaction_schema)
    # '536370' is not of type 'integer'
    print(res)
    print("\n")