# Bday

**TODO: Add description**
## Helpful commands
Run arbitrary functions from commandline
-  mix run -e Mod.function

Run formatter from VIM
- :%!mix format -

Run Credo from VIM
- :! clear && mix credo %

Examine generators in iex
- iex -S mix
- ExUnit.start()
- c "test/bday/csv_test.exs"
- :proper_gen.sample(Bday.BinaryGenerator.field())
or
- :proper_gen.pick(Bday.BinaryGenerator.field())

Examine PropEr types in iex
- :proper_gen.pick(:proper_types.vector(2, :proper_types.integer()))

Run emailer script
- mix run -e 'Bday.run("priv/db.csv")'
Note: Be sure one of the users in the csv has a birthday today in order to see
any output

Check test coverage metrics
- mix test --cover

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bday` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bday, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/bday](https://hexdocs.pm/bday).

