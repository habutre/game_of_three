defmodule GameOfThree.Infrastructure.GameManagerTest do
  use ExUnit.Case, async: true

  alias GameOfThree.Infrastructure.GameManager

  setup do
    game_setup = %{}
    game = start_supervised!(GameManager, game_setup)
    %{game: game}
  end

  test "spawns game manager", %{game: game} do
    assert GameManager.bootstrap_game() == :ok
  end
end
