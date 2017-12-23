defmodule DiffieHellman do
  require Integer

  def generate_private_key(p) do
    :rand.uniform(p - 1)
  end

  def generate_public_key(p, g, private_key) do
    # rem(round(pow(g, private_key)), p)
    :crypto.mod_pow(g, private_key, p) |> :binary.decode_unsigned
  end

  def generate_shared_secret(p, bob_public_key, alice_private_key) do
    generate_public_key(p, bob_public_key, alice_private_key)
  end

  def pow(_, 0), do: 1
  def pow(x, n) when Integer.is_odd(n), do: x * pow(x, n - 1)
  def pow(x, n) do
    result = pow(x, div(n, 2))
    result * result
  end
end
