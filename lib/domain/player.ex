defmodule GameOfThree.Player do
  @moduledoc """
  Player module is responsible for player moves
  trying to win over opponents
  """

  def move do
    seed_game()
  end

  def move(opponent_move = nil) do
    seed_game()
  end

  def move(opponent_move) do
    cond do
      opponent_move / 3 <= 1 ->
        opponent_move

      opponent_move <= 10 ->
        opponent_move + 1

      true ->
        opponent_move - 1
    end
  end

  defp seed_game do
    Enum.random(10_000..25_000)
  end
end
