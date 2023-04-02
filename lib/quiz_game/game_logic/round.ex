defmodule QuizGame.GameRound do

  alias QuizGame.Question
  alias QuizGame.PlayerList
  alias QuizGame.Player

  defp lerp(from, to, t) do
    ((1 - t) * from) + (t * to)
  end
  defp invLerp(from, to, value) do
    (value - from) / (to - from)
  end
  defp remap(inFrom, inTo, outFrom, outTo, value) do
    rel = invLerp(inFrom, inTo, value)
    lerp(outFrom, outTo, rel)
  end

  defstruct [:players, :question, :start_time, :end_time, player_answers: %{}]

  def new(start, over, players, question) do
    %__MODULE__{ start_time: start, end_time: over, players: players, question: question }
  end

  def give_answer(%__MODULE__{} = round, player_id, answer_idx, time) do
    in_time = round.start_time < time and time < round.end_time
    is_correct = Question.is_correct(round.question, answer_idx)
    has_not_submitted = not Map.has_key?(round.player_answers, player_id)
    score_if_correct = remap(round.start_time, round.end_time, 100.0, 0.0, time)

    case {in_time, is_correct, has_not_submitted} do
      {true, true, true} ->
        %__MODULE__{ round |
          players: PlayerList.update_by_id(
            round.players,
            player_id,
            &%Player{&1 | score: &1.score + score_if_correct}),
          player_answers: Map.put(round.player_answers, player_id, answer_idx)
        }
      {true, false, true} ->
        %__MODULE__{ round |
          player_answers: Map.put(round.player_answers, player_id, answer_idx)
        }
      _ -> :error
    end
  end
end
