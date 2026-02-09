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
end
