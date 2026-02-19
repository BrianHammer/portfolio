defmodule PortfolioPage.Mailer do
  use Swoosh.Mailer, otp_app: :portfolio_page
  alias ProtfolioPage.Mailer.ContactUsEmail

  def send_form(form_data) do
    form_data
    |> ContactUsEmail.from_form()
    |> deliver()
  end
end
