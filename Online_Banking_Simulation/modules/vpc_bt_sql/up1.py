import logging
import pandas as pd
from google.cloud import bigtable
from google.cloud.bigtable.row import DirectRow

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Bigtable setup
project_id = 'ctp-prj-1'  # Update with your GCP project ID
instance_id = 'cwt-bigtable-instance-0'  # Update with your Bigtable instance ID
table_id = 'cwt-bigtable'  # Update with your Bigtable table name

# Load CSV file
input_file_path = '/home/kuppannan/cwt-pilot/Online_Banking_Simulation_Prj-1/modules/vpc_bt_sql/input_file.csv'  # Update with the path to your CSV file
try:
    data_frame = pd.read_csv(input_file_path)
    logging.info(f"Successfully loaded {input_file_path}")
except Exception as e:
    logging.error(f"Error loading CSV file: {e}")
    exit()

# Connect to Bigtable
client = bigtable.Client(project=project_id, admin=True)
instance = client.instance(instance_id)
table = instance.table(table_id)

# Upload rows to Bigtable
for index, row in data_frame.iterrows():
    row_key = str(row['row_key']).encode('utf-8')  # Update 'row_key' based on your CSV column name
    row_object = DirectRow(row_key)
    
    # Update 'column_family', 'column', and 'value' based on your CSV structure
    row_object.set_cell('cf1', 'column_name', str(row['value']).encode('utf-8'))  # Example
    try:
        row_object.commit()
        logging.info(f"Row {row_key.decode('utf-8')} committed successfully.")
    except Exception as e:
        logging.error(f"Failed to commit row {row_key.decode('utf-8')}: {e}")

logging.info("Data upload complete.")

