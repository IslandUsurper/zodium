defmodule Zodium do
  @moduledoc """
  Zig-powered libsodium bindings for Elixir.
  """

  use Zig,
    otp_app: :zodium,
    c: [link_lib: {:system, "sodium"}],
    callbacks: [:on_load],
    zig_code_path: "./src/zodium.zig"

  defp __on_load__, do: nil
end
