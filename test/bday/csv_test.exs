defmodule Bday.CsvTest do
  use ExUnit.Case, async: true
  use PropCheck
  doctest Bday.Csv

  alias Bday.Csv
  alias Bday.BinaryGenerator

  ## Unit Tests ##
  test "one column CSV files are inherently ambiguous" do
    assert "\r\n\r\n" == Csv.encode([%{"" => ""}, %{"" => ""}])
    assert [%{"" => ""}] == Csv.decode("\r\n\r\n")
  end

  test "one record per line" do
    assert [%{"aaa" => "zzz", "bbb" => "yyy", "ccc" => "xxx"}] ==
             Csv.decode("aaa,bbb,ccc\r\nzzz,yyy,xxx\r\n")
  end

  test "trailing CRLF is not required" do
    assert [%{"aaa" => "zzz", "bbb" => "yyy", "ccc" => "xxx"}] ==
             Csv.decode("aaa,bbb,ccc\r\nzzz,yyy,xxx")
  end

  test "double quotes" do
    assert [%{"aaa" => "zzz", "bbb" => "yyy", "ccc" => "xxx"}] ==
             Csv.decode("\"aaa\",\"bbb\",\"ccc\"\r\nzzz,yyy,xxx")
  end

  test "escape CRLF" do
    assert [%{"aaa" => "zzz", "b\r\nbb" => "yyy", "ccc" => "xxx"}] ==
             Csv.decode("\"aaa\",\"b\r\nbb\",\"ccc\"\r\nzzz,yyy,xxx")
  end

  @doc """
  Since we decided headers are mandatory, this test adds a line with empty
  values (CLRF,,) to the example from the RFC.
  """
  test "double quote escaping" do
     assert [%{"aaa" => "", "b\"bb" => "", "ccc" => ""}] ==
       Csv.decode("\"aaa\",\"b\"\"bb\",\"ccc\"\r\n,,")
  end

  @doc """
  This counterexample is taken literally from the RFC and cannot work with the
  current implementation because maps do not allow duplicate keys
  """
  test "dupe keys unsupported" do
    csv = "field_name,field_name,field_name\r\n" <> "aaa,bbb,ccc\r\n" <> "zzz,yyy,xxx\r\n"
    [map1, map2] = Csv.decode(csv)
    assert ["field_name"] == Map.keys(map1)
    assert ["field_name"] == Map.keys(map2)
  end

  property "roundtrip encoding/decoding" do
    forall maps <- csv_source() do
      maps == Csv.decode(Csv.encode(maps))
    end
  end

  def header(size) do
    vector(size, name())
  end

  def record(size) do
    vector(size, BinaryGenerator.field())
  end

  def name() do
    BinaryGenerator.field()
  end

  def csv_source() do
    let size <- pos_integer() do
      let keys <- header(size + 1) do
        list(entry(size + 1, keys))
      end
    end
  end

  def entry(size, keys) do
    let vals <- record(size) do
      Map.new(Enum.zip(keys, vals))
    end
  end
end
