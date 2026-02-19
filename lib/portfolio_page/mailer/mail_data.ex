defmodule PortfolioPage.Mailer.MailData do
  @moduledoc """
  Struct for mail data
  """


  @from_email "bhammer@livelogicdev.com"
  @to_emails ["bhammer@livelogicdev.com"]

  defstruct from: @from_email, to: @to_emails, subject: nil, text: nil
  @enforce_keys [:from, :to, :subject, :text]

  @type t :: %__MODULE__{
          from: String.t(),
          to: list(String.t()),
          subject: String.t(),
          text: String.t()
        }


  @doc """
  Converts form data to MailData struct
   Expects a map with keys "email", "name", "subject", and "message"

  """
  def from_form(%{
        "email" => email,
        "name" => name,
        "subject" => subject,
        "message" => message
      }) do
    %__MODULE__{
      from: @from_email,
      to: @to_emails,
      subject: "#{name} [#{email}] - #{subject}",
      text: message
    }
  end
end
