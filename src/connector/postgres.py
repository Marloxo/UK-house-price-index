import psycopg2
from psycopg2 import Error
from config import config
import logging

def _connect(source_name):
    """ Connect to the PostgreSQL database server """
    try:
        logging.debug('Connecting to the PostgreSQL database...')
        return psycopg2.connect(**config.getConfig(section=source_name))

    except (Exception, psycopg2.DatabaseError) as error:
        raise ConnectionError(f"Error Can't establish postgreSQL connection {error}")


def connect_to_source(source_name='reporting_db'):
    return _connect(source_name)
