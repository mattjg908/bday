defmodule Bday do
  @moduledoc """
  Wraps all e-mailing (sans actually sending) functionality up into a simple API
  """

  def run(path) do
    set =
      path
      |> File.read!()
      |> Bday.Employee.from_csv()
      |> Bday.Employee.filter_birthday(DateTime.to_date(DateTime.utc_now()))
      |> Bday.Employee.fetch()

    for employee <- set do
      employee
      |> Bday.MailTpl.full()
      |> send_email()
    end

    :ok
  end

  defp send_email({to, _topic, _body}) do
    IO.puts("sent birthday email to #{to}")
  end
end
