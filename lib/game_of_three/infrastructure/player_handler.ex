defmodule PlayerHandler do
  use GenServer

  # Client API
  def init(args) do
    {:ok, args}
  end
  
  # Server callbacks
  def handle_call({:player, player, :move, move}, _from, game) do
    # x = Domain.Player.move(move)
    {:reply, 100, game}
  end
end
