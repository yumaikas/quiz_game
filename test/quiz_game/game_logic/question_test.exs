defmodule QuizGame.QuestionTest do
  use ExUnit.Case

  alias QuizGame.Question

  test "Question gives correct answer" do
    q = %Question{
      id: "foo",
      text: "Which word starts with 'a'?",
      answer_idx: 1,
      choices: [
        "ball",
        "aardvark",
        "xylophone"
      ]
    }

    assert Question.answer(q) === "aardvark"
  end

  test "Can construct question from row" do
    {:ok, q} = Question.from_row(["foo", "What flavor is considered plain?", "2", "Chocolate", "Strawberry", "Vanilla"])
    assert q === %Question{
      id: "foo",
      text: "What flavor is considered plain?",
      answer_idx: 2,
      choices: [
        "Chocolate",
        "Strawberry",
        "Vanilla"
      ]
    }
  end

  test "Can emit row" do
    assert [
      "foo", "What flavor is considered plain?", "2", "Chocolate", "Strawberry", "Vanilla"
    ] === Question.as_row(%Question{
      id: "foo",
      text: "What flavor is considered plain?",
      answer_idx: 2,
      choices: [
        "Chocolate",
        "Strawberry",
        "Vanilla"
      ]
    })
  end

end
