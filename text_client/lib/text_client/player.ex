defmodule TextClient.Player do
  alias TextClient.State

  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("You WON!")
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_with_message("You LOST!")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Bad guess!")
  end

  def play(game = %State{tally: %{game_state: :allready_used}}) do
    continue_with_message(game, "You alredy used this latter!")
  end

  def play(game) do
    continue(game)
  end

  ############# PRIVATE FUNC ############################
  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end

  defp continue(game) do
    game
    |> display()
    |> prompt()
    |> make_move()
    |> play()
  end

  defp continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp display(game) do
  end

  defp prompt(game) do
  end

  defp make_move(game) do
  end
end
