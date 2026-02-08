defmodule PortfolioPageWeb.LayoutComponents do
  @moduledoc """
  Components for main layout parts
  """

  use Phoenix.Component
  import PortfolioPageWeb.CoreComponents, only: [icon: 1]

  alias PortfolioPageWeb.Utils.Formatter

  @contact_link %{label: "contact", url: "/#contact-us"}

  @nav_links [
    %{label: "Home", url: "/"},
    %{label: "Services", url: "/services"},
    %{label: "Blog", url: "/blogs"}
  ]

  @doc """
  Navbar for the pages
  """
  attr :nav_links, :list, default: @nav_links
  attr :contact_link, :map, default: @contact_link

  def navbar(assigns) do
    ~H"""
    <navbar class="sticky top-0 z-50 navbar bg-base-100 shadow-lg shadow-lg shadow-primary/10">
      <div class="navbar-start">
        <div class="dropdown">
          <div tabindex="0" role="button" class="btn btn-ghost lg:hidden">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-5 w-5"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 6h16M4 12h8m-8 6h16"
              />
            </svg>
          </div>
          <ul
            tabindex="-1"
            class="menu menu-lg dropdown-content bg-base-100 rounded-box z-1 mt-3 w-52 p-2 shadow"
          >
            <li :for={nav_info <- @nav_links}>
              <.link navigate={nav_info.url}>
                {nav_info.label}
              </.link>
            </li>
          </ul>
        </div>

        <a class="btn btn-ghost flex flex-row gap-2 items-center">
          <span>
            <img src="images/logo.svg" class="h-8 w-8 " />
          </span>
          <span class="font-bold text-3xl  bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
            LiveLogic
          </span>
        </a>
      </div>
      <div class="navbar-center hidden lg:flex">
        <ul class="menu menu-lg menu-horizontal px-1">
          <li :for={nav_info <- @nav_links}>
            <.link navigate={nav_info.url}>
              {nav_info.label}
            </.link>
          </li>
        </ul>
      </div>
      <div class="navbar-end">
        <.link navigate={@contact_link.url} class="btn btn-primary flex flex-row gap-2">
          <.icon name="hero-envelope" class="size-5" /> {@contact_link.label}
        </.link>
      </div>
    </navbar>
    """
  end

  attr :company_links, :list, default: @nav_links
  attr :contact_link, :map, default: @contact_link

  def footer(assigns) do
    ~H"""
    <footer class="footer sm:footer-horizontal bg-base-200 text-base-content p-10">
      <aside class="hidden sm:block">
        <img src="images/logo-white.svg" class="size-20 mx-auto" />
        <p>
          LiveLogic Development Studio.
        </p>
      </aside>
      <nav>
        <h6 class="footer-title">Services</h6>
        <a class="link link-hover">Product Development</a>
        <a class="link link-hover">Full Stack Development</a>
        <a class="link link-hover">Design</a>
        <a class="link link-hover">Phoenix LiveView</a>
      </nav>
      <nav>
        <h6 class="footer-title">Company</h6>
        <.link :for={nav_info <- @company_links} class="link link-hover" navigate={nav_info.url}>
          {nav_info.label}
        </.link>
      </nav>
      <nav>
        <h6 class="footer-title">Contact</h6>
        <.link navigate={@contact_link.url} class="link link-hover">Contact Form</.link>
        <.link navigate={@contact_link.url} class="link link-hover">brianhammer4work@gmail.com</.link>
      </nav>
    </footer>
    """
  end

  @doc """
  The sidebar for the blog item

  """

  attr :tags, :list, default: []
  attr :recent_posts, :map, default: []

  attr :tag_event, :string, required: true
  attr :search_event, :string, required: true

  def blog_sidebar(assigns) do
    ~H"""
    <sidebar class="flex flex-col gap-8">

    <!-- search section -->
      <div class="card bg-base-200 shadow-lg">
        <div class="card-body">
          <div class="card-title">Search</div>
          <form phx-change="search" class="w-full">
            <label class="input input-bordered flex items-center gap-2 bg-base-100">
              <.icon name="hero-magnifying-glass" class="size-4" />
              <input name="value" type="text" class="grow" placeholder="Search blog posts..." />
            </label>
          </form>
        </div>
      </div>

    <!-- Tags Filter -->
      <div class="card bg-base-200 shadow-lg">
        <div class="card-body">
          <div class="card-title flex flex-row justify-between">
            <h3 class="">Tags</h3>
            <a href="/blog/" class="btn btn-primary btn-sm btn-soft">All</a>
          </div>
          <ul class="flex flex-col gap-2">
            <li :for={tag <- @tags} class="">
              <span class="w-full px-2 block h-[2px] bg-base-300"></span>
              <.link
                patch={"/blogs?tag=#{tag}"}
                class="block py-2 text-lg font-medium border-base-300"
              >
                {tag}
              </.link>
            </li>
          </ul>
        </div>
      </div>

    <!-- Top Posts -->

      <div class="bg-base-200 card shadow-lg">
        <div class="card-body">
          <h3 class="card-title">Latest Posts</h3>
          <ul class="">
            <li :for={post <- @recent_posts}>
              <span class="w-full px-2 block h-[2px] bg-base-300"></span>
              <a href={"/blog/#{post.id}"} class="block py-2 flex flex-row justify-between">
                <span class="font-medium">
                  {post.title}
                </span>
                <span class="text-sm font-thin text-base-content/60">
                  {post.date |> Formatter.format_date()}
                </span>
              </a>
            </li>
          </ul>
        </div>
      </div>

    <!-- advertisement card -->

      <div class="bg-base-100 card shadow-lg bg-gradient-to-br from-primary/10 to-secondary/10 border-2 border-primary/20">
        <div class="card-body">
          <h3 class="card-title">Request Demo</h3>
          <p>
            Xprocura is a real-time construction procurement software that saves countless hours of procurement tracking.
          </p>
          <div class="w-full flex flex-row gap-2 mt-3">
            <a
              href="/#request-demo"
              class="btn btn-primary flex-1 bg-gradient-to-br from-primary/10 to-secondary/10"
            >
              Request Now
            </a>
            <a href="/" class="btn btn-outline btn-secondary flex-1">
              Learn More
            </a>
          </div>
        </div>
      </div>
    </sidebar>
    """
  end

  def grid_background(assigns) do
    ~H"""
    <div class="fixed inset-0 -z-20 bg-[url('/images/backgrounds/squares-background.png')] opacity-2 dark:invert">
    </div>
    <div class="fixed inset-0 -z-19 bg-[url('/images/backgrounds/mesh-background.jpg')] [background-size:110%] object-fill opacity-2">
    </div>
    <div class="to-base-100 via-base-100/40 fixed inset-0 top-0 -z-1 bg-linear-to-b from-transparent">
    </div>
    """
  end
end
