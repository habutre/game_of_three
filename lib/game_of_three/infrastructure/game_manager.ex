defmodule GameOfThree.Infrastructure.GameManager do
  use GenServer

  alias GameOfThree.Domain.Game

  @moduledoc """
  The GameManager module is responsible by manage the games and players.
  Each player wqill be identified by an PID as well as the games
  Multiple games are expected to be played at same time
  """

  ## Client API
  #

  def create_game do
    Game.create_game()
  end

  def start_link(game_setup) when is_map(game_setup) do
    GenServer.start_link(__MODULE__, game_setup)
  end

  def current_state(server) do
    GenServer.call(server, :ok)
  end

  ## Server Callbacks
  def init(game_setup) do
    {:ok, game_setup}
  end

  def handle_call(_no_state_change, _from, game) do
    {:reply, game, game}
  end

  def handle_call({:add_player, name}, _from, game) do
    # game struct game_name, current_turn{}, players
    # add player to player list
    {:reply, name, game}
  end

  def handle_call({:player, name, :turn, value}, _from, game) do
    # game struct game_name, current_turn{}, players
    # call other player with the current value
    {:reply, name, game}
  end
end
