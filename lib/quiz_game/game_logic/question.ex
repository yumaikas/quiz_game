defmodule QuizGame.Question do

  @enforce_keys [:id, :text, :answer_idx, :choices]
  defstruct [:id, :text, :answer_idx, choices: []]

  def answer(%__MODULE__{} = q) do
    Enum.at(q.choices, q.answer_idx)
  end

  def from_row(row) do
    with [id, text, idx | choices] <- row,
        true <- is_binary(idx),
        {num, ""} <- Integer.parse(idx),
        true <- length(choices) > num
    do
      {:ok, %__MODULE__{
        id: id,
        text: text,
        answer_idx: num,
        choices: choices
      }}
    else
      _ -> :error
    end
  end

  def as_row(%__MODULE__{} = q) do
    [q.id, q.text, "#{q.answer_idx}" | q.choices ]
  end

end
