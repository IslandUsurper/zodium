{ pkgs, lib, ... }:
with pkgs;
let
  packages = beam.packagesWith beam.interpreters.erlang_27;
  src = ./..;

  propagatedBuildInputs = [ libsodium ];

  pname = "zodium";
  version = "0.0.1";
  mixEnv = "prod";

  hexDeps = import ./deps.nix {
    inherit lib;
    beamPackages = packages;
  };

  mixNixDeps = hexDeps;
in
packages.mixRelease {
  inherit
    src
    pname
    version
    propagatedBuildInputs
    mixEnv
    mixNixDeps
    ;
  }
