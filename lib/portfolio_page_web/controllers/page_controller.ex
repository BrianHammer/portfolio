defmodule PortfolioPageWeb.PageController do
  use PortfolioPageWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
