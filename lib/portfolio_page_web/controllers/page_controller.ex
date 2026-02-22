defmodule PortfolioPageWeb.PageController do
  use PortfolioPageWeb, :controller

  def home(conn, _params) do
    conn
    |> assign(:page_title, "Home")
    |> assign(:contact_form, %{"name" => "", "email" => "", "subject" => "", "message" => ""})
    |> render(:home)
  end


  # Essentially the home page without contact information
  def upwork(conn, _params) do
    conn
    |> assign(:page_title, "Brian Hammer - Upwork")
    |> render(:upwork)
  end



  # POST "/contact"
  # Used only as a post method, and will redirect back to home page with a flash
  def submit_contact_us(conn, %{"contact" => contact_params}) do
    case PortfolioPage.Mailer.send_form(contact_params) |> IO.inspect() do
      {:ok, _response} ->
        conn
        |> put_flash(:info, "Your message has been sent successfully!")
        |> redirect(to: ~p"/#contact-us")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "There was an error sending your message. Please try again later.")
        |> redirect(to: ~p"/#contact-us")
    end
  end


  def services(conn, _params) do
    conn
    |> assign(:page_title, "Services")
    |> render(:services)
  end
end
