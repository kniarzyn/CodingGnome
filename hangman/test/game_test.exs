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
      assert {^game, _} = Game.make_move(game, "x")
    end
  end

  test "game state change on letter is allready used or not" do
    game = Game.new_game("box")
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :allready_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :allready_used
  end

  test "when good letter ar given game states are chenged" do
    game = Game.new_game("better")
    {game, _tally} = Game.make_move(game, "b")
    assert MapSet.member?(game.used, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "when all letters are given game_state is :won" do
    game = Game.new_game("better") |> Map.put(:used, MapSet.new(['b', 'e', 't']))
    {game, _tally} = Game.make_move(game, "r")
    assert game.game_state == :won
  end
end
