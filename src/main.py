import logging
import sys
from utility import Utility


LOG_FORMAT = '%(message)s'

def display_menu(utility):
    try:
        operation = input('''Welcome to the BigPay Utility!
Please select an option from the menu below:
[0] Create schema Tables/Procedures
[1] List stored historical data
[2] Fetch full house price index file
[3] recalculate summary data
[4] Export summary data to CSV
>> ''')

        if operation == '0':
            utility.create_staging_table()

        elif operation == '1':
            logging.info('list of available downloads:')
            download_list = utility.get_download_history()
            print(''' id | requested_date |         created_at
----+----------------+----------------------------''')
            for download in download_list:
                print(f' {download["id"]}  |   {download["requested_date"]}   | {download["created_at"]}')

        elif operation == '2':
            year = input('Please enter Year number [1995,2021]\n>> ')
            month = input('Please enter Month number [1,12]\n>> ')
            utility.download_house_price_index(year, month, keep_local_copy=True)

        elif operation == '3':
            utility.calculate_summary_data()

        elif operation == '4':
            utility.export_summary_data()

        else:
            logging.info('You have not chosen a valid option, please try again.')
    except Exception as e:
        logging.critical(f'An exception of type {type(e).__name__} occurred. {e}')

    again(utility)


def again(utility):
    list_again = input('\nWould you like to see main menu again? (Y/N) ')

    if list_again.upper() == 'Y':
        display_menu(utility)
    elif list_again.upper() == 'N':
        logging.info('OK. Bye bye. :)')
    else:
        again(utility)


def main():
    logging.basicConfig(stream=sys.stdout, level=logging.INFO, format=LOG_FORMAT)

    utility = Utility()
    display_menu(utility)


if __name__ == '__main__':
    main()
