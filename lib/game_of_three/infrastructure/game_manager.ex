defmodule GameOfThree.Infrastructure.GameManager do
  use GenServer

  alias GameOfThree.Domain.Game
  alias GameOfThree.Domain.Player

  @moduledoc """
  The GameManager module is responsible by manage the games and players.
  Each player will be identified by an PID as well as the games
  Multiple games are expected to be played at same time
  """

  ## Client API
  #
  def create_game do
    Game.create_game()
  end

  def current_state(server) do
    GenServer.call(server, :ok)
  end

  def add_player(server) do
    GenServer.call(server, {:add_player, Player.create()})
  end

  def start_game(game) do
    GenServer.call(game, {:start, :turn, Player.move()})
  end

  def move(game) do
    game_state = current_state(game)
    new_move = Player.move(game_state.move)
    result = GenServer.call(game, Game.evaluate_move(new_move))

    case result do
      {:ok, _move} ->
        __MODULE__.move(game)

      {:finish, _msg} ->
        GenServer.stop(game)
        result
    end
  end

  def start_link(game_setup) when is_map(game_setup) do
    GenServer.start_link(__MODULE__, game_setup)
  end

  ## Server Callbacks
  #
  def init(game_setup) do
    {:ok, game_setup}
  end

  def handle_call(:ok, _from, game) do
    {:reply, game, game}
  end

  def handle_call({:add_player, name}, _from, game) do
    {:reply, name, Game.add_player(game, name)}
  end

  def handle_call({:start, :turn, move}, _from, game) do
    {:reply, move, Game.start_game(game, move)}
  end

  def handle_call({:ok, move}, _from, game) do
    {:reply, {:ok, move}, Game.perform_turn(game, move)}
  end

  def handle_call({:tie, msg}, _from, game) do
    {:reply, {:finish, msg}, game}
  end

  def handle_call({:winner, msg}, _from, game) do
    {:reply, {:finish, msg}, game}
  end

  def handle_call({:error, msg}, _from, game) do
    {:reply, {:error, msg}, game}
  end

  def handle_info(_msg, game) do
    {:noreply, game}
  end

  def handle_terminate(:normal, game) do
    {:ok, game}
  end
end
