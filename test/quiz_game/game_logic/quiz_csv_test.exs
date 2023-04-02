defmodule QuizGame.QuizCsvTest do

  use ExUnit.Case

  alias QuizGame.Question
  alias QuizGame.QuizCsv
  alias QuizGame.Quiz

  @filedata [
  "foo,What Flavor is considered plain?,2,Chocolate,Strawberry,Vanilla\r\n",
  "oof,Who is a superhero?,1,Indiana Jones,Superman,Foone,Ratfink\r\n",
  "lex,I was once forced to do the chicken dance,3,Josh,Andrew,Connie,Ally\r\n"
  ]

  test "Can parse some data into questions" do
    {:ok, quiz} = QuizCsv.parse(@filedata)
    assert ["Vanilla", "Superman", "Ally"] == quiz.questions |> Enum.map(&Question.answer/1)
  end

  @test_quiz %Quiz{
    questions: [
      %Question{id: "foo", text: "What Flavor is considered plain?",
        answer_idx: 2, choices: ["Chocolate", "Strawberry", "Vanilla"]},
      %Question{id: "oof", text: "Who is a superhero?",
        answer_idx: 1, choices: ["Indiana Jones", "Superman", "Foone", "Ratfink"]},
      %Question{id: "lex", text: "I was once forced to do the chicken dance",
        answer_idx: 3, choices: ["Josh", "Andrew", "Connie", "Ally"]},
    ]
  }

  test "Can turn a quiz into a CSV" do
    csvData = QuizCsv.csv_rows(@test_quiz)
    assert csvData === Enum.join(@filedata, "")
  end


end
