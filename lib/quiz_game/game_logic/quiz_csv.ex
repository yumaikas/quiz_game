defmodule QuizGame.QuizCsv do
  alias QuizGame.Question
  alias QuizGame.Quiz

  defp parse_row(row) do
    with {:ok, data } <- row,
    {:ok, question } <- Question.from_row(data)
    do
      question
    else
      {:error, msg } -> throw {:parse_row_error, msg }
      :error -> throw  {:parse_row_error, "Failed to turn row into question"}
    end
  end

  def parse(data) do
    try do
      questions = CSV.decode(data) |> Stream.map(&parse_row/1) |> Enum.to_list()
      {:ok, %Quiz{ questions: questions}}
    catch
      {:parse_row_error, message } -> {:error, message}
    end
  end

  def csv_rows(%Quiz{} = quiz) do
    Stream.map(quiz.questions, &Question.as_row/1)
    |> CSV.encode()
    |> Enum.join("")
  end

end
