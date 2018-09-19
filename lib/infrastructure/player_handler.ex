defmodule PlayerHandler do
  use GenStage

  def init(move) do
    {:producer_consumer, move}
  end

  def handle_events(oponent_move, from, number) do
    IO.inspect(oponent_move)

    move = Enum.map(oponent_move, &Player.move/1)

    {:no_reply, move, number}
  end
end
