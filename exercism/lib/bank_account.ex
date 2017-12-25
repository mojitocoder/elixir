# defmodule BankAccount do
#   defstruct [:balance]
#
#   def open_bank do
#     %BankAccount{balance: 0}
#   end
#
#   def balance(account) do
#     account.balance
#   end
#
#   def update(%BankAccount{} = account, amount) do
#     %BankAccount{account | balance: account.balance + amount}
#   end
# end


defmodule BankAccount do
  use Agent

  def open_bank do
    {:ok, pid} = Agent.start_link(fn -> {:open, []} end)
    pid
  end

  def balance(account) do
    Agent.get(account, fn {status, trans} ->
      case status do
        :open ->
          Enum.sum(trans)
        :closed ->
          {:error, :account_closed}
      end
    end)
  end

  def update(account, amount) do
    Agent.get_and_update(account, fn {status, trans} ->
      case status do
        :open ->
          {:ok, {:open, [amount | trans]}}
        :closed ->
          {{:error, :account_closed}, {:closed, trans}}
      end
    end)
  end

  def close_bank(account) do
    Agent.update(account, fn {status, trans} ->
      {:closed, trans}
    end)
  end
end
