# Zodium

Zig-compiled libsodium bindings for Elixir.

## Installation

Install [libsodium](https://doc.libsodium.org/doc) with your favorite package manager, with "-dev" if its repository splits source and executable packages.

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `zodium` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:zodium, "~> 0.1.0"}
  ]
end
```

The [zig](https://ziglang.org) toolchain must be installed as well. Either use your package manager, or let Mix do it with `mix zig.get` after running `mix deps.get`. You may also set `ZIG_ARCHIVE_PATH` to a local installation of zig.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/zodium>.

