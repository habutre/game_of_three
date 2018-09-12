defmodule GameOfThree do

  def lauch do
    {:ok, game} = GenStage.start_link(GameManager, 0)    # starting from zero
    {:ok, player_a} = GenStage.start_link(PlayerHandler, nil)    # multiply by 2
    {:ok, player_b} = GenStage.start_link(PlayerHandler, nil) # sleep for a second

    GenStage.sync_subscribe(player_a, to: game)
    GenStage.sync_subscribe(player_b, to: game)
    #GenStage.sync_subscribe(player_b, to: player_a)
    #GenStage.sync_subscribe(player_a, to: player_b)
  end
end
