import requests
import psycopg2
import psycopg2.extras
from io import StringIO
import logging
from connector import postgres


class Utility():

    def __init__(self) -> None:
        self.endpoint = 'http://publicdata.landregistry.gov.uk/market-trend-data/house-price-index-data'
        self.sql_schema_file = "/src/sql/schema.sql"
        self.local_data_path = '/data/raw/'
        self.yearly_avg_price_file = '/data/output/yearly_avg_price.csv'
        self.region_price_gain_file = '/data/output/region_price_gain.csv'

    def _get_api_url(self, year, month):
        if month < 10:
            month = '0' + str(month)

        return self.endpoint + "/" + f'UK-HPI-full-file-{year}-{month}.csv'

    def _get_db_connection(self):
        connection = postgres.connect_to_source()
        connection.autocommit = True

        return connection

    def _exec_query(self, query, params=None):
        connection = self._get_db_connection()
        with connection.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
            cursor.execute(query, params)
            logging.debug(f'describing: {cursor.description}')
            result = cursor.fetchall() if cursor.description else None

        connection.close()
        return result

    def _execute_query_file(self, sql_file):
        with open(sql_file) as f:
            self._exec_query(f.read())
        logging.info('Operation completed successfully')

    def _fetch_file_like_object(self, url):
        logging.debug(f'Start downloading file {url}')
        response = requests.get(url, stream=True)
        response.raise_for_status()
        return StringIO(response.content.decode('utf-8'))

    def _save_to_db(self, csv_file_like_object, skip_header=True):
        logging.info('Start copy operation')
        connection = self._get_db_connection()

        with connection.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:
            if skip_header:
                next(csv_file_like_object) # Skip header
            cursor.execute('SET datestyle = ISO, DMY;')
            cursor.copy_from(csv_file_like_object, 'house_price_index_staging', sep=',', null='')

        connection.close()
        logging.info('Copy operation completed successfully')

    def _update_audit_table(self, year, month):
        self._exec_query(f"INSERT INTO download_history (requested_date) VALUES ('{year}-{month}-01')")
        logging.info('Audit table updated successfully')

    def _update_target_table(self):
        self._exec_query('SELECT * FROM process_house_price_index_data()')
        logging.info('Target table updated successfully')


    # Public Methods

    def download_house_price_index(self, year, month, keep_local_copy=False):
        if not (year.isdigit() or month.isdigit()):
            raise ValueError('Invalid date entered, please enter valid date')

        year, month = int(year), int(month)
        if month > 12 or month < 1:
            raise ValueError('Invalid month entered, please enter valid month')
        if year > 2021 or year < 1995:
            raise ValueError('Invalid year entered, please enter valid year between 1995 and 2021')

        url = self._get_api_url(year, month)
        csv_file_like_object = self._fetch_file_like_object(url)
        logging.info('Download finished successfully')
        self._save_to_db(csv_file_like_object)
        self._update_target_table()
        self._update_audit_table(year, month)

        if keep_local_copy:
            csv_file_like_object.seek(0)
            local_filename = url.split('/')[-1]
            with open(self.local_data_path + local_filename, 'w') as file:
                file.write(csv_file_like_object.getvalue())

    def create_staging_table(self):
        self._execute_query_file(self.sql_schema_file)

    def calculate_summary_data(self):
        self._exec_query('SELECT * FROM calc_yearly_avg_price()')
        self._exec_query('SELECT * FROM calc_region_price_gain()')
        logging.info('Operation completed successfully')

    def get_download_history(self):
        return self._exec_query('SELECT * FROM download_history')

    def export_summary_data(self):
        connection = self._get_db_connection()
        with connection.cursor(cursor_factory=psycopg2.extras.DictCursor) as cursor:

            with open(self.yearly_avg_price_file, 'w') as f_output:
                cursor.copy_expert("COPY yearly_avg_price TO STDOUT WITH (DELIMITER ',', FORMAT CSV, HEADER);", f_output)

            with open(self.region_price_gain_file, 'w') as f_output:
                cursor.copy_expert("COPY region_price_gain TO STDOUT WITH (DELIMITER ',', FORMAT CSV, HEADER);", f_output)

        connection.close()
        logging.info('Export operation completed successfully')
