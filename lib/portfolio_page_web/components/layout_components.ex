defmodule PortfolioPageWeb.LayoutComponents do
  @moduledoc """
  Components for main layout parts
  """

  use Phoenix.Component
  import PortfolioPageWeb.CoreComponents, only: [icon: 1]

  alias PortfolioPage.Utils.Formatter

  @upwork_contact_link %{label: "contact", url: "/upwork#contact"}

  @contact_link %{label: "contact", url: "/#contact-us"}

  @nav_links [
    %{label: "Home", url: "/#home"},
    %{label: "About", url: "/#about"},
    %{label: "Services", url: "/#services"},
    %{label: "Blog", url: "/blogs"}
  ]

  @upwork_links [
    %{label: "Home", url: "/upwork#home"},
    %{label: "About", url: "/upwork#about"},
    %{label: "Services", url: "/upwork#services"},
    %{label: "Blog", url: "/upwork/blogs"}
  ]

  defp get_nav_links("upwork"), do: @upwork_links
  defp get_nav_links(_default), do: @nav_links

  defp get_contact_link("upwork"), do: @upwork_contact_link
  defp get_contact_link(_default), do: @contact_link

  @doc """
  Navbar for the pages
  """
  attr :nav_links, :list, default: @nav_links
  attr :contact_link, :map, default: @contact_link

  attr :type, :string,
    default: "default",
    values: ["default", "upwork"],
    doc: "the type of layout to render"

  def navbar(assigns) do
    ~H"""
    <navbar class="sticky top-0 z-50 navbar bg-base-100 shadow-lg shadow-primary/5">
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
            <li :for={nav_info <- get_nav_links(@type)}>
              <.link navigate={nav_info.url}>
                {nav_info.label}
              </.link>
            </li>

    <!-- no room for the button on mobile. Include here... -->
            <li class="sm:hidden">
              <.link navigate={get_contact_link(@type).url} class="btn btn-primary flex flex-row gap-2">
                <.icon name="hero-envelope" class="size-5" /> {get_contact_link(@type).label}
              </.link>
            </li>
          </ul>
        </div>

        <.link navigate={@type == "upwork" && "/upwork#home" || "/#home"} class="btn btn-ghost flex flex-row gap-2 items-center">
          <span>
            <img src="/images/logo.svg" class="h-8 w-8 " />
          </span>
          <span class="font-bold text-3xl  bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
            LiveLogic
          </span>
          <span class="text-base-content h-full ">
            <span class="pt-full">Dev</span>
          </span>
        </.link>
      </div>
      <div class="navbar-center hidden lg:flex">
        <ul class="menu menu-lg menu-horizontal px-1">
          <li :for={nav_info <- get_nav_links(@type)}>
            <.link navigate={nav_info.url}>
              {nav_info.label}
            </.link>
          </li>
        </ul>
      </div>
      <div class="navbar-end hidden sm:flex">
        <.link navigate={get_contact_link(@type).url} class="btn btn-primary flex flex-row gap-2">
          <.icon name="hero-envelope" class="size-5" /> {get_contact_link(@type).label}
        </.link>
      </div>
    </navbar>
    """
  end

  attr :nav_links, :list, default: @nav_links
  attr :contact_link, :map, default: @contact_link

  attr :type, :string,
    default: "default",
    values: ["default", "upwork"],
    doc: "the type of layout to render"

  def footer(assigns) do
    ~H"""
    <footer class="footer sm:footer-horizontal bg-base-200 text-base-content p-10">
      <aside class="hidden sm:block">
        <img src="/images/logo-white.svg" class="size-20 mx-auto" />
        <p>
          LiveLogic Development.
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
        <.link :for={nav_info <- get_nav_links(@type)} class="link link-hover" navigate={nav_info.url}>
          {nav_info.label}
        </.link>
      </nav>
      <nav>
        <h6 class="footer-title">Contact</h6>
        <.link :if={@type != "upwork"} navigate={get_contact_link(@type).url} class="link link-hover">
          Contact
        </.link>
        <.link
          :if={@type != "upwork"}
          href="mailto:BrianHammer4Work@gmail.com"
          class="link link-hover"
        >
          brianhammer4work@gmail.com
        </.link>
        <.link :if={@type != "upwork"} href="https://github.com/BrianHammer" class="link link-hover">
          Github
        </.link>

        <.link href="https://www.upwork.com/freelancers/~0102aeefe76405d866" class="link link-hover">
          Upwork
        </.link>
      </nav>
    </footer>
    """
  end




  defp build_link(link, "upwork"), do: "/upwork#{link}"
  defp build_link(link, _any), do: link

  @doc """
  The sidebar for the blog item

  """

  attr :tags, :list, default: []
  attr :recent_posts, :map, default: []

  attr :tag_event, :string, required: true
  attr :search_event, :string, required: true

  attr :search_value, :string, default: ""
  attr :tag_value, :string, default: ""

  attr :type, :string,
    default: "default",
    values: ["default", "upwork"],
    doc: "the type of layout to render"

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
              <input
                name="value"
                value={@search_value}
                type="text"
                class="grow"
                placeholder="Search blog posts..."
              />
            </label>
          </form>
        </div>
      </div>

    <!-- Tags Filter -->
      <div class="card bg-base-200 shadow-lg">
        <div class="card-body">
          <div class="card-title flex flex-row justify-between">
            <h3 class="">Tags</h3>
            <.link patch={"/blogs/" |> build_link(@type)} class="btn btn-primary btn-sm btn-soft">All</.link>
          </div>
          <ul class="flex flex-col list">
            <li :for={tag <- @tags} class="">
              <span class="w-full px-2 block h-[2px] bg-base-300"></span>
              <.link
                patch={"/blogs?tag=#{tag}" |> build_link(@type)}
                class={[
                  "block p-2 text-lg font-medium border-base-300",
                  @tag_value == tag && "font-black bg-primary/70 text-primary-content"
                ]}
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
          <ul class="list">
            <li :for={post <- @recent_posts} class="">
              <span class="w-full px-2 block h-[2px] bg-base-300"></span>
              <.link
                patch={"/blogs/#{post.id}" |> build_link(@type)}
                class="block px-1 py-2 hover:bg-secondary/10 flex flex-row justify-between"
              >
                <div class="flex flex-col gap-2">
                  {post.title}
                  <div class="text-xs text-base-content/50 line-clamp-3">
                    {post.description}
                  </div>
                </div>
              </.link>
            </li>
          </ul>
        </div>
      </div>

    <!-- advertisement card -->

      <div class="card bg-base-100 shadow-lg bg-gradient-to-br from-primary/10 to-secondary/10 border-2 border-primary/20">
        <div :if={@type != "upwork"} class="card-body">
          <h3 class="card-title">Professional Development Services</h3>
          <p>
            LiveLogic is a development studio dedicated to building cutting-edge real-time applications.
          </p>
          <div class="w-full flex flex-row gap-2 mt-3">
            <.link
              navigate="/#contact-us"
              class="btn btn-primary flex-1 bg-gradient-to-br from-primary/10 to-secondary/10"
            >
              Contact Us
            </.link>
            <.link navigate="/" class="btn btn-outline btn-secondary flex-1">
              Learn More
            </.link>
          </div>
        </div>


        <div :if={@type == "upwork"} class="card-body">
          <h3 class="card-title">Professional Development Services</h3>
          <p>
            Get professional real-time development services built to scale as your business grows.
          </p>
          <div class="w-full flex flex-row gap-2 mt-3">
            <.link
              navigate="/upwork#contact"
              class="btn btn-primary flex-1 bg-gradient-to-br from-primary/10 to-secondary/10"
            >
              Reach Out
            </.link>
            <.link navigate="/upwork#about" class="btn btn-outline btn-secondary flex-1">
              Learn More
            </.link>
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
