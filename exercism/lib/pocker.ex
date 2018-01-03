defmodule Poker.Card do
  defstruct [:rank, :suit]

  def new(card) do
    l = card |> String.length
    %Poker.Card{
      rank: card |> String.slice(0, l - 1),
      suit: card |> String.slice(l - 1, 1) |> string_to_suit
    }
  end

  def to_string(%Poker.Card{} = card) do
    "#{card.rank}#{card.suit |> suit_to_string}"
  end

  defp string_to_suit(initial) do
    case initial do
      "C" -> :clubs
      "D" -> :diamonds
      "H" -> :hearts
      "S" -> :spades
    end
  end

  defp suit_to_string(suit) do
    case suit do
      :clubs -> "C"
      :diamonds -> "D"
      :hearts -> "H"
      :spades -> "S"
    end
  end
end

defmodule Poker.Hand do
  alias Poker.Card, as: C
  alias Poker.Hand, as: H

  defstruct [:cards]

  def new(cards) do
    %H{cards: cards |> Enum.map(&C.new(&1))}
  end

  def compare(%H{} = a, %H{} = b) do
    1
  end

  def list_cards(%H{} = hand) do
    hand.cards |> Enum.map(&(C.to_string(&1)))
  end
end

defmodule Poker do
  # alias Poker.Card, as: C
  alias Poker.Hand, as: H

  def best_hand(hands) do
    hands
      |> Enum.map(&H.new(&1))
      |> Enum.reduce([], fn (hand, acc) ->
        if Enum.count(acc) == 0 do
          acc ++ [hand]
        else
          acc
        end
      end)
      |> Enum.map(&H.list_cards(&1))
  end
end
