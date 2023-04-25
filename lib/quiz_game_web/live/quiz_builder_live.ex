defmodule QuizGameWeb.QuizBuilderLive do
  use QuizGameWeb, :live_view

  alias QuizGame.Quiz
  alias QuizGame.QuizCsv
  alias QuizGame.Question

  def mount(_params, session, socket) do
    socket = assign(socket, :quiz, %Quiz{})
    socket = assign(socket, :choices, [])
    socket = assign(socket, :new_choice, "")
    socket = assign(socket, :errors, %{})
    socket = assign(socket, :question_text, "")

    {:ok, socket}
  end

  defp check(errmap, should_add, key, value) do
    if should_add do
      Map.put(errmap, key, value)
    else
      errmap
    end
  end

  def handle_event("question-text-blur", args, socket) do
    socket = assign(socket, :question_text, args["value"] || "")
    {:noreply, socket}
  end

  def handle_event("add-question", args, socket) do
    choices = socket.assigns.choices
    question_text = args["text"]
    {valid_idx, answer_idx} = case Integer.parse(args["correct_idx"] || "error") do
      {number, ""} -> {:ok, number}
      _ -> {:error, 0}
    end

    errors = %{}
    |> check(length(choices) < 2, :question_text, "Need at least two possible answers for question")
    |> check(String.length(question_text) < 1, :question_text, "Question text is required")
    |> check(valid_idx !== :ok, :invalid_index, "Need pick a correct answer")

    IO.puts(inspect errors)

    if length(Map.keys(errors)) > 0 do
      socket = assign(socket, :errors, errors)
      {:noreply, socket}
    else
      quiz = Quiz.add_question(
        socket.assigns.quiz,
        %Question{
          id: make_id(8),
          text: question_text,
          answer_idx: answer_idx,
          choices: choices
        }
      )
      socket = assign(socket, :quiz, quiz)
      socket = assign(socket, :choices, [])
      socket = assign(socket, :question_text, "")
      socket = assign(socket, :errors, %{})
      {:noreply, socket}
    end
  end

  def handle_event("add-choice", args, socket) do
    new_choice = args["new-choice"]
    socket = assign(socket, :choices, socket.assigns.choices ++ [new_choice])
    {:noreply, socket}
  end

  def handle_event("download-quiz", args, socket) do
    body = QuizCsv.csv_rows(socket.assigns.quiz)
    socket = push_event(socket, "download-quiz", %{
      text: body,
      filename: "Quiz.csv"
    })
    {:noreply, socket}
  end

  def handle_event("remove-from-quiz", args, socket) do
    new_quiz = Quiz.remove_question(socket.assigns.quiz, args["id"] || "")
    socket = assign(socket, :quiz, new_quiz)
    {:noreply, socket}
  end

  def handle_event("remove-choice", args, socket) do
    remove_idx = String.to_integer(args["idx"])
    new_choices = List.delete_at(socket.assigns.choices, remove_idx)
    socket = assign(socket, :choices, new_choices)
    {:noreply, socket}
  end

  @alphabet 'ABCDEFGHIJKLMNOPLMNOPQRSTUVWXYZ1234567890'

  defp make_id(n) do
    for _ <- 1..n, into: "", do: <<Enum.random(@alphabet)>>
  end

end
