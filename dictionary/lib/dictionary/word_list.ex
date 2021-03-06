defmodule Dictionary.WordList do
  use Agent

  @me __MODULE__

  def start_link(_params) do
    Agent.start_link(&words_list/0, name: @me)
  end

  def random_word() do
    Agent.get(@me, &Enum.random/1)
  end

  def words_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

  # ## Callbacks
  # def init(_params) do
  #   {:ok, []}
  # end
end
