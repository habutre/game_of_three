defmodule GameOfThree.Infrastructure.GameManagerTest do
  use ExUnit.Case, async: true

  alias GameOfThree.Infrastructure.GameManager

  setup do
    game = start_supervised!({GameManager, GameManager.create_game()})
    %{game: game}
  end

  describe "Game Manager Bootstrap" do
    test "spawns game manager", %{game: game} do
      current_state = GameManager.current_state(game)
      {:ok, game_id} = Base.decode64(current_state.game_id)

      assert String.length(current_state.game_id) == 56
      assert String.ends_with?(game_id, "game_of_three")
    end

    test "add player A to game", %{game: game} do
      player_add = GameManager.add_player(game)
      current_state = GameManager.current_state(game)

      assert current_state.player_a == player_add
    end

    test "add player B to game", %{game: game} do
      player_a = GameManager.add_player(game)
      player_b = GameManager.add_player(game)
      current_state = GameManager.current_state(game)

      assert current_state.player_a == player_a
      assert current_state.player_b == player_b
    end

    @tag skip: "Fix overloaded game room"
    test "refuse new players when the room is full", %{game: game} do
      player_a = GameManager.add_player(game)
      player_b = GameManager.add_player(game)
      player_c = GameManager.add_player(game)
      current_state = GameManager.current_state(game)

      assert current_state.player_a == player_a
      assert current_state.player_b == player_b
    end
  end

  describe "Game Manager Play" do
    test "Randomize players and start", %{game: game} do
      player_a = GameManager.add_player(game)
      player_b = GameManager.add_player(game)

      started = GameManager.start_game(game)

      assert started >= 10_000 && started <= 25_000
    end

    test "Move from next player", %{game: game} do
      player_a = GameManager.add_player(game)
      player_b = GameManager.add_player(game)
      previous_move = GameManager.start_game(game)
      move = GameManager.move(game)
      game_state = GameManager.current_state(game)

      assert move < previous_move
      assert game_state.next_to_play == player_a
      assert game_state.move == move
    end
  end
end
