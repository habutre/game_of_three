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

  def add_player(game_state, player_name) do
    {:ok, player_a} = Map.fetch(game_state, :player_a)

    if player_a == nil do
      Map.put(game_state, :player_a, player_name)
    else
      Map.put(game_state, :player_b, player_name)
    end
  end

  def start_game(game_state, initial_move) do
    {:ok, player_b} = Map.fetch(game_state, :player_b)
    game_move_changed = Map.put(game_state, :move, initial_move)
    game_next_player_changed = Map.put(game_move_changed, :next_to_play, player_b)

    game_next_player_changed
  end

  def perform_turn(game_state, move) do
    {:ok, played} = Map.fetch(game_state, :next_to_play)
    {:ok, player_a} = Map.fetch(game_state, :player_a)
    {:ok, player_b} = Map.fetch(game_state, :player_b)

    next_to_play =
      if played == player_a do
        player_b
      else
        player_a
      end

    game_move_changed = Map.put(game_state, :move, move)
    game_next_to_play_changed = Map.put(game_move_changed, :next_to_play, next_to_play)

    game_next_to_play_changed
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
