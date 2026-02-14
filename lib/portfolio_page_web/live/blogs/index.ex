defmodule PortfolioPageWeb.BlogLive.Index do
  use PortfolioPageWeb, :live_view

  alias PortfolioPage.Utils.Formatter
  alias PortfolioPage.Blog

  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="container mx-auto my-16">
        <div class="text-4xl mb-4">Blogs</div>

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
    <div class="flex-2 min-w-0 card bg-base-200 rounded-lg shadow-xl">
      <figure>
        <img
          src={@post.image_url}
          alt="Shoes"
          class="w-full object-cover h-75"
        />
        <figcaption class="sr-only">
          picture image for the article: {@post.title}
        </figcaption>
      </figure>

      <article class="card-body flex flex-col space-y-4">
        <header>
          <h1 class="text-5xl mb-2 font-bold bg-gradient-to-t from-primary to-secondary bg-clip-text text-transparent">
            {@post.title}
          </h1>
          <p class="text-lg text-base-content/80 ">{@post.description}</p>
        </header>

        <nav aria-label="Post tags">
          <ul class="flex flex-row gap-2 flex-wrap">
            <li :for={tag <- @post.tags}>
              <.link class="btn btn-secondary btn-sm" patch={~p"/blogs?tag=#{tag}"}>{tag}</.link>
            </li>
          </ul>
        </nav>

        <div class="flex flex-row  gap-2">
          <address class="badge">{@post.author}</address>
          <div class="badge">{@post.read_time} min read</div>
          <time class="badge" datetime={Date.to_iso8601(@post.date)}>
            {Formatter.format_date(@post.date)}
          </time>
        </div>
        <section class="markdown-blog">
          {raw(@post.body)}
        </section>
      </article>
    </div>
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

  defp assign_action(socket, _params) when socket.assigns.live_action == :index do
    socket
    |> assign(:page_title, "Blogs")
    |> stream(:posts, Blog.get_posts(socket.assigns.params, 30), reset: true)
  end

  defp assign_action(socket, params) when socket.assigns.live_action == :show do
    post = Blog.get_post_by_id!(params["post_id"])

    socket
    |> assign(:page_title, "#{post.title} - Blog")
    |> assign(:post, post)
  end
end
