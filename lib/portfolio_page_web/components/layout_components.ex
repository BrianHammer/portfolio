defmodule PortfolioPageWeb.LayoutComponents do
  @moduledoc """
  Components for main layout parts
  """

  use Phoenix.Component
  import PortfolioPageWeb.CoreComponents, only: [icon: 1]

  @nav_links [
    %{label: "Home", url: "/"},
    %{label: "Services", url: "/services"},
    %{label: "Blog", url: "/blogs"}
  ]

  defp navbar_items(assigns) do
    ~H"""
    """
  end

  @doc """
  Navbar for the pages
  """
  attr :nav_links, :map, default: @nav_links

  def navbar(assigns) do
    ~H"""
    <navbar class="navbar bg-base-100 shadow-lg fixed z-50 shadow-lg shadow-primary/10">
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
        <.link navigate="/#contact" class="btn btn-primary flex flex-row gap-2">
          <.icon name="hero-envelope" class="size-5" /> Contact
        </.link>
      </div>
    </navbar>
    """
  end

  @doc """
  The sidebar for the blog item

  """

  def blog_sidebar(assigns) do
    ~H"""
    <div class="flex flex-col gap-4">
      <div class="card bg-base-200 shadow-lg">
        <div class="text-lg font-bold mb-2">Search</div>

        <label class="input input-bordered flex items-center gap-2 bg-base-100">
          <.icon name="hero-magnifying-glass" class="w-4 h-4 opacity-70" />
          <input type="text" class="grow" placeholder="Search blog posts..." />
        </label>
      </div>
    </div>
    """
  end
end
