defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
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

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` indicates how much cards are going to the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    deck
    |> Enum.split(hand_size)
  end

  def save(deck, filename) do
    bin = :erlang.term_to_binary(deck)
    File.write(filename, bin)
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, bin } -> :erlang.binary_to_term(bin)
      { :error, _reason } -> "The file doesn't exists"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
