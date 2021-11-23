"""
This test will check the correctness of each methods of the Utility.
"""

import unittest
from utility import Utility
from io import StringIO

class TestUtilityIntegrity(unittest.TestCase):

    def test_api_url_with_valid_input(self):
        utility = Utility()
        expected_a = 'http://publicdata.landregistry.gov.uk/market-trend-data/house-price-index-data/UK-HPI-full-file-2021-08.csv'
        self.assertEqual(utility._get_api_url(2021, 8), expected_a, 'Incorrect api url Text')

        expected_b = 'http://publicdata.landregistry.gov.uk/market-trend-data/house-price-index-data/UK-HPI-full-file-2019-11.csv'
        self.assertEqual(utility._get_api_url(2019, 11), expected_b, 'Incorrect api url Text')

    def test_invalid_download_date(self):
        utility = Utility()
        with self.assertRaises(ValueError):
            utility.download_house_price_index('1800', '-1')

        with self.assertRaises(ValueError):
            utility.download_house_price_index('something', 'somethat')
