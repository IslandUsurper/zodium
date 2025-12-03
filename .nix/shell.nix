{ pkgs, ... }:
with pkgs;
let
  elixir = beam.packages.erlang_27.elixir_1_18;
in
pkgs.mkShell {
  packages = [
    elixir
    libsodium
    mix2nix
    zig
  ] ++ lib.optional stdenv.isLinux inotify-tools
  ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
    CoreFoundation
    CoreServices
  ]);

  enterShell = ''
    # ERL_LIBS causes a load of compile warnings (warning: this clause cannot
    # match because of a previous clause at line 1 that always matches) in the
    # standard library. It appears to be because things are evaluated twice.
    # An actual export -n isn't inherited properly so we just set it blank.
    export ERL_LIBS=""
  '';

  env =  {
    ERL_AFLAGS = "-kernel shell_history enabled";
    ERL_INCLUDE_PATH = "${elixir}/lib/erlang/usr/include";
  };
}
