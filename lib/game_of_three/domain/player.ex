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
    wait_time()

    seed_game()
  end

  def move(opponent_move) when is_nil(opponent_move) do
    wait_time()

    seed_game()
  end

  def move(opponent_move) do
    wait_time()

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
    # See GameOfThree.Domain.Game.generate_id()
    Base.encode64("#{NaiveDateTime.to_iso8601(NaiveDateTime.utc_now())}_game_of_three")
  end

  defp generate_name do
    name = :crypto.strong_rand_bytes(17)

    name
    |> Base.url_encode64()
    |> binary_part(0, 17)
  end

  defp wait_time do
    1..4
    |> Enum.random()
    |> (fn t -> t * 100 end).()
    |> Process.sleep()

    :ok
  end
end
