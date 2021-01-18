defmodule Bday.CsvTest do
  use ExUnit.Case, async: true
  use PropCheck
  doctest Bday.Csv

  def field() do
    oneof([unquoted_text(), quotable_text()])
  end

  # using charlists for the easy generation
  def unquoted_text() do
    let chars <- list(elements(textdata())) do
      to_string(chars)
    end
  end

  def quotable_text() do
    let chars <- list(elements('\r\n",' ++ textdata())) do
      to_string(chars)
    end
  end

  def textdata() do
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' ++
      ':;<=>?@ !#$%&\'()*+-./[\\]^_`{|}~'
  end
end
