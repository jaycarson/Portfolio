#!/usr/bin/python

import unittest
from python_template_2_7_1 import PythonTemplate


class TemplateTestSuite(unittest.TestCase):
    def setUp(self):
        self.param = 5
        self.verbose = False
        self.sut = PythonTemplate(self.param, self.verbose)

    def test_returns_parameter(self):
        self.assertEqual(self.param, self.sut.get_parameter())

    def test_is_verbose(self):
        self.assertFalse(self.sut.get_verbose())


if __name__ == '__main__':
    unittest.main()
