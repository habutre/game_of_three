defmodule PlayerTest do
  use ExUnit.Case
  doctest Player

  test "start game with high number when no value is received" do
    assert Player.move() >= 10_000
  end

  test "start game with high number when nil value is received" do
    assert Player.move(nil) >= 10_000
  end

  test "NEVER start game with a number less than 10_000" do
    refute Player.move() < 10_000
  end

  test "GIVEN a move from opponent, WHEN potentially make him/her the winner THEN add 1" do
    assert Player.move(3) == 3
    assert Player.move(2) == 2
    assert Player.move(6) == 7
    assert Player.move(5) == 6
    assert Player.move(37) == 36
    assert Player.move(60) == 59
    assert Player.move(9) == 10
  end
end
