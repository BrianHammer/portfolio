defmodule PortfolioPageWeb.BlogLive.Index do
  use PortfolioPageWeb, :live_view

  alias PortfolioPage.Utils.Formatter
  alias PortfolioPage.Blog

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="container mx-auto my-16">
        <h1>Listing Our Posts</h1>

        <div class="flex flex-col sm:flex-row gap-8">
          <section :if={@live_action == :index} class="flex-2">
            <ul
              id="blog-list-section"
              class="flex-2 grid grid-cols-1 gap-4 lg:grid-cols-2 lg:grid-cols-2"
            >
              <li :for={{dom_id, post} <- @streams.posts} id={dom_id}>
                <.blog_post_link post={post} />
              </li>
            </ul>
          </section>

          <section :if={@live_action == :show} class="flex-2">
            <.blog_section post={@post} />
          </section>

          <section class="flex-1 flex flex-col gap-4">
            <!-- Search Bar -->
            <.blog_sidebar
              search_value={@params["search"]}
              tag_value={@params["tag"]}
              tags={Blog.all_tags()}
              tag_event="filter_tags"
              search_event="search"
            />
          </section>
        </div>
      </div>
    </Layouts.app>
    """
  end

  attr :posts, :list, default: []

  def blog_list_section(assigns) do
    ~H"""
    <ul class="flex-2 grid grid-cols-1 gap-4 lg:grid-cols-2 lg:grid-cols-2">
      <li :for={{_id, post} <- @posts}>
        <.blog_post_link post={post} />
      </li>
    </ul>
    """
  end

  attr :post, :map, required: true

  def blog_section(assigns) do
    ~H"""
    <article class="flex-2  card bg-base-200 rounded-lg shadow-xl">
      <figure>
        <img
          src={@post.image_url}
          alt="Shoes"
          class="w-full"
        />
      </figure>

      <div class="card-body flex flex-col space-y-4">
        <h2 class="text-3xl font-bold">{@post.title}</h2>
        <ul class="flex flex-row gap-2 flex-wrap">
          <li :for={tag <- @post.tags} class="badge badge-primary badge-lg badge-soft">
            {tag}
          </li>
        </ul>

        <p class="text-md text-base-content/80 ">{@post.description}</p>
        <div class="flex flex-row gap-4">
          <div>{@post.author}</div>
          <div>{@post.read_time} min read</div>
          <div>{Formatter.format_date(@post.date)}</div>
        </div>
        <div class="markdown-blog">{raw(@post.body)}</div>
      </div>
    </article>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:post, nil)
     |> stream(:posts, [])}
  end

  def handle_event("filter_tags", %{"value" => value}, socket) do
    {:noreply, socket |> push_patch(to: "/blogs?tag=#{value}")}
  end

  def handle_event("search", %{"value" => value}, socket) do
    {:noreply, socket |> push_patch(to: "/blogs?search=#{value}")}
  end

  def handle_params(params, _, socket) do
    assignable_params = %{"search" => params["search"], "tag" => params["tag"]}

    {:noreply, socket |> assign(:params, assignable_params) |> assign_action(params)}
  end

  defp assign_action(socket, params) when socket.assigns.live_action == :index do
    socket
    |> stream(:posts, Blog.get_posts(socket.assigns.params, 30), reset: true)
  end

  defp assign_action(socket, params) when socket.assigns.live_action == :show do
    socket
    |> assign(:post, Blog.get_post_by_id!(params["post_id"]))
  end
end
