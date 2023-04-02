defmodule QuizGame.Player do
  @enforce_keys [:name, :id, :status]

  defstruct [:id, :name, :status, :pick, :score]

end
