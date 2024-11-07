import csv
import pandas as pd
from google.cloud import bigtable
from google.cloud.bigtable import column_family

# Initialize Bigtable client
client = bigtable.Client(project='<your-project-id>', admin=True)
instance = client.instance('<your-bigtable-instance-id>')
table = instance.table('<your-bigtable-table-id>')

# Check if table exists
if not table.exists():
    print("Table does not exist. Create the table first.")
    exit()

# Define column family
COLUMN_FAMILY_ID = 'cf1'  # Update based on your table schema

# Load CSV file into pandas dataframe
csv_file = 'your_data.csv'  # Path to your CSV file
df = pd.read_csv(csv_file)

# Prepare a list of mutations (data insertion)
rows = []
for index, row in df.iterrows():
    row_key = str(row['row_key'])  # Assuming 'row_key' is a column in your CSV
    row_obj = table.direct_row(row_key)
    
    # Update this part based on your CSV structure
    for col_name in df.columns:
        if col_name != 'row_key':
            value = str(row[col_name])  # Ensure the value is string
            row_obj.set_cell(COLUMN_FAMILY_ID, col_name, value)
    
    # Add row mutation to the list
    rows.append(row_obj)

# Write rows to Bigtable
table.mutate_rows(rows)

print(f"Uploaded {len(rows)} rows to Bigtable.")

