defmodule PortfolioPage.Utils.Formatter do
  @moduledoc """
  Tools to format different types into a presentable string format.

  """




  @doc """
  Formats a date into a presentable readable string.

  examples:

  iex> Date.new!(2026, 10, 23) |> format_date()
  "Oct 23, 2026"
  """

  def format_date(nil), do: ""
  def format_date(date) do
    Calendar.strftime(date, "%b %d, %Y")
  end



end
