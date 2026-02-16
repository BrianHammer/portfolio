defmodule PortfolioPageWeb.PageController do
  use PortfolioPageWeb, :controller

  def home(conn, _params) do
    conn
    |> assign(:page_title, "Home")
    |> render(:home)
  end

  def services(conn, _params) do
    conn
    |> assign(:page_title, "Services")
    |> render(:services)
  end
end
