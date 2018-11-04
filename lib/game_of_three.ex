defmodule GameOfThree do
  @moduledoc """
  The GameOfThree is a software development challenge which help developer to 
  apply good practices, techniques and architectutal decisions when developing
  systems in a distributed and decoupled way.
  Two players have to play a game against each other where one starts with a 
  number which is divided by 3 by the game server allowing the opponent add 1, 
  remove 1 or do nothing regard the current movement in order to win the game.

  Play A starts with 30
  Play B will receive 30/3 and can add 1, remove 1 or do nothing
  Play A will receive 3,66 or 3,33 or 3
  The winner will be the play who reaches the 1 first
  No winners will be also possible in case the server calculate a division resulting
  in 2 or less
  """
end
