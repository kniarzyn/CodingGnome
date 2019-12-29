defmodule TextClient.Summary do
  def display(game = %{tally: tally}) do
    IO.puts([
      "\n",
      "#### SUMARY ####\n",
      "Word so far: #{Enum.join(tally.guesed_letters, " ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "##########################\n"
    ])

    game
  end
end
