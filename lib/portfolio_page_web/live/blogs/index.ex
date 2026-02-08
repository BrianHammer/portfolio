defmodule PortfolioPageWeb.BlogLive.Index do
  use PortfolioPageWeb, :live_view

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="container mx-auto my-16">
        <h1>Listing Our Blogs</h1>

        <div class="flex flex-col sm:flex-row gap-8">
          <section class="flex-1 flex flex-col gap-4">
            <!-- Search Bar -->
            <.blog_sidebar tag_event="filter_tags" search_event="search" />
          </section>
          <section class="flex-2">
            <.blog_list_section blogs={@streams.blogs} :if={@live_action == :index} />
            <.blog_section :if={@live_action == :show} />
          </section>
        </div>
      </div>
    </Layouts.app>
    """
  end

  attr :blogs, :list, default: []

  def blog_list_section(assigns) do
    ~H"""
    <ul class="flex-2 grid grid-cols-1 gap-4 lg:grid-cols-2 lg:grid-cols-2">
      <li :for={blog <- @blogs}>
        <.blog_link_card
          title="Navigation link"
          category="Architecture"
          date={Date.new!(2026, 10, 23)}
          subtitle="A card component has a figure, a body part, and inside body there are title and actions parts. A card component has a figure, a body part, and inside body there are title and actions parts. A card component has a figure, a body part, and inside body there are title and actions parts."
        />
      </li>
    </ul>
    """
  end

  attr :blog_id, :string, required: true

  def blog_section(assigns) do
    ~H"""
    Blog section
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:blog_id, nil) |> stream(:blogs, [])}
  end

  def handle_event("filter_tags", %{"tag_value" => value}, socket) do
    {:noreply, socket |> push_patch("/blogs?tag=#{value}")}
  end

  def handle_event("search", %{"search_value" => value}, socket) do
    {:noreply, socket |> push_patch("/blogs?tag=#{value}")}
  end

  def handle_params(params, _, socket) do
    {:noreply, socket |> assign_action(params)}
  end

  defp assign_action(socket, params) when socket.assigns.live_action == :index do
    socket
    |> stream(:blogs, [])
  end

  defp assign_action(socket, params) when socket.assigns.live_action == :show do
    socket
    |> assign(:blog_id, params.blog_id)
  end
end
