defmodule Poker.Card do
  alias Poker.Card, as: C

  defstruct [:rank, :suit]

  def new(card) do
    l = card |> String.length
    %C{
      rank: card |> String.slice(0, l - 1),
      suit: card |> String.slice(l - 1, 1) |> string_to_suit
    }
  end

  def to_string(%C{} = card) do
    "#{card.rank}#{card.suit |> suit_to_string}"
  end

  def get_comparable_rank(%C{} = card) do
    case card.rank do
      "A" -> 14
      "K" -> 13
      "Q" -> 12
      "J" -> 11
      _ -> String.to_integer(card.rank)
    end
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

  def list_cards(%H{} = hand) do
    hand.cards |> Enum.map(&(C.to_string(&1)))
  end

  def compare(%H{} = a, %H{} = b) do
    compare_ranks(sort(a), sort(b))
  end

  def compare_ranks(%H{} = sorted_a, %H{} = sorted_b) do
    if Enum.count(sorted_a.cards) == 0 do
      0
    else
      a_max_rank = get_max_rank(sorted_a)
      b_max_rank = get_max_rank(sorted_b)
      cond do
        a_max_rank > b_max_rank
          -> 1
        a_max_rank == b_max_rank
          -> compare_ranks(remove_last_card(sorted_a), remove_last_card(sorted_b))
        a_max_rank < b_max_rank
          -> -1
      end
    end
  end

  def remove_last_card(%H{} = hand) do
    %H{cards: hand.cards |> Enum.take(Enum.count(hand.cards) - 1)}
  end

  def get_max_rank(%H{} = sorted_hand) do
    # hand.cards
    #   |> Enum.map(&C.get_comparable_rank(&1))
    #   |> Enum.sort(&(&1 >= &2))
    #   |> List.first
    sorted_hand.cards |> List.last |> C.get_comparable_rank
  end

  defp sort(%H{} = hand) do
    %H{cards: hand.cards
                |> Enum.sort(&(C.get_comparable_rank(&1) <= C.get_comparable_rank(&2)))}
  end
end

defmodule Poker do
  # alias Poker.Card, as: C
  alias Poker.Hand, as: H

  def best_hand(hands) do
    hands
      |> Enum.map(&H.new(&1))
      # |> Enum.map(fn h -> {h, H.sort(h)} end)
      |> Enum.reduce([], fn (hand, acc) ->
        case acc do
          [] ->
            [hand]
          [head | _] ->
            case H.compare(hand, head) do
              1  -> [hand]
              0  -> acc ++ [hand]
              -1 -> acc
            end
        end
      end)
      |> Enum.map(&H.list_cards(&1))
  end
end
