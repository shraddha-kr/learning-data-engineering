import pandas as pd

data={
    'Name':['Paul', 'Bob', 'Susan', 'Yolanda'],
    'Age': [23, 45, 18, 21]
}

df=pd.DataFrame(data)
df.to_csv('fromdf-1.csv', index=False)