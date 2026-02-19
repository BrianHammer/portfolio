defmodule PortfolioPage.Mailer do
  alias PortfolioPage.Mailer.MailData


  @client Resend.client(api_key: System.get_env("RESEND_API_KEY"))



  def send_form(form_data) do
    form_data
    |> MailData.from_form()
    |> send()
  end

  def send(mail_data = %MailData{}) do
    Resend.Emails.send(@client, %{
      from: mail_data.from,
      to: mail_data.to,
      subject: mail_data.subject,
      text: mail_data.text
    })
  end

  def send_test() do
    Resend.Emails.send(@client, %{
      from: "Acme <onboarding@resend.dev>",
      to: ["delivered@resend.dev"],
      subject: "hello world",
      text: "it works!"
    })
  end
end
