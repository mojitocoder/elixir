defmodule Poker.Card do
  defstruct [:rank, :suit]

  def new(card) do
    l = card |> String.length
    %Poker.Card{
      rank: card |> String.slice(0, l - 1),
      suit: card |> String.slice(l - 1, 1) |> get_suit
    }
  end

  defp get_suit(initial) do
    case initial do
      "C" -> :clubs
      "D" -> :diamonds
      "H" -> :hearts
      "S" -> :spades
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
    
  end
end

defmodule Poker do
  # alias Poker.Card, as: C
  alias Poker.Hand, as: H

  def best_hand(hands) do
    hands
      |> Enum.map(&H.new(&1))
  end
end
