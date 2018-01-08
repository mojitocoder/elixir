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
    cond do
      compare_straight_flushes(a, b) != 0 ->
        compare_straight_flushes(a, b)
      compare_four_of_a_kinds(a, b) != 0 ->
        compare_four_of_a_kinds(a, b)
      compare_full_houses(a, b) != 0 ->
        compare_full_houses(a, b)
      compare_flushes(a, b) != 0 ->
        compare_flushes(a, b)
      compare_straights(a, b) != 0 ->
        compare_straights(a, b)
      compare_triplets(a, b) != 0 ->
        compare_triplets(a, b)
      compare_pairs(a, b) != 0 ->
        compare_pairs(a, b)
      compare_pairs(a, b) == 0 ->
        compare_ranks(a, b)
    end
  end

  def compare_straight_flushes(%H{} = a, %H{} = b) do
    cond do
      is_straight_flush(a) && !is_straight_flush(b) ->
        1
      !is_straight_flush(a) && is_straight_flush(b) ->
        -1
      !is_straight_flush(a) && !is_straight_flush(b) ->
        0
      is_straight_flush(a) && is_straight_flush(b) ->
        compare_straights(a, b)
    end
  end

  def is_straight_flush(%H{} = hand) do
    get_straight_highest(hand) > 0 && is_flush(hand)
  end

  def compare_four_of_a_kinds(%H{} = a, %H{} = b) do
    cond do
      is_four_of_a_kind(a) && !is_four_of_a_kind(b) ->
        1
      !is_four_of_a_kind(a) && is_four_of_a_kind(b) ->
        -1
      is_four_of_a_kind(a) && is_four_of_a_kind(b) ->
        compare_sorted_arrays(get_ranks_by_reverse_count(a), get_ranks_by_reverse_count(b))
      !is_four_of_a_kind(a) && !is_four_of_a_kind(b) ->
        0
    end
  end

  def is_four_of_a_kind(%H{} = hand) do
    rank_counts(hand)
      |> Enum.map(fn {_, count} -> count end)
      |> Enum.sort
      == [1, 4]
  end

  # e.g.
  # returns: [quad's rank, kicker's rank]
  # returns: [triplet's rank, pair's rank]
  def get_ranks_by_reverse_count(%H{} = hand) do
    rank_counts(hand)
      |> Enum.sort(&(elem(&1,1) > elem(&2,1))) #sort descendingly by count
      |> Enum.map(fn {rank, _} -> rank end)
  end

  def compare_full_houses(%H{} = a, %H{} = b) do
    cond do
      is_full_house(a) && !is_full_house(b) ->
        1
      !is_full_house(a) && is_full_house(b) ->
        -1
      is_full_house(a) && is_full_house(b) ->
        compare_sorted_arrays(get_ranks_by_reverse_count(a), get_ranks_by_reverse_count(b))
      !is_full_house(a) && !is_full_house(b) ->
        0
    end
  end

  def is_full_house(%H{} = hand) do
    rank_counts(hand)
      |> Enum.map(fn {_, count} -> count end)
      |> Enum.sort
      == [2, 3]
  end

  def compare_flushes(%H{} = a, %H{} = b) do
    cond do
      is_flush(a) && !is_flush(b) ->
        1
      !is_flush(a) && is_flush(b) ->
        -1
      true ->
        0
    end
  end

  def is_flush(%H{} = hand) do
    hand.cards
      |> Enum.map(fn c -> c.suit end)
      |> MapSet.new
      |> Enum.count
      == 1
  end

  def compare_straights(%H{} = a, %H{} = b) do
    compare_sorted_arrays([get_straight_highest(a)], [get_straight_highest(b)])
  end

  def get_straight_highest(%H{} = hand) do
    ranks = get_sorted_ranks(hand)
    highest = ranks |> List.first
    lowest = ranks |> List.last
    cond do
      ranks == Enum.to_list(highest..lowest) ->
        highest
      ranks == [14, 5, 4, 3, 2] ->
        5
      true ->
        0
    end
  end

  def compare_triplets(%H{} = a, %H{} = b) do
    triplet_of_a = get_triplet(a)
    triplet_of_b = get_triplet(b)
    cond do
      Enum.count(triplet_of_a) > Enum.count(triplet_of_b) ->
        1
      Enum.count(triplet_of_a) < Enum.count(triplet_of_b) ->
        -1
      Enum.count(triplet_of_a) == Enum.count(triplet_of_b) ->
        compare_sorted_arrays(triplet_of_a, triplet_of_b)
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
      Enum.count(pairs_of_a) == Enum.count(pairs_of_b) ->
        compare_sorted_arrays(pairs_of_a, pairs_of_b)
    end
  end

  def rank_counts(%H{} = hand) do
    hand.cards
      |> Enum.map(fn c -> C.get_comparable_rank(c) end)
      |> Enum.group_by(fn r -> r end)
      |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
  end

  def get_pairs(%H{} = hand), do: get_multiples(hand, 2)

  def get_triplet(%H{} = hand), do: get_multiples(hand, 3)

  def get_multiples(%H{} = hand, m) do
    rank_counts(hand)
      |> Enum.filter(fn {_, v} -> v == m end)
      |> Enum.map(fn {k, _} -> k end)
      |> Enum.sort(&(&1 >= &2))
  end

  # descending
  def compare_sorted_arrays([], []), do: 0
  def compare_sorted_arrays([ha | ta], [hb | tb]) do
    cond do
      ha > hb  -> 1
      ha == hb -> compare_sorted_arrays(ta, tb)
      ha < hb  -> -1
    end
  end

  # descending
  def get_sorted_ranks(%H{} = hand) do
    hand.cards
      |> Enum.map(fn c -> C.get_comparable_rank(c) end)
      |> Enum.sort(&(&1 >= &2))
  end

  def compare_ranks(%H{} = a, %H{} = b) do
    compare_sorted_arrays(get_sorted_ranks(a), get_sorted_ranks(b))
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
