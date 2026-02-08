defmodule MyApp.Blog do
  alias MyApp.Blog.Post

  @posts_dir "priv/posts/"

  @default_number_of_posts 30

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:my_app, "#{@posts_dir}**/*.md"),
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  # The @posts variable is first defined by NimblePublisher.
  # Let's further modify it by sorting all posts by descending date.
  @posts @posts |> sort_posts_by_date()

  # Let's also get all tags
  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  # And finally export them
  def all_posts, do: @posts
  def all_tags, do: @tags

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  @doc """
  Get posts with parameters searched and filtered


  """
  def get_posts(params \\ %{}, number_of_posts \\ @default_number_of_posts) do
    get_published_posts()
    |> filter_by_query_params(params)
    |> limit_posts(number_of_posts)
  end

  def get_recent_posts(number_of_posts \\ @default_number_of_posts) do
    get_published_posts()
    |> limit_posts(number_of_posts)
  end

  @doc """
  Gets recommended similar posts


  """
  def get_recommendations_by_post(post, number_of_posts \\ @default_number_of_posts) do
    # TODO: add similar category logic

    get_published_posts()
    |> remove_post_by_id(post.id)
    |> Enum.shuffle()
    |> Enum.take(number_of_posts)
  end

  def get_published_posts() do
    today = Date.utc_today()

    all_posts()
    |> remove_hidden_posts()
    |> remove_posts_before_date(today)
  end

  defp filter_hidden_posts(posts) do
    psots |> Enum.filter(& &1.hidden?)
  end

  defp remove_posts_before_date(posts, before_date) do
    Enum.filter(posts, fn post ->
      Date.compare(post.date, before_date) in [:lt, :eq]
    end)
  end

  defp sort_posts_by_date(posts),
    do: posts |> Enum.sort_by(fn post -> post.date end, {:desc, Date})

  defp filter_by_query_params(posts, params) do
    posts
    |> filter_posts_by_tag(params["tag"])
    |> filter_posts_by_search(params["search"])
  end

  defp filter_posts_by_tag(posts, nil), do: posts

  defp filter_posts_by_tag(posts, tag) do
    posts
    |> Enum.filter(fn post -> tag in post.tags end)
  end

  defp filter_posts_by_search(posts, nil), do: posts
  defp filter_posts_by_search(posts, ""), do: posts

  defp filter_posts_by_search(posts, search_str) do
    posts
    |> Enum.filter(fn post ->
      post.title |> String.downcase() |> String.contains?(search_str |> String.downcase())
    end)
  end

  defp limit_posts(posts, limit_number) do
    posts |> Enum.take(limit_number)
  end

  defp remove_post_by_id(posts, id) do
    posts
    |> Enum.reject(fn post -> post.id == id end)
  end

  @doc """
  Grabs a published post by its id

  """
  def get_post_by_id!(id) do
    get_published_posts()
    |> Enum.find(&(&1.id == id)) ||
      raise NotFoundError, "post with id=#{id} not found"
  end


  @doc """
  Grabs posts by their tag
  """
  def get_posts_by_tag(tag) do
    get_published_posts()
    |> Enum.filter(&(tag in &1.tags))
  end

  def get_posts_by_tag!(tag) do
    get_published_posts()
    |> case Enum.filter(&(tag in &1.tags)) do
      [] -> raise NotFoundError, "posts with tag=#{tag} not found"
      posts -> posts
    end
  end
end
