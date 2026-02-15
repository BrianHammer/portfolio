defmodule PortfolioPageWeb.PageController do
  use PortfolioPageWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def services(conn, _params) do
    render(conn, :services)
  end
end
