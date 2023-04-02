defmodule QuizGame.Game do
  defstruct [:id, :quiz, :players, :question_idx, :round_history, :round]

  def new(id, quiz, players) do
    %__MODULE__{
      id: id,
      quiz: quiz,
      players: players,
      round_history: [],
      question_idx: 0
    }
  end

  def start_round(%__MODULE__{} = game, for_players) do
    game
  end

  def end_round(%__MODULE__{} = game) do
    game
  end

  def give_answer(%__MODULE__{} = game, player_id, answer_idx) do
    game
  end

  def scoreboard(%__MODULE__{} = game, for_players) do
    game
  end

  def add_player(%__MODULE__{} = game, player) do
    game
  end

end
