defmodule Dictionary do
  defdelegate start(), to: Dictionary.WordList, as: :words_list
  defdelegate random_word(), to: Dictionary.WordList
end
