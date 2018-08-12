#!/usr/bin/groovy

import groovy.util.GroovyTestSuite
import junit.framework.Test
import junit.textui.TestRunner

evaluate(new File("./Euler001.groovy"))
evaluate(new File("./Euler002.groovy"))
evaluate(new File("./Euler003.groovy"))
evaluate(new File("./Euler004.groovy"))
evaluate(new File("./Euler005.groovy"))
evaluate(new File("./Euler006.groovy"))
evaluate(new File("./Euler007.groovy"))
evaluate(new File("./Euler008.groovy"))
evaluate(new File("./Euler009.groovy"))
evaluate(new File("./Euler010.groovy"))

class Euler001Test extends GroovyTestCase {
   void test_output() {
      def sut = new Euler001();
      def expected = 233168;
      assert sut.calculate() == expected;
   }
}

class Euler002Test extends GroovyTestCase {
   void test_output() {
      def sut = new Euler002();
      def expected = 4613732;
      assert sut.calculate() == expected;
   }
}

class Euler003Test extends GroovyTestCase {
   void test_output() {
      def sut = new Euler003();
      def expected = 6857;
      assert sut.calculate() == expected;
   }
}

class Euler004Test extends GroovyTestCase {
   void test_output() {
      def sut = new Euler004();
      def expected = 906609;
      assert sut.calculate() == expected;
   }
}

class Euler005Test extends GroovyTestCase {
   void test_output() {
      def sut = new Euler005();
      def expected = 232792560;
      assert sut.calculate() == expected;
   }
}

class Euler006Test extends GroovyTestCase {
   void test_output_1() {
      def sut = new Euler006();
      def expected = 2640;
      assert sut.calculate( 1, 10 ) == expected;
   }
   void test_output_2() {
      def sut = new Euler006();
      def expected = 25164150;
      assert sut.calculate() == expected;
   }
}

class Euler007Test extends GroovyTestCase {
   void test_output_1() {
      def sut = new Euler007();
      def expected = 13;
      assert sut.calculate( 6 ) == expected;
   }
   void test_output_2() {
      def sut = new Euler007();
      def expected = 104743;
      assert sut.calculate() == expected;
   }
}

class Euler008Test extends GroovyTestCase {
   void test_output_1() {
      def sut = new Euler008();
      def expected = 5832;
      assert sut.calculate( 4 ) == expected;
   }
   void test_output_2() {
      def sut = new Euler008();
      def expected = 23514624000;
      assert sut.calculate() == expected;
   }
}

class Euler009Test extends GroovyTestCase {
   void test_output_1() {
      def sut = new Euler009();
      def expected = 60;
      assert sut.calculate( 12 ) == expected;
   }
   void test_output_2() {
      def sut = new Euler009();
      def expected = 31875000;
      assert sut.calculate() == expected;
   }
}

class Euler010Test extends GroovyTestCase {
   void test_output_1() {
      def sut = new Euler010();
      def expected = 17;
      assert sut.calculate( 10 ) == expected;
   }
   void test_output_2() {
      def sut = new Euler010();
      def expected = 142913828922;
      assert sut.calculate() == expected;
   }
}

class AllTests {
   static Test suite() {
      def allTests = new GroovyTestSuite()
      allTests.addTestSuite( Euler001Test.class )
      allTests.addTestSuite( Euler002Test.class )
      allTests.addTestSuite( Euler003Test.class )
      allTests.addTestSuite( Euler004Test.class )
      allTests.addTestSuite( Euler005Test.class )
      allTests.addTestSuite( Euler006Test.class )
      allTests.addTestSuite( Euler007Test.class )
      allTests.addTestSuite( Euler008Test.class )
      allTests.addTestSuite( Euler009Test.class )
      allTests.addTestSuite( Euler010Test.class )
      return allTests
   }
}

TestRunner.run(AllTests.suite())
