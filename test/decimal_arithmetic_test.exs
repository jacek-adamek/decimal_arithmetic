defmodule DecimalArithmeticTest do
  use ExUnit.Case
  use DecimalArithmetic
  alias Decimal, as: D
  doctest DecimalArithmetic

  test "adding" do
    assert 1.05 + ~m(3.15) == ~m(4.2)
    assert ~m(1.05) + ~m(3.15) == ~m(4.2)
    assert 1.05 + 3.15 == 4.2
  end

  test "subtracting" do
    assert 1 - ~m(3.0) == ~m(-2)
    assert ~m(1) - ~m(3.0) == ~m(-2)
    assert 1 - 3.0 == -2
  end

  test "dividing" do
    assert 1 / ~m(3) == D.div(D.new(1), D.new(3))
  end

  test "multiplying" do
    assert ~m(1.02) * 3 == ~m(3.06)
  end

  test "compound expressions" do
    assert D.round(~m(1.02) * 3 / 7, 2) == ~m(0.44)
  end

  test "==" do
    assert 3.001 == ~m(3.001)
  end

  test "!=" do
    assert 3.002 != ~m(3.001)
  end

  test ">" do
    assert ~m(3.001) > 3.0009
    assert 3.001 > ~m(3.0009)
    assert ~m(3.001) > ~m(3.0009)
    assert 3.001 > 3.0009
  end

  test ">=" do
    assert 3.001 >= 3.0009
    assert 3.001 >= ~m(3.001)
  end

  test "<" do
    assert ~m(3.0009) < 3.001
    assert 3.0009 < ~m(3.001)
    assert ~m(3.0009) < ~m(3.001)
    assert 3.0009 < 3.001
  end

  test "<=" do
    assert 3.0009 <= 3.001
    assert 3.001 <= ~m(3.001)
  end
end
