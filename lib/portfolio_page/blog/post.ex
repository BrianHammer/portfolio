defmodule PortfolioPage.Blog.Post do
  @enforce_keys [
    :id,
    :author,
    :title,
    :body,
    :description,
    :tags,
    :date,
    :read_time,
    :image_url,
    :hidden?
  ]

  defstruct [
    :id,
    :author,
    :title,
    :body,
    :description,
    :tags,
    :date,
    :read_time,
    :image_url,
    :hidden?
  ]

  def build(filename, attrs, body) do
    [year, month_day_id, _index] = filename |> Path.rootname() |> Path.split() |> Enum.take(-3)

    [month, day, id] = String.split(month_day_id, "-", parts: 3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")
    struct!(__MODULE__, [id: id, date: date, body: body] ++ Map.to_list(attrs))
  end

  @doc """
  Builds a schema markup from a post.
  Takes a post and returns a JSON string

  """
  def generate_schema_markup(post = %__MODULE__{}) do
    %{
      "@context" => "https://schema.org",
      "@type" => "BlogPosting",
      "headline" => post.title,
      "datePublished" => post.date |> Date.to_iso8601(),
      "image" => post.image_url,
      "author" => %{
        "@type" => "Person",
        "name" => post.author
      },
      "publisher" => %{
        "@type" => "Organization",
        "name" => "LiveLogic"
      }
    }
    |> Jason.encode!()
  end
end
