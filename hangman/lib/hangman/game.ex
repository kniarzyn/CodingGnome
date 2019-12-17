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

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      guesed_letters: game.letters |> reveal_letter(game.used)
    }
  end

  def make_move(game = %{game_state: state}, move) when state in [:won, :lost] do
    game
  end

  def make_move(game, move) do
    accept_move(game, move, MapSet.member?(game.used, move))
  end

  defp accept_move(game, move, _allready_used = true) do
    Map.put(game, :game_state, :allready_used)
  end

  defp accept_move(game, move, _not_used) do
    game
    |> Map.put(:used, MapSet.put(game.used, move))
    |> score_move(Enum.member?(game.letters, move))
  end

  defp score_move(game, _good_guess = true) do
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> maybe_won()

    Map.put(game, :game_state, new_state)
  end

  defp score_move(game = %{turns_left: 1}, _bad_guess) do
    Map.put(game, :game_state, :lost)
  end

  defp score_move(game = %{turns_left: turns_left}, _bad_guess) do
    %{game | turns_left: turns_left - 1, game_state: :bad_guess}
  end

  defp maybe_won(_all_letters_guessed = true), do: :won
  defp maybe_won(_), do: :good_guess

  defp reveal_letter(letters, used) do
    Enum.map(letters, fn letter ->
      case MapSet.member?(used, letter) do
        true -> letter
        false -> "_"
      end
    end)
  end
end
