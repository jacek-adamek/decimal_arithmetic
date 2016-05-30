defmodule DecimalArithmetic do
  @moduledoc """
  Module replaces embedeed arithmetic with decimal one.

  ## Examples
      iex> use DecimalArithmetic
      nil
      iex> a = ~m/98.01/
      #Decimal<98.01>
      iex> b = ~m/10.01/
      #Decimal<10.01>
      iex> c = a * b
      Decimal.mult(a, b)
      iex> d = c / 77
      Decimal.div(c, Decimal.new(77))
      iex> (a + b * c / d) * 3.14
      Decimal.mult(Decimal.add(a, (Decimal.div(Decimal.mult(b, c), d))), Decimal.new(3.14))

      iex> net_price = ~m/34.78/
      #Decimal<34.78>
      iex> vat_rate = 23
      23
      iex> net_price * (1 + vat_rate / 100) |> round(2)
      #Decimal<42.78>

  """

  @type decimable :: number | String.t | Decimal.t

  @doc false
  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [
        +: 2, -: 2, *: 2, /: 2, ==: 2, !=: 2, <: 2, >: 2, <=: 2, >=: 2, rem: 2, round: 1
      ]
      import unquote(__MODULE__)
    end
  end

  @doc """
  Adds two decimables.

  ## Examples
      iex> 1 + 3.1415
      #Decimal<4.1415>
  """
  @spec decimable + decimable :: Decimal.t
  def a + b do
    Decimal.add dec(a), dec(b)
  end

  @doc """
  Subtracts two decimables.

  ## Examples
      iex> 3.19 - "5.45"
      #Decimal<-2.26>
  """
  @spec decimable - decimable :: Decimal.t
  def a - b do
    Decimal.sub dec(a), dec(b)
  end

  @doc """
  Multiplies decimables.

  ## Examples
      iex> 7 * 2.33
      #Decimal<16.31>
  """
  @spec decimable * decimable :: Decimal.t
  def a * b do
    Decimal.mult dec(a), dec(b)
  end

  @doc """
  Divides two decimables.

  ## Examples
      iex> 3 / 4
      #Decimal<0.75>
  """
  @spec decimable / decimable :: Decimal.t
  def a / b do
    Decimal.div dec(a), dec(b)
  end

  @doc """
  Returns true if two decimable are equal.

  ## Examples
      iex> 3.15 == 3.15
      true
      iex> "5.304" == "5.304"
      true
      iex> "1.00001" == "1.00002"
      false
  """
  @spec decimable == decimable :: boolean
  def a == b do
    Decimal.equal? dec(a), dec(b)
  end

  @doc """
  Returns true if two decimable are not equal.

  ## Examples
      iex> 3.15 != 3.15
      false
      iex> 1.00001 != 1.00002
      true
  """
  @spec decimable != decimable :: boolean
  def a != b do
    !__MODULE__.==(a, b)
  end

  @spec decimable > decimable :: boolean
  def a > b do
    Kernel.==(Decimal.compare(dec(a), dec(b)), dec (1))
  end

  @spec decimable >= decimable :: boolean
  def a >= b do
    __MODULE__.==(a, b) || __MODULE__.>(a, b)
  end

  @spec decimable < decimable :: boolean
  def a < b do
    Kernel.==(Decimal.compare(dec(a), dec(b)), dec(-1))
  end

  @spec decimable <= decimable :: boolean
  def a <= b do
    __MODULE__.==(a, b) || __MODULE__.<(a, b)
  end

  @spec rem(decimable, decimable) :: Decimal.t
  def rem(a, b) do
    {_, reminder} = Decimal.div_rem dec(a), dec(b)
    reminder
  end

  @spec round(decimable, integer, Decimal.rounding) :: Decimal.t
  def round(a, places \\ 0, mode \\ :half_up) do
    Decimal.round(dec(a), places, mode)
  end

  @doc """
  Casts string literal to Decimal.t.

  ## Examples
      iex> ~m/89.01/
      #Decimal<89.01>
  """
  def sigil_m(string, []) do
    Decimal.new(string)
  end

  @spec dec(decimable) :: Decimal.t
  defp dec(a) do
    if Decimal.decimal?(a), do: a, else: Decimal.new(a)
  end
end
