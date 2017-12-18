defmodule Queens do
  def new do
    new({0, 3}, {7, 3})
  end

  def new(white_post, black_post) do
    if white_post == black_post do
      raise ArgumentError, message: "Two queens cannot occupy the same space"
    else
      %{white: white_post, black: black_post}
    end
  end

  def to_string(posts) do
    
  end
end
