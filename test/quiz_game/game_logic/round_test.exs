defmodule QuizGame.RoundTest do
  use ExUnit.Case

  alias QuizGame.Question
  alias QuizGame.Player
  alias QuizGame.GameRound

  test "Can play round" do
    now = :os.system_time(:millisecond)
    players = [
      %Player{id: "MAME", name: "Jose", score: 0},
      %Player{id: "WERP", name: "Andrew", score: 0},
      %Player{id: "KMWE", name: "Jayden", score: 0},
      %Player{id: "LOLP", name: "Victoria", score: 0},
      %Player{id: "YRMF", name: "Jeremy", score: 0}
    ]

    start_time = now
    end_time = now + (15.0 * 1000)
    question = %Question{
      id: "QERD",
      text: "What music genre is oldest?",
      answer_idx: 0,
      choices: ["Classical", "Rock", "Reggae"]
    }

    round = GameRound.new(start_time, end_time, players, question)

    round = GameRound.give_answer(round, "MAME", 0, start_time + 1)
    assert Enum.at(round.players, 0).score > 99

    round = GameRound.give_answer(round, "YRMF", 0, start_time + 4_000)
    assert Enum.at(round.players, 4).score > 73
    assert Enum.at(round.players, 3).score == 0

  end

end
