defmodule Bday.BinaryGenerator do
  @moduledoc """
  Supplies a generator for creating binaries that represent data from CSVs, with
  characters that should and should not be escaped and/or treated specially like
  " or whitespaces, etc..
  """
  use PropCheck

  @doc """
  BinaryGenerator.field/1

  ## Example

      :proper_gen.pick(Bday.BinaryGenerator.field())
      {:ok, "~yuy8=D>"}
  """

  def field() do
    oneof([unquoted_text(), quotable_text()])
  end

  # using charlists for the easy generation
  defp unquoted_text() do
    let chars <- list(elements(textdata())) do
      to_string(chars)
    end
  end

  defp quotable_text() do
    let chars <- list(elements('\r\n",' ++ textdata())) do
      to_string(chars)
    end
  end

  defp textdata() do
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' ++
      ':;<=>?@ !#$%&\'()*+-./[\\]^_`{|}~'
  end
end
