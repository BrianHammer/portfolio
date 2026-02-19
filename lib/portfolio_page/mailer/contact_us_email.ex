defmodule ProtfolioPage.Mailer.ContactUsEmail do
  import Swoosh.Email

  @from_email "bhammer@livelogicdev.com"
  @to_email "bhammer@livelogicdev.com"

  def from_form(%{
        "email" => email,
        "name" => name,
        "subject" => subject,
        "message" => message
      }) do

    new()
    |> to(@to_email)
    |> from({name, @from_email})
    |> subject("#{name} [#{email}] - #{subject}")
    |> text_body(message)
  end
end
