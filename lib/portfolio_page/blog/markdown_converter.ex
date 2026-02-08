defmodule PortfolioPage.Blog.MarkdownConverter do
  def convert(filepath, body, _attrs, opts) do
    if Path.extname(filepath) in [".md", ".markdown"] do
      highlighters = Keyword.get(opts, :highlighters, [])
      body |> Md.generate() |> NimblePublisher.highlight(highlighters)
    end
  end
end
