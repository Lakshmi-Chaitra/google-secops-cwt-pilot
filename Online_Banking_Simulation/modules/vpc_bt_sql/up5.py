import pandas as pd
import logging
from google.cloud import bigtable
from google.cloud.bigtable import column_family

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Bigtable configuration
project_id = 'ctp-prj-1'
instance_id = 'cwt-bigtable-instance-0'
table_id = 'cwt-bigtable'

# Sample data
data = {
    "JWT Token": [
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbGljZWIiLCJuYW1lIjoiQWxpY2UgQmFua3MiLCJpYXQiOjE1MTYyMzkwMjJ9.5MN1FFCsAtR8wUCc_TD6RMJOt8bx0enpjPfJre34whM",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJib2J2IiwibmFtZSI6IkJvYiBWYW5jZSIsImlhdCI6MTUxNjIzOTAyMn0.V8e8vrGg4DSRnZBL0sKk9MdvzVzbLuc39pG42U-jytE",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjaGFybGllcCIsIm5hbWUiOiJDaGFybGllIFBhcmtlciIsImlhdCI6MTUxNjIzOTAyMn0.hhsvoKfUOwE_AMOrXi0uFt6JwF7gL7CS6hz9ftbTJsw"
    ],
    "Sub (User ID)": ["aliceb", "bobv", "charliep"],
    "Money ($)": [435, 873, 4583],
    "name": ["Alice Banks", "Bob Vance", "Charlie Parker"]
}

def upload_to_bigtable(project_id, instance_id, table_id, data):
    # Initialize Bigtable client
    client = bigtable.Client(project=project_id)
    instance = client.instance(instance_id)
    table = instance.table(table_id)

    # Prepare mutations
    mutations = []
    for index, row in data.iterrows():
        row_key = row['Sub (User ID)'].encode('utf-8')
        logger.info(f'Creating mutation for row key: {row["Sub (User ID)"]}')
        
        # Prepare the mutation
        mutation = table.row(row_key)
        mutation.set_cell('column_family_name', 'jwt_token', row['JWT Token'])
        mutation.set_cell('column_family_name', 'money', row['Money ($)'])
        mutation.set_cell('column_family_name', 'name', row['name'])
        mutations.append(mutation)

    # Batch upload
    batcher = table.mutations_batcher()
    try:
        batcher.mutate_rows(mutations)
        logger.info(f'Successfully uploaded batch from index 0 to {len(mutations)-1}.')
    except Exception as e:
        logger.error(f'Failed to upload batch: {e}')
        for mutation in mutations:
            logger.error(f'Failed mutation for row key {mutation.row_key.decode("utf-8")}: {mutation}')
    finally:
        try:
            batcher.close()
        except Exception as e:
            logger.error(f'Error closing MutationsBatcher: {e}')

def main():
    # Create DataFrame from sample data
    df = pd.DataFrame(data)
    logger.info("Successfully created DataFrame from provided data")
    logger.info(f"Columns in the DataFrame: {df.columns.tolist()}")
    
    # Upload to Bigtable
    upload_to_bigtable(project_id, instance_id, table_id, df)

if __name__ == "__main__":
    main()

