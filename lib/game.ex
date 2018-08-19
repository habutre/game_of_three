defmodule Game do
  @moduledoc """
  The Game module is responsible by evaluate the player's movements
  and announce the winner or pass the turn for the opponent
  """

  def evaluate_move(), do: {:error, "An empty movement is not allowed"}

  def evaluate_move(value = nil), do: {:error, "An empty movement is not allowed"}

  def evaluate_move(value) when is_bitstring(value),
    do: {:error, "A numeric value is expected here"}

  def evaluate_move(value) do
    cond do
      div(value, 3) == 1 ->
        {:winner, "The player xxx has won!"}

      div(value, 3) < 1 ->
        {:tie, "There is no winners in this game!"}

      true ->
        {:ok, div(value, 3)}
    end
  end
end
