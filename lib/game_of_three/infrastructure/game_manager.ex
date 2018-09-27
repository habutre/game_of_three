defmodule GameOfThree.Infrastructure.GameManager do
  use GenServer

  @moduledoc """
  The GameManager module is responsible by manage the games and players.
  Each player will be identified by an PID as well as the games
  Multiple games are expected to be played at same time
  """

  ## Client API
  #
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

  ## Server Callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:add_player, name}, _from, game) do
    # game struct game_name, current_turn{}, players
    # add player to player list
    {:reply, Map.fetch(players, name), game}
  end

  def handle_cast({:player, name, :turn, value}, game) do
    {:reply, 
  end
end
