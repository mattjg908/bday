defmodule Bday.Filter do
  def birthday(people, %Date{month: month, day: day}) do
    Enum.filter(
      people,
      fn %{"date_of_birth" => %Date{month: m, day: d}} ->
        {month, day} == {m, d}
      end
    )
  end

end
