defmodule GameOfThree do
  alias GameOfThree.Infrastructure.GameManager
  alias GameOfThree.Infrastructure.PlayerHandler

  def lauch do
    # starting from zero
    {:ok, game} = GenStage.start_link(GameManager, 0)
    # multiply by 2
    {:ok, player_a} = GenStage.start_link(PlayerHandler, nil)
    # sleep for a second
    {:ok, player_b} = GenStage.start_link(PlayerHandler, nil)

    GenStage.sync_subscribe(player_a, to: game)
    GenStage.sync_subscribe(player_b, to: game)
    # GenStage.sync_subscribe(player_b, to: player_a)
    # GenStage.sync_subscribe(player_a, to: player_b)
  end
end
