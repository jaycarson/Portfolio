#!/usr/bin/python

import unittest
from Euler001 import Euler001
from Euler002 import Euler002
from Euler003 import Euler003
from Euler004 import Euler004
from Euler005 import Euler005
from Euler006 import Euler006
from Euler007 import Euler007
from Euler008 import Euler008
from Euler009 import Euler009
from Euler010 import Euler010


class Euler001TestSuite(unittest.TestCase):
    def setUp(self):
        self.sut = Euler001()

    def test_sample(self):
        test_restrict = 10
        test_answer = 23
        self.assertEqual(self.sut(test_restrict), test_answer)

    def test_actual(self):
        test_restrict = 1000
        test_answer = 233168
        self.assertEqual(self.sut(test_restrict), test_answer)


class Euler002TestSuite(unittest.TestCase):
    def setUp(self):
        self.sut = Euler002()

    def test_sample(self):
        test_restrict = 10
        test_answer = 10
        self.assertEqual(self.sut(test_restrict), test_answer)

    def test_actual(self):
        test_restrict = 4000000
        test_answer = 4613732
        self.assertEqual(self.sut(test_restrict), test_answer)


class Euler003TestSuite(unittest.TestCase):
    def setUp(self):
        self.sut = Euler003()

    def test_sample(self):
        test_restrict = 13195
        test_answer = 29
        self.assertEqual(self.sut(test_restrict), test_answer)

    def test_actual(self):
        test_restrict = 600851475143
        test_answer = 6857
        self.assertEqual(self.sut(test_restrict), test_answer)


class Euler004TestSuite(unittest.TestCase):
    def setUp(self):
        self.sut = Euler004()

    def test_sample(self):
        test_restrict = 2
        test_answer = 9009
        self.assertEqual(self.sut(test_restrict), test_answer)

    def test_actual(self):
        test_restrict = 3
        test_answer = 906609


class Euler005TestSuite(unittest.TestCase):
    def setUp(self):
        self.sut = Euler005()

    def test_sample(self):
        test_restrict = 10
        test_answer = 2520
        self.assertEqual(self.sut(test_restrict), test_answer)

    def test_actual(self):
        test_restrict = 20
        test_answer = 232792560
        self.assertEqual(self.sut(test_restrict), test_answer)


class Euler006TestSuite(unittest.TestCase):
    def setUp(self):
        self.sut = Euler006()

    def test_sample(self):
        test_restrict = 10
        test_answer = 2640
        self.assertEqual(self.sut(test_restrict), test_answer)

    def test_actual(self):
        test_restrict = 100
        test_answer = 25164150
        self.assertEqual(self.sut(test_restrict), test_answer)


class Euler007TestSuite(unittest.TestCase):
    def setUp(self):
        self.sut = Euler007()

    def test_sample(self):
        test_restrict = 6
        test_answer = 13
        self.assertEqual(self.sut(test_restrict), test_answer)

    def test_actual(self):
        test_restrict = 10001
        test_answer = 104743
        self.assertEqual(self.sut(test_restrict), test_answer)


class Euler008TestSuite(unittest.TestCase):
    def setUp(self):
        self.sut = Euler008()

    def test_sample(self):
        test_restrict = 4
        test_answer = 5832
        self.assertEqual(self.sut(test_restrict), test_answer)

    def test_actual(self):
        test_restrict = 13
        test_answer = 23514624000
        self.assertEqual(self.sut(test_restrict), test_answer)


class Euler009TestSuite(unittest.TestCase):
    def setUp(self):
        self.sut = Euler009()

    def test_sample(self):
        test_restrict = 12
        test_answer = 60
        self.assertEqual(self.sut(test_restrict), test_answer)

    def test_actual(self):
        test_restrict = 1000
        test_answer = 31875000


class Euler010TestSuite(unittest.TestCase):
    def setUp(self):
        self.sut = Euler010()

    def test_sample(self):
        test_restrict = 10
        test_answer = 17
        self.assertEqual(self.sut(test_restrict), test_answer)

    def test_actual(self):
        test_restrict = 2000000
        test_answer = 142913828922
        self.assertEqual(self.sut(test_restrict), test_answer)


if __name__ == '__main__':
    unittest.main()
