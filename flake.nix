{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, systems, ... }:
  let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
    pkgsFor = system: nixpkgs.legacyPackages.${system};
  in
  {
    formatter = forEachSystem (
      system:
      let pkgs = pkgsFor system;
      in
      pkgs.nixfmt-rfc-style
    );

    packages = forEachSystem (
      system:
      let
        pkgs = pkgsFor system;
        lib = pkgs.lib;
      in
      rec {
        zodium = import .nix/default.nix { inherit pkgs lib; };
        default = zodium;
      }
    );

    devShells = forEachSystem (
      system:
      let
        pkgs = pkgsFor system;
      in
      {
        default = import .nix/shell.nix { inherit pkgs; };
      }
    );
  };
}
