defmodule GameOfThree.GameTest do
  use ExUnit.Case
  alias GameOfThree.Domain.Game
  doctest Game

  test "GIVEN a player move WHEN no value is sent                           THEN an error message should be sent" do
    assert({:error, "An empty movement is not allowed"} = Game.evaluate_move())
  end

  test "GIVEN a player move WHEN the value is null                          THEN an error message should be sent" do
    assert({:error, "An empty movement is not allowed"} = Game.evaluate_move(nil))
  end

  test "GIVEN a player move WHEN the value is not a number                  THEN an error message should be sent" do
    assert({:error, "A numeric value is expected here"} = Game.evaluate_move("a"))
  end

  test "GIVEN a player move WHEN the value is out of range                  THEN an error message should be sent" do
    assert({:error, "The movement is out of range"} = Game.evaluate_move(0))
    assert({:error, "The movement is out of range"} = Game.evaluate_move(0.6))
    assert({:error, "The movement is out of range"} = Game.evaluate_move(25_001))
  end

  test "GIVEN a player move WHEN the value divided by 3 is less or equals 1 THEN there is not Winner" do
    assert({:tie, "There is no winners in this game!"} = Game.evaluate_move(2))
  end

  test "GIVEN a player move WHEN the value divided by 3 is equals 1         THEN announce the Winner" do
    assert({:winner, "The player xxx has won!"} = Game.evaluate_move(3))
  end

  test "GIVEN a player move WHEN the value divided by 3 is greather than 1  THEN send the changed value to opponent" do
    assert({:ok, 12} = Game.evaluate_move(38))
    assert({:ok, 345} = Game.evaluate_move(1037))
    assert({:ok, 2906} = Game.evaluate_move(8719))
    refute({:ok, 1} == Game.evaluate_move(3))
  end
end
