defmodule PlayerTest do
  alias GameOfThree.Player
  use ExUnit.Case
  doctest Player

  test "make a move with high number when no value is received" do
    assert Player.move() >= 10_000
  end

  test "make a move with high number when nil value is received" do
    assert Player.move(nil) >= 10_000
  end

  test "NEVER make a move with a number less than 10_000" do
    refute Player.move() < 10_000
  end

  test "GIVEN a move from opponent WHEN the value is greater than 10 THEN substracts 1" do
    assert Player.move(37) == 36
    assert Player.move(60) == 59
  end

  test "GIVEN a move from opponent WHEN the value is less or equals 10 AND division by 3 is greather than 1 THEN adds 1" do
    assert Player.move(9) == 10
    assert Player.move(6) == 7
    assert Player.move(5) == 6
  end

  test "GIVEN a move from opponent WHEN the value divided by 3 is less or equals 1 THEN returns the same value" do
    assert Player.move(3) == 3
    assert Player.move(2) == 2
  end
end
