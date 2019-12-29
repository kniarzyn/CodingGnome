defmodule TextClient.Prompter do
  def accept_move(game) do
    IO.gets("Your guess: ")
    |> check_input(game)
  end

  # IO.gets zwraca: string / :eof / {:error, reason}
  defp check_input({:error, reason}, game) do
    IO.puts("Game ended: #{reason}")
    exit(:normal)
  end

  defp check_input(:eof, game) do
    IO.puts("Looks like you gave up ....")
    exit(:normal)
  end

  defp check_input(input, game) do
    # \n - new line == space
    input = String.trim(input)

    cond do
      input =~ ~r/\A[a-z]\z/ ->
        Map.put(game, :guess, input)

      true ->
        IO.puts("please enter a single lowercase latter")
        accept_move(game)
    end
  end
end
