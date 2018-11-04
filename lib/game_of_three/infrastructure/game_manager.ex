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
    player = Player.create()
    GenServer.call(server, {:add_player, player})
  end

  def start_game(game) do
    move = Player.move()

    GenServer.call(game, {:start, :turn, move})
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
    # TODO move the player allocation to Game module
    {:ok, player_a} = Map.fetch(game, :player_a)

    new_game =
      if player_a == nil do
        Map.put(game, :player_a, name)
      else
        Map.put(game, :player_b, name)
      end

    {:reply, name, new_game}
  end

  def handle_call({:start, :turn, move}, _from, game) do
    # game struct game_name, current_turn{}, players
    # call other player with the current value
    {:ok, player_b} = Map.fetch(game, :player_b)
    game = Map.put(game, :move, move)
    game = Map.put(game, :next_to_play, player_b)

    {:reply, move, game}
  end

  def handle_call({:ok, move}, _from, game) do
    # TODO move the move control to Game module
    {:ok, played} = Map.fetch(game, :next_to_play)
    {:ok, player_a} = Map.fetch(game, :player_a)
    {:ok, player_b} = Map.fetch(game, :player_b)

    next_to_play =
      if played == player_a do
        player_b
      else
        player_a
      end

    game = Map.put(game, :move, move)
    game = Map.put(game, :next_to_play, next_to_play)

    {:reply, {:ok, move}, game}
  end

  def handle_call({:tie, msg}, _from, game) do
    {:reply, msg, game}
  end

  def handle_call({:winner, msg}, _from, game) do
    {:reply, msg, game}
  end

  def handle_call({:error, msg}, _from, game) do
    {:reply, msg, game}
  end

  def handle_info(result, game) do
    IO.inspect(result, label: "Unmatched message")
  end
end
