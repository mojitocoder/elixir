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
    require IEx
    IEx.pry()
    cond do
      compare_pairs(a, b) != 0 ->
        compare_pairs(a, b)
      compare_pairs(a, b) == 0 ->
        compare_ranks(sort(a), sort(b))
    end
  end

  def compare_pairs(%H{} = a, %H{} = b) do
    pairs_of_a = get_pairs(a)
    pairs_of_b = get_pairs(b)
    cond do
      Enum.count(pairs_of_a) > Enum.count(pairs_of_b) ->
        1
      Enum.count(pairs_of_a) < Enum.count(pairs_of_b) ->
        -1
      Enum.count(pairs_of_a) == Enum.count(pairs_of_b)
        && Enum.count(pairs_of_b) == 0 ->
        0
      Enum.count(pairs_of_a) == Enum.count(pairs_of_b)
        && Enum.count(pairs_of_b) != 0 ->
        compare_integers(List.last(pairs_of_a), List.last(pairs_of_b))
    end
  end

  def compare_integers(a, b) do
    cond do
      a > b  -> 1
      a == b -> 0
      a < b  -> -1
    end
  end

  defp rank_counts(%H{} = hand) do
    hand.cards
      |> Enum.map(fn c -> C.get_comparable_rank(c) end)
      |> Enum.group_by(fn r -> r end)
      |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
  end

  def get_pairs(%H{} = hand) do
    rank_counts(hand)
      |> Enum.filter(fn {_, v} -> v == 2 end)
      |> Enum.map(fn {k, _} -> k end)
      |> Enum.sort
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

  defp remove_last_card(%H{} = hand) do
    %H{cards: hand.cards |> Enum.take(Enum.count(hand.cards) - 1)}
  end

  defp get_max_rank(%H{} = sorted_hand) do
    sorted_hand.cards |> List.last |> C.get_comparable_rank
  end

  # ascending
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
