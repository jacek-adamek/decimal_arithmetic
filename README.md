# DecimalArithmetic

Have you ever had to do some arithmetic calculations using Elixir's Decimal library? If so, you probably noticed that doing so is very unhandy, error prone and the final result looks realy ugly.
Let suppose you are building an e-commerce application and you want to calculate gross price for given net price and VAT rate. How would you do it using just plain Decimal library?

        iex> net_price = Decimal.new("17.99")
        #Decimal<17.99>
        iex> vat_rate = Decimal.new("23")
        #Decimal<23>
        iex> gross_price =
          Decimal.mult(
            net_price,
            Decimal.add(
              Decimal.new(1),
              Decimal.div(vat_rate, Decimal.new(100)))
          ) |> Decimal.round(2)
        #Decimal<22.13>

Wouldn't be better (i.e. more readable) if you could write something like that:

        iex> use DecimalArithmetic
        iex> net_price = ~m(17.99)
        #Decimal<17.99>
        iex> vat_rate = ~m(23)
        #Decimal<23>
        iex> gross_price =
          net_price * (1 + vat_rate / 100)
          |> Decimal.round(2)
        #Decimal<22.13>
?

This library was created so that you could use Decimal type in the same way you use embedded Elixir's integer and float types. Particularly in relation to 4 basic arithmetic operations (i.e. addition, subtraction, multiplying and division) and also numbers comparison.

## Installation

  Add decimal_arithmetic to your list of dependencies in `mix.exs`:

        def deps do
          [{:decimal_arithmetic, "~> 0.0.1"}]
        end

## Usage

