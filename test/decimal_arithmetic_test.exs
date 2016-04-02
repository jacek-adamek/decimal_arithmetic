defmodule DecimalArithmeticTest do
  use ExUnit.Case
  use DecimalArithmetic
  alias Decimal, as: D
  doctest DecimalArithmetic

  test "casting integers, floats and strings" do
    assert dec(5) == D.new(5)
    assert dec("5.43") == D.new(5.43)
    assert dec(5.43) == D.new(5.43)
  end

  test "adding" do
    assert 1 + 3 == D.new(4)
  end

  test "subtracting" do
    assert 1 - 3.0 == D.new("-2")
  end

  test "dividing" do
    assert 1 / "3" == D.div(D.new(1), D.new(3))
  end

  test "multiplying" do
    assert "1.02" * 3 == D.new("3.06")
  end

  test "compound expressions" do
    assert D.round("1.02" * 3 / 7, 2) == D.new("0.44")
  end

  test "==" do
    assert 3.001 == "3.001"
  end

  test "!=" do
    assert 3.002 != "3.001"
  end

  test ">" do
    assert 3.001 > 3.0009
  end

  test ">=" do
    assert 3.001 >= 3.0009
    assert 3.001 >= "3.001"
  end

  test "<" do
    assert 3.0009 < 3.001
  end

  test "<=" do
    assert 3.0009 <= 3.001
    assert 3.001 <= 3.001
  end

  test "using variables" do
    assert (dec 30) == D.new(30)
    assert (dec "40") == D.new("40")
    assert (dec 2.0) == D.new(2.0)
  end
end
