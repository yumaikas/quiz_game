defmodule QuizGame.Quiz do
  defstruct [questions: []]

  def add_question(%__MODULE__{questions: qs } = me, %QuizGame.Question{} = question) do
    Map.put(me, :questions, [question | qs])
  end

end
