defmodule ZodiumTest do
  use ExUnit.Case
  doctest Zodium

  describe "crypto box" do
    test "box/4 and box_open/4" do
      nonce = Zodium.randombytes(24)
      assert byte_size(nonce) == 24

      assert %{public: pk, secret: sk} = Zodium.box_keypair()

      message = "This is my message. There are many like it, but this one is mine."
      ciphered = Zodium.box(message, nonce, pk, sk)

      assert {:ok, ^message} = Zodium.box_open(ciphered, nonce, pk, sk)
    end

    test "box_seal/2 and box_seal_open/3" do
      assert %{public: pk, secret: sk} = Zodium.box_keypair()

      message = "I've got a lovely bunch of coconuts"

      ciphered = Zodium.box_seal(message, pk)

      assert {:ok, ^message} = Zodium.box_seal_open(ciphered, pk, sk)
    end
  end
end
