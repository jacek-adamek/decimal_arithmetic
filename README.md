# DecimalArithmetic

Have you ever had to do some arithmetic calculations using Elixir's [Decimal](https://github.com/ericmj/decimal) library? If so, you probably noticed that doing so is very unhandy, error prone and the final result looks realy ugly.
Let suppose you are building an e-commerce application and you want to calculate gross price for given net price and VAT rate. How would you do it using just plain [Decimal](https://github.com/ericmj/decimal) library?

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

This library was created so that you could use [Decimal](https://github.com/ericmj/decimal) type in the same way you use embedded Elixir's integer and float types. Particularly in relation to 4 basic arithmetic operations (i.e. addition, subtraction, multiplying and division) and also numbers comparison.

## Installation

  Add decimal_arithmetic to your list of dependencies in `mix.exs`:

        def deps do
          [{:decimal_arithmetic, "~> 0.1.0"}]
        en

## Usage

Use DecimalArithmetic library in a whole module:

        defmodule MyFancyModule do
          use DecimalArithmetic
          ...
        end

or in a specific function:

        defmodule MyFancyModule do
          def calculate_something(a, b) do
            use DecimalArithmetic
            ...
          end
          ...
        end

Thanks to above you get access to extended decimal arithmetic.

### Promotion to Decimal

When any expresion contains at least one operand of [Decimal](https://github.com/ericmj/decimal) type the rest of operands are promoted to Decimal too. E.g.:

        iex> a = 23
        23
        iex> b = ~m(1.28)
        #Decimal<1.28>
        iex> a + b
        #Decimal<24.28>

In above example ```a = 23``` has been promoted to [Decimal](https://github.com/ericmj/decimal) and then used to calculate final result. Under the hood promotion is made with ```Decimal.new```.

However in rest cases, that is when there are no Decimal operands, normal Kernel arithmetic operators are in use. E.g:

        iex> a = 1
        1
        iex> b = 2
        2
        iex> a + b
        3

### Numbers comparison

Besides basic arithmetic the library provides all typical comparison operators.

        iex> a = ~m(23.45)
        #Decimal<23.45>
        iex> b = ~m(23.46)
        #Decimal<23.46>
        iex> a > b
        false
        iex> a < b
        true
        iex> a <= b
        true

Promotion to [Decimal](https://github.com/ericmj/decimal) relates to comparison operators too.
