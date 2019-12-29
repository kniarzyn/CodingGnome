defmodule TextClient.Mover do
  alias TextClient.State

  def make_move(%State{game_service: game, guess: guess} = state) do
    {new_game_state, tally} = Hangman.make_move(game, guess)
    %State{state | game_service: new_game_state, tally: tally}
  end
end
