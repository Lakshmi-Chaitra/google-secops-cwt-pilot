import logging
import pandas as pd
from google.cloud import bigtable

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def upload_to_bigtable(project_id, instance_id, table_id, input_file, batch_size=10):
    # Initialize Bigtable client
    client = bigtable.Client(project=project_id, admin=True)
    instance = client.instance(instance_id)
    table = instance.table(table_id)

    # Load the CSV file into a DataFrame
    try:
        df = pd.read_csv(input_file)
        logger.info(f'Successfully loaded {input_file}')
        logger.info(f'Columns in the CSV file: {df.columns.tolist()}')
    except Exception as e:
        logger.error(f'Failed to load CSV file: {e}')
        return

    if 'Sub (User ID)' not in df.columns:
        logger.error("'Sub (User ID)' column not found in the CSV file.")
        return

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
    input_file = '/home/kuppannan/cwt-pilot/Online_Banking_Simulation_Prj-1/modules/vpc_bt_sql/input_file.csv'

    upload_to_bigtable(project_id, instance_id, table_id, input_file)

