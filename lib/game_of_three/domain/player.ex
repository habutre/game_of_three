defmodule GameOfThree.Domain.Player do
  @moduledoc """
  Player module is responsible for player moves
  trying to win over opponents
  """

  defstruct player_id: nil,
            player_name: nil

  def create do
    %__MODULE__{
      player_id: generate_id(),
      player_name: generate_name()
    }
  end

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

  defp generate_id do
    # TODO extract generate_id+generate_name to a common module
    # So far used on Game and Player
    Base.encode64("#{NaiveDateTime.to_iso8601(NaiveDateTime.utc_now())}_game_of_three")
  end

  defp generate_name do
    :crypto.strong_rand_bytes(17)
    |> Base.url_encode64()
    |> binary_part(0, 17)
  end
end
