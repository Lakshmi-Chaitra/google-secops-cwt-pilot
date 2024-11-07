from google.cloud import bigtable

# Initialize Bigtable client and connect to the table
client = bigtable.Client(project='ctp-prj-1', admin=True)
instance = client.instance('cwt-bigtable-instance-0')
table = instance.table('cwt-bigtable')

# Open the CSV file and upload data
with open('input_file.csv', 'r') as file:
    for row in file:
        row_key = row.split(',')[0]  # Assuming the first column is the row key
        column_value = row.split(',')[1]  # Second column as the value (adjust accordingly)

        row = table.direct_row(row_key)
        row.set_cell('column_family_name', 'column_qualifier', column_value)

        row.commit()

