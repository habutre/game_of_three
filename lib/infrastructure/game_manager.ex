defmodule GameManager do
  use GenStage

  @moduledoc """
  The GameManager module is responsible by manage the games and players playing.
  Each player will be identified by an PID as well as the games
  Multiple games are expected to be played at same time
  """

  def init(args) do
    {:producer, args}
  end

  def handle_demand(player, move) do
    # turn -> player turn
    # move -> value sent by the player turn movement
    IO.inspect(player)
    IO.inspect(move)
    {:no_reply, player, move}
  end
end
