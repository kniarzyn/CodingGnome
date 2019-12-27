defmodule TextClient.Mover do
  alias TextClient.State

  def make_move(game = %State{game_service: game, guess: guess}) do
    {new_game_state, tally} = Hangman.make_move(game, guess)
    %State{game | game_service: new_game_state, tally: tally}
  end
end
