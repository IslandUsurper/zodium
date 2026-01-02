defmodule Zodium do
  @moduledoc """
  Zig-powered libsodium bindings for Elixir.
  """

  use Zig,
    otp_app: :zodium,
    c: [link_lib: {:system, "sodium"}],
    callbacks: [:on_load],
    nifs: [
      randombytes: [:dirty_cpu],
      box_keypair: [:dirty_cpu],
      box: [:dirty_cpu],
      box_open: [:dirty_cpu],
      box_seal: [:dirty_cpu],
      box_seal_open: [:dirty_cpu]
    ],
    zig_code_path: "./src/zodium.zig"

  defp __on_load__, do: nil
end
