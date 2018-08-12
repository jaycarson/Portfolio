#!/usr/bin/ruby

require_relative "Euler001"
require_relative "Euler002"
require_relative "Euler003"
require_relative "Euler004"
require_relative "Euler005"
require_relative "Euler006"
require_relative "Euler007"
require_relative "Euler008"
require_relative "Euler009"
require_relative "Euler010"
require "test/unit"
 
class TestEulers < Test::Unit::TestCase

    def test_euler_1_example
        euler = Euler001.new( 10 )
        assert_equal( 23, euler.run() )
    end
    
    def test_euler_1_actual
        euler = Euler001.new( 1000 )
        assert_equal( 233168, euler.run() )
    end

    def test_euler_2_example
        euler = Euler002.new( 100 )
        assert_equal( 44, euler.run() )
    end
    
    def test_euler_2_actual
        euler = Euler002.new( 4000000 )
        assert_equal( 4613732, euler.run() )
    end

    def test_euler_3_example
        euler = Euler003.new( 13195 )
        assert_equal( 29, euler.run() )
    end
    
    def test_euler_3_actual
        euler = Euler003.new( 600851475143 )
        assert_equal( 6857, euler.run() )
    end

    def test_euler_4_example
        euler = Euler004.new( 2 )
        assert_equal( 9009, euler.run() )
    end
    
    def test_euler_4_actual
        euler = Euler004.new( 3 )
        assert_equal( 906609, euler.run() )
    end

    def test_euler_5_example
        euler = Euler005.new( 10 )
        assert_equal( 2520, euler.run() )
    end
    
    def test_euler_5_actual
        euler = Euler005.new( 20 )
        assert_equal( 232792560, euler.run() )
    end
    
    def test_euler_6_example
        euler = Euler006.new( 10 )
        assert_equal( 2640, euler.run() )
    end
    
    def test_euler_6_actual
        euler = Euler006.new( 100 )
        assert_equal( 25164150, euler.run() )
    end
    
    def test_euler_7_example
        euler = Euler007.new( 6 )
        assert_equal( 13, euler.run() )
    end
    
    def test_euler_7_actual
        euler = Euler007.new( 10001 )
        assert_equal( 104743, euler.run() )
    end

    def test_euler_8_example
        euler = Euler008.new( 4 )
        assert_equal( 5832, euler.run() )
    end
    
    def test_euler_8_actual
        euler = Euler008.new( 13 )
        assert_equal( 23514624000, euler.run() )
    end
    
    def test_euler_9_example
        euler = Euler009.new( 12 )
        assert_equal( 60, euler.run() )
    end
    
    def test_euler_9_actual
        euler = Euler009.new( 1000 )
        assert_equal( 31875000, euler.run() )
    end

    def test_euler_10_example
        euler = Euler010.new( 10 )
        assert_equal( 17, euler.run() )
    end
    
    def test_euler_10_actual
        euler = Euler010.new( 2000000 )
        assert_equal( 142913828922, euler.run() )
    end
end
