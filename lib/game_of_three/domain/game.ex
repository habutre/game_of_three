defmodule GameOfThree.Domain.Game do
  @moduledoc """
  The Game module is responsible by evaluate the player's movements
  and announce the winner or pass the turn for the opponent
  """

  defstruct game_id: nil,
            game_name: nil,
            player_a: nil,
            player_b: nil,
            move: nil,
            next_to_play: nil

  def create_game do
    %__MODULE__{
      game_id: generate_id(),
      game_name: generate_name()
    }
  end

  def evaluate_move, do: {:error, "An empty movement is not allowed"}

  def evaluate_move(nil), do: {:error, "An empty movement is not allowed"}

  def evaluate_move(value) when is_bitstring(value),
    do: {:error, "A numeric value is expected here"}

  def evaluate_move(value) do
    cond do
      value < 1 || value > 25_000 ->
        {:error, "The movement is out of range"}

      div(value, 3) == 1 ->
        {:winner, "The player xxx has won!"}

      div(value, 3) < 1 ->
        {:tie, "There is no winners in this game!"}

      true ->
        {:ok, div(value, 3)}
    end
  end

  defp generate_id do
    Base.encode64("#{NaiveDateTime.to_iso8601(NaiveDateTime.utc_now())}_game_of_three")
  end

  defp generate_name do
    name = :crypto.strong_rand_bytes(17)

    name
    |> Base.url_encode64()
    |> binary_part(0, 17)
  end
end
