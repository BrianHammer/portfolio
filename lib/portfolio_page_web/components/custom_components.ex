defmodule PortfolioPageWeb.CustomComponents do
  @moduledoc """
  Components that are commonly reused across different pages

  """
  use Phoenix.Component
  alias PortfolioPage.Utils.Formatter
  import PortfolioPageWeb.CoreComponents, only: [icon: 1]

  attr :title, :string, default: ""
  attr :subtitle, :string, default: ""

  def title(assigns) do
    ~H"""
    <div></div>
    """
  end

  attr :icon_name, :string, required: true
  attr :title, :string, default: ""
  attr :subtitle, :string, default: ""

  def icon_card(assigns) do
    ~H"""
    <div class="card w-full shadow-2xl shadow-primary/10 bg-gradient-to-br from-primary/10 via-base-100 to-base-100">
      <div class="card-body card-xl">
        <div class="card-title flex flex-col md:flex-row gap-4 items-center">
          <div class="flex-none size-16 from-primary to-secondary bg-gradient-to-br flex items-center justify-center rounded-md shadow-secondary/50 shadow-lg">
            <.icon name={@icon_name} class="size-8 text-black bg-black font-bold" />
          </div>
          <h5 class="text-xl text-primary font-bold mb-1">{@title}</h5>
        </div>
        <div>
          <p class="text-lg">{@subtitle}</p>
        </div>
      </div>
    </div>
    """
  end

  attr :icon_name, :string, required: true
  attr :title, :string, default: ""
  attr :title_highlight, :string, default: ""
  attr :subtitle, :string, default: ""

  attr :primary_button_text, :string, default: "Contact Us"
  attr :primary_button_url, :string, default: "/#contact-us"
  attr :secondary_button_text, :string, default: "Learn More"
  attr :secondary_button_url, :string, default: "/"

  def icon_card_large(assigns) do
    ~H"""
    <div class="w-full shadow-primary/10 shadow-2xl card bg-radial from-primary/5 from-0% to-base-100/10">
      <div class="card-body card-xl flex flex-col gap-2 items-center justify-center">
        <div class="flex flex-col items-center justify-center">
          <.icon name={@icon_name} class="size-24 text-primary font-bold" />
        </div>

        <h1 class="text-3xl inline text-center">
          {@title}
          <span class="font-bold bg-gradient-to-br from-primary to-secondary bg-clip-text text-transparent">
            {@title_highlight}
          </span>
        </h1>

        <p class="text-xl mb-4">{@subtitle}</p>

        <div class="card-actions">
          <.link navigate={@primary_button_url} class="btn btn-lg btn-primary">
            {@primary_button_text}
          </.link>
          <.link navigate={@secondary_button_url} class="btn btn-lg btn-secondary btn-outline">
            {@secondary_button_text}
          </.link>
        </div>
      </div>
    </div>
    """
  end

  attr :post, :map, required: true

  def blog_post_link(assigns) do
    ~H"""
    <.blog_link_card
      image_url={@post.image_url}
      tags={@post.tags}
      url={"/blogs/#{@post.id}"}
      date={@post.date}
      title={@post.title}
      subtitle={@post.description}
    />
    """
  end

  attr :image_url, :string,
    default: "https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"

  attr :url, :string, default: "#"
  attr :tags, :list, default: []
  attr :date, :map, default: nil
  attr :title, :string, required: true
  attr :subtitle, :string, required: true

  attr :tags_limit, :integer, default: 3

  def blog_link_card(assigns) do
    ~H"""
    <.link navigate={@url}>
      <div class="group card bg-base-200 shadow-sm border-2 border-primary/20 hover:border-primary/70 transition-all duration-100">
        <figure>
          <img
            src={@image_url}
            alt={"Article image for #{@title}"}
            class="group-hover:scale-105 transition-all duration-200 group-hover:opacity-80"
          />
        </figure>
        <div class="card-body group-hover:text-secondary duration-200">
          <ul class="flex flex-row gap-2 mb-2 flex-wrap">
            <li
              :for={tag <- @tags |> Enum.take(3)}
              class="badge badge-secondary badge-sm"
            >
              {tag}
            </li>
            <li
              :if={@tags |> length() > @tags_limit}
              class="badge badge-sm badge-secondary badge-outline"
            >
              +{length(@tags) - @tags_limit} more
            </li>
            <li :if={@date} class="flex gap-1 text-sm">
              <.icon name="hero-calendar" class="size-5" />
              <span>{@date |> Formatter.format_date()}</span>
            </li>
          </ul>
          <h2 class="card-title">{@title}</h2>
          <p class="line-clamp-3">
            {@subtitle}
          </p>
          <div class="card-actions">
            <div class="flex flex-row gap-2 mt-2 items-center group-hover:font-bold">
              <div>Read More</div>
              <.icon
                name="hero-arrow-right"
                class="size-5 transition-transform duration-200 group-hover:translate-x-1"
              />
            </div>
          </div>
        </div>
      </div>
    </.link>
    """
  end
end
