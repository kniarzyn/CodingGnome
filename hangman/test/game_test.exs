defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns known structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "game state do not change when game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _tally} = Game.make_move(game, "x")
    end
  end

  test "game state change on letter is allready used or not" do
    {game, _tally} = Game.new_game("box") |> Game.make_move("x")
    assert game.game_state != :allready_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :allready_used
  end

  test "when good letter ar given game states are chenged" do
    {game, _tally} = Game.new_game("better") |> Game.make_move("b")
    assert MapSet.member?(game.used, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "when all letters are given game_state is :won" do
    {game, _tally} =
      Game.new_game("better")
      |> Map.put(:used, MapSet.new(["b", "e", "t"]))
      |> Game.make_move("r")

    assert game.game_state == :won
  end

  test "when good guess turns left is not decrement" do
    {game, _tally} =
      Game.new_game("better")
      |> Map.put(:used, MapSet.new(["b"]))
      |> Game.make_move("r")

    assert game.turns_left == 7
  end

  test "when bad guess turns left is decrement" do
    {game, _tally} =
      Game.new_game("better")
      |> Map.put(:used, MapSet.new(["b"]))
      |> Game.make_move("c")

    assert game.turns_left == 6
  end

  test "game is lost when not turns left" do
    {game, _tally} =
      Game.new_game("better")
      |> Map.put(:turns_left, 1)
      |> Game.make_move("c")

    assert game.game_state == :lost
  end

  # Test whole world guessing
  test "Testing whole word guessing" do
    [
      {"w", :good_guess, 7},
      {"c", :bad_guess, 6},
      {"i", :good_guess, 6},
      {"b", :good_guess, 6},
      {"a", :bad_guess, 5},
      {"l", :good_guess, 5},
      {"c", :allready_used, 5},
      {"e", :won, 5}
    ]
    |> Enum.reduce(
      Game.new_game("wibble"),
      fn {guess, state, turns_left}, game ->
        {game, _tally} = Game.make_move(game, guess)
        assert {game.turns_left, game.game_state} == {turns_left, state}
        game
      end
    )
  end
end
