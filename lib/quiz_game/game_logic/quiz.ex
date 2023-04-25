defmodule QuizGame.Quiz do
  defstruct [questions: []]

  def add_question(%__MODULE__{questions: qs } = me, %QuizGame.Question{} = question) do
    Map.put(me, :questions, [question | qs])
  end

  def remove_question(%__MODULE__{questions: qs } = me, question_id) do
    Map.put(me, :questions, Enum.filter(qs, fn q -> q.id !== question_id end))
  end

end
