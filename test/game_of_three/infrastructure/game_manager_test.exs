defmodule GameOfThree.Infrastructure.GameManagerTest do
  use ExUnit.Case, async: true

  alias GameOfThree.Infrastructure.GameManager
  alias GameOfThree.Domain.Game

  setup do
    game_setup = %Game{game_id: Base.encode64("#{NaiveDateTime.to_iso8601(NaiveDateTime.utc_now())}_game_of_three")}
    game = start_supervised!({GameManager, game_setup})
    %{game: game}
  end

  test "spawns game manager", %{game: game} do
    current_state = GameManager.current_state(game)
    {:ok, game_id} = Base.decode64(current_state.game_id)

    refute current_state.game_id == nil
    assert String.ends_with?(game_id, "game_of_three")
  end

  test "add player A to game" do
    flunk "Not implemented!"
  end
end
