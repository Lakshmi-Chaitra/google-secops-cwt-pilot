from google.cloud import bigtable

# Bigtable configuration
project_id = 'ctp-prj-1'
instance_id = 'cwt-bigtable-instance-1'
table_id = 'user_data'

# Connect to Bigtable
client = bigtable.Client(project=project_id, admin=True)
instance = client.instance(instance_id)
table = instance.table(table_id)

if table.exists():
    print(f"Connected to Bigtable: {table_id}")
else:
    print(f"Table {table_id} does not exist.")

