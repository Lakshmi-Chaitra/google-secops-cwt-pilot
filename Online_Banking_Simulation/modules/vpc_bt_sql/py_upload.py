from google.cloud import bigtable
from google.cloud.bigtable import column_family
import pandas as pd

# Replace these variables with your values
project_id = 'ctp-prj-1'
instance_id = 'cwt-bigtable-instance-0'
table_id = 'cwt-bigtable'
csv_file_path = 'input_file.csv'

# Create a Bigtable client
client = bigtable.Client(project=project_id, admin=True)
instance = client.instance(instance_id)
table = instance.table(table_id)

# Load the CSV file
df = pd.read_csv(csv_file_path)

# Prepare the list of rows for batch mutation
rows = []
for index, row in df.iterrows():
    row_key = f'row-{index}'.encode('utf-8')  # Set a unique row key for each row
    row_object = table.direct_row(row_key)
    
    # Assuming the first column is the row key, and subsequent columns are data
    for col_name, value in row.items():
        row_object.set_cell(
            'cf1',  # Column family name
            col_name.encode('utf-8'),  # Column qualifier (column name)
            str(value).encode('utf-8')  # Value
        )
    
    rows.append(row_object)

# Mutate the rows in batch
table.mutate_rows(rows)

print("Data uploaded to Bigtable!")

