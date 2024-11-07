import pandas as pd

# Read CSV file into a pandas DataFrame
df = pd.read_csv('input_file.csv')

# Convert DataFrame to Parquet format
df.to_parquet('output_file.parquet', engine='pyarrow')

print("CSV file successfully converted to Parquet.")

