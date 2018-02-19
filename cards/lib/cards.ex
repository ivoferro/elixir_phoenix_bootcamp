defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello
      :world

  """
  def hello do
    :world
  end

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    deck
    |> Enum.shuffle
  end

  def contains?(deck, card) do
    deck
    |> Enum.member?(card)
  end

  def deal(deck, hand_size) do
    deck
    |> Enum.split(hand_size)
  end

  def save(deck, filename) do
    bin = :erlang.term_to_binary(deck)
    File.write(filename, bin)
  end

end
