defmodule PortfolioPageWeb.CustomComponents do
  @moduledoc """
  Components that are commonly reused across different pages

  """
  use Phoenix.Component
  import PortfolioPageWeb.CoreComponents, only: [icon: 1]

  attr :title, :string, default: ""
  attr :subtitle, :string, default: ""

  def title(assigns) do
    ~H"""
    <div>

    </div>
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
          <a class="btn btn-lg btn-primary">Reach Out</a>
          <a class="btn btn-lg btn-secondary btn-outline">Learn More</a>
        </div>
      </div>
    </div>
    """
  end
end
