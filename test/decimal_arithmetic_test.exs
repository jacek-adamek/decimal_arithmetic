defmodule DecimalArithmeticTest do
  use ExUnit.Case
  use DecimalArithmetic
  alias Decimal, as: D
  doctest DecimalArithmetic

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
end
