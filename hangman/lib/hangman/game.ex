defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints()
    }
  end

  def new_game() do
    new_game(Dictionary.random_word())
  end

  def make_move(game = %{game_state: state}, move) when state in [:won, :lost] do
    {game, tally(game)}
  end

  def make_move(game, move) do
    game = accept_move(game, move, MapSet.member?(game.used, move))
    {game, tally(game)}
  end

  defp accept_move(game, move, _allready_used = true) do
    Map.put(game, :game_state, :allready_used)
  end

  defp accept_move(game, move, _alerady_used) do
    game =
      game
      |> Map.put(:used, MapSet.put(game.used, move))
      |> score_move(Enum.member?(game.letters, move))

    game
  end

  defp tally(game) do
    123
  end

  defp score_move(game, _good_guess = true) do
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> maybe_won()

    Map.put(game, :game_state, new_state)
  end

  defp maybe_won(_all_letters_guessed = true), do: :won
  defp maybe_won(_), do: :good_guess
end
