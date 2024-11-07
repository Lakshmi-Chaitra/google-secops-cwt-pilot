import logging
import pandas as pd
from google.cloud import bigtable

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def upload_to_bigtable(project_id, instance_id, table_id, data, batch_size=10):
    # Initialize Bigtable client
    client = bigtable.Client(project=project_id, admin=True)
    instance = client.instance(instance_id)
    table = instance.table(table_id)

    # Prepare DataFrame from provided data
    df = pd.DataFrame(data)
    logger.info('Successfully created DataFrame from provided data')
    logger.info(f'Columns in the DataFrame: {df.columns.tolist()}')

    # Prepare mutations
    for start in range(0, len(df), batch_size):
        end = min(start + batch_size, len(df))
        mutations = []
        for index in range(start, end):
            row = df.iloc[index]
            row_key = str(row['Sub (User ID)']).encode('utf-8')
            mutation = table.row(row_key)
            mutation.set_cell('cf1', 'JWT Token', str(row['JWT Token']).encode('utf-8'))
            mutation.set_cell('cf1', 'Money ($)', str(row['Money ($)']).encode('utf-8'))
            mutation.set_cell('cf1', 'name', str(row['name']).encode('utf-8'))

            logger.info(f'Created mutation for row key: {row_key.decode("utf-8")}')
            mutations.append(mutation)

        # Send the mutations
        batcher = table.mutations_batcher()
        try:
            batcher.mutate_rows(mutations)
            logger.info(f'Successfully uploaded batch from index {start} to {end-1}.')
        except Exception as e:
            logger.error(f'Failed to upload data to Bigtable: {e}')
        finally:
            try:
                batcher.close()
            except Exception as e:
                logger.error(f'Error closing MutationsBatcher: {e}')
                if hasattr(e, 'mutations'):
                    logger.error(f'Failed mutations: {e.mutations}')

if __name__ == '__main__':
    project_id = 'ctp-prj-1'
    instance_id = 'cwt-bigtable-instance-0'
    table_id = 'cwt-bigtable'

    # Prepare the data
    data = [
        {
            "JWT Token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbGljZWIiLCJuYW1lIjoiQWxpY2UgQmFua3MiLCJpYXQiOjE1MTYyMzkwMjJ9.5MN1FFCsAtR8wUCc_TD6RMJOt8bx0enpjPfJre34whM",
            "Sub (User ID)": "aliceb",
            "Money ($)": 435,
            "name": "Alice Banks"
        },
        {
            "JWT Token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJib2J2IiwibmFtZSI6IkJvYiBWYW5jZSIsImlhdCI6MTUxNjIzOTAyMn0.V8e8vrGg4DSRnZBL0sKk9MdvzVzbLuc39pG42U-jytE",
            "Sub (User ID)": "bobv",
            "Money ($)": 873,
            "name": "Bob Vance"
        },
        {
            "JWT Token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjaGFybGllcCIsIm5hbWUiOiJDaGFybGllIFBhcmtlciIsImlhdCI6MTUxNjIzOTAyMn0.hhsvoKfUOwE_AMOrXi0uFt6JwF7gL7CS6hz9ftbTJsw",
            "Sub (User ID)": "charliep",
            "Money ($)": 4583,
            "name": "Charlie Parker"
        }
    ]

    upload_to_bigtable(project_id, instance_id, table_id, data)

