defmodule QuizGame.Player do
  @enforce_keys [:name, :id, :score]

  defstruct [:id, :name, :score]

  def new(id, name) do
    %__MODULE__{id: id, name: name, score: 0}
  end

end

defmodule QuizGame.PlayerList do

  def update_by_id(players, id, fun) do
    Enum.map(players, fn player ->
      case player.id do
        ^id -> fun.(player)
        _ -> player
      end
    end)
  end


end
