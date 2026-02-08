defmodule PortfolioPage.Blog.Parser do
  def parse(_path, contents) do
    [attrs_str, body] = :binary.split(contents, "\n---\n")


    {attrs, _stuff} =  Code.eval_string(attrs_str)

    {attrs, body}  # Use the actual attrs variable
  end
end
