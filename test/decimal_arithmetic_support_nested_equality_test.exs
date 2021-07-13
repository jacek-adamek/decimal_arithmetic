defmodule DecimalArithmeticSupportNestedEqualityTest do
  use ExUnit.Case
  use DecimalArithmetic, support_nested_equality: true

  test "==" do
    assert {~m(3)} == {~m(3.000)}
    assert [~m(3), ~m(12.30000)] == [~m(3.000), ~m(12.3)]
    assert %{value: ~m(3)} == %{value: ~m(3.000)}
    assert %{value: ~m(4.001)} == %{value: ~m(4.001000)}

    assert [
             %{volume: ~m(3)},
             %{price: {~m(23.0000000), "PLN"}}
           ] == [
             %{volume: ~m(3.000)},
             %{price: {~m(23), "PLN"}}
           ]
  end
end
