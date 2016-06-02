defmodule DecimalArithmetic do
  @moduledoc """
  Module replaces embedeed arithmetic with decimal one.

  ## Examples
      iex> use DecimalArithmetic
      nil
      iex> a = ~m(98.01)
      #Decimal<98.01>
      iex> b = ~m(10.01)
      #Decimal<10.01>
      iex> c = a * b
      Decimal.mult(a, b)
      iex> d = c / 77
      Decimal.div(c, Decimal.new(77))
      iex> (a + b * c / d) * 3.14
      Decimal.mult(Decimal.add(a, (Decimal.div(Decimal.mult(b, c), d))), Decimal.new(3.14))

      iex> net_price = ~m(34.78)
      #Decimal<34.78>
      iex> vat_rate = 23
      23
      iex> net_price * (1 + vat_rate / 100) |> Decimal.round(2)
      #Decimal<42.78>

  """

  alias Decimal, as: D

  @type decimable :: number | Decimal.t

  @doc false
  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [
        +: 2, -: 2, *: 2, /: 2, ==: 2, !=: 2, <: 2, >: 2, <=: 2, >=: 2
      ]
      import unquote(__MODULE__)
    end
  end

  @doc """
  Adds two decimables.

  ## Examples
      iex> ~m(1) + 3.1415
      #Decimal<4.1415>
      iex> 1 + 3
      4
  """
  @spec decimable + decimable :: Decimal.t
  def a + b do
    do_add(a, b)
  end

  defp do_add(%Decimal{} = a, %Decimal{} = b) do
    D.add a, b
  end
  defp do_add(%Decimal{} = a, b) when is_number(b) do
    D.add a, D.new(b)
  end
  defp do_add(a, %Decimal{} = b) when is_number(a) do
    D.add D.new(a), b
  end
  defp do_add(a, b) do
    Kernel.+(a, b)
  end


  @doc """
  Subtracts two decimables.

  ## Examples
      iex> 3.19 - ~m(5.45)
      #Decimal<-2.26>
  """
  @spec decimable - decimable :: Decimal.t
  def a - b do
    do_sub(a, b)
  end

  defp do_sub(%Decimal{} = a, %Decimal{} = b) do
    D.sub a, b
  end
  defp do_sub(%Decimal{} = a, b) when is_number(b) do
    D.sub a, D.new(b)
  end
  defp do_sub(a, %Decimal{} = b) when is_number(a) do
    D.sub D.new(a), b
  end
  defp do_sub(a, b) do
    Kernel.-(a, b)
  end

  @doc """
  Multiplies decimables.

  ## Examples
      iex> 7 * ~m(2.33)
      #Decimal<16.31>
  """
  @spec decimable * decimable :: Decimal.t
  def a * b do
    do_mult(a, b)
  end

  defp do_mult(%Decimal{} = a, %Decimal{} = b) do
    D.mult a, b
  end
  defp do_mult(%Decimal{} = a, b) when is_number(b) do
    D.mult a, D.new(b)
  end
  defp do_mult(a, %Decimal{} = b) when is_number(a) do
    D.mult D.new(a), b
  end
  defp do_mult(a, b) do
    Kernel.*(a, b)
  end

  @doc """
  Divides two decimables.

  ## Examples
      iex> ~m(3) / 4
      #Decimal<0.75>
  """
  @spec decimable / decimable :: Decimal.t
  def a / b do
    do_div(a, b)
  end

  defp do_div(%Decimal{} = a, %Decimal{} = b) do
    D.div a, b
  end
  defp do_div(%Decimal{} = a, b) when is_number(b) do
    D.div a, D.new(b)
  end
  defp do_div(a, %Decimal{} = b) when is_number(a) do
    D.div D.new(a), b
  end
  defp do_div(a, b) do
    Kernel./(a, b)
  end

  @doc """
  Returns true if two decimable are equal.

  ## Examples
      iex> ~m(3.15) == 3.15
      true
      iex> ~m(5.304) == 5.304
      true
      iex> ~m(1.00001) == ~m(1.00002)
      false
  """
  @spec decimable == decimable :: boolean
  def a == b do
    do_eqaul(a, b)
  end

  defp do_eqaul(%Decimal{} = a, %Decimal{} = b) do
    D.equal? a, b
  end
  defp do_eqaul(%Decimal{} = a, b) when is_number(b) do
    D.equal? a, D.new(b)
  end
  defp do_eqaul(a, %Decimal{} = b) when is_number(a) do
    D.equal? D.new(a), b
  end
  defp do_eqaul(a, b) do
    Kernel.==(a, b)
  end

  @doc """
  Returns true if two decimable are not equal.

  ## Examples
      iex> 3.15 != ~m(3.15)
      false
      iex> 1.00001 != ~m(1.00002)
      true
  """
  @spec decimable != decimable :: boolean
  def a != b do
    !__MODULE__.==(a, b)
  end

  @doc """
  Compares two decimables.
  """
  @spec decimable > decimable :: boolean
  def a > b do
    do_greater(a, b)
  end

  defp do_greater(%Decimal{} = a, %Decimal{} = b) do
    Kernel.==(D.compare(a, b), D.new(1))
  end
  defp do_greater(%Decimal{} = a, b) when is_number(b) do
    Kernel.==(D.compare(a, D.new(b)), D.new(1))
  end
  defp do_greater(a, %Decimal{} = b) when is_number(a) do
    Kernel.==(D.compare(D.new(a), b), D.new(1))
  end
  defp do_greater(a, b) do
    Kernel.>(a, b)
  end

  @doc """
  Compares two decimables.
  """
  @spec decimable >= decimable :: boolean
  def a >= b do
    __MODULE__.==(a, b) || __MODULE__.>(a, b)
  end

  @doc """
  Compares two decimables.
  """
  @spec decimable < decimable :: boolean
  def a < b do
    do_less(a, b)
  end

  defp do_less(%Decimal{} = a, %Decimal{} = b) do
    Kernel.==(D.compare(a, b), D.new(-1))
  end
  defp do_less(%Decimal{} = a, b) when is_number(b) do
    Kernel.==(D.compare(a, D.new(b)), D.new(-1))
  end
  defp do_less(a, %Decimal{} = b) when is_number(a) do
    Kernel.==(D.compare(D.new(a), b), D.new(-1))
  end
  defp do_less(a, b) do
    Kernel.<(a, b)
  end

  @doc """
  Compares two decimables.
  """
  @spec decimable <= decimable :: boolean
  def a <= b do
    __MODULE__.==(a, b) || __MODULE__.<(a, b)
  end

  @doc """
  Casts string literal to Decimal.t.

  ## Examples
      iex> ~m[89.01]
      #Decimal<89.01>
  """
  def sigil_m(string, []) do
    D.new(string)
  end
end
