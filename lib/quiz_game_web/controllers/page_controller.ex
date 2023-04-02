defmodule QuizGameWeb.PageController do
  use QuizGameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
