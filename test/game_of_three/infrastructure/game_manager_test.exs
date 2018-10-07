defmodule GameOfThree.Infrastructure.GameManagerTest do
  use ExUnit.Case, async: true

  alias GameOfThree.Infrastructure.GameManager

  setup do
    game = start_supervised!({GameManager, GameManager.create_game()})
    %{game: game}
  end

  test "spawns game manager", %{game: game} do
    current_state = GameManager.current_state(game)
    {:ok, game_id} = Base.decode64(current_state.game_id)

    assert String.length(current_state.game_id) == 56
    assert String.ends_with?(game_id, "game_of_three")
  end

  test "add player A to game", %{game: game} do
    player_add = GameManager.add_player(game, "Joao")
    current_state = GameManager.current_state(game)

    assert player_add == "Joao"
    assert current_state.player_a == "Joao"
  end

  test "add player B to game", %{game: game} do
    GameManager.add_player(game, "Mario")
    player_add = GameManager.add_player(game, "Maria")
    current_state = GameManager.current_state(game)

    assert player_add == "Maria"
    assert current_state.player_a == "Mario"
    assert current_state.player_b == "Maria"
  end
end
