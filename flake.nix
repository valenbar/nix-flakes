{
  description = "A collection my custom nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    go-typer-src = {
      url = "github:prime-run/go-typer";
      flake = false;
    };
    togo-src = {
      url = "github:prime-run/togo";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, go-typer-src, togo-src }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
      packages.${system} = {
        hello = pkgs.hello;
        togo = pkgs.callPackage ./packages/togo/package.nix { src = togo-src; };
        go-typer = pkgs.callPackage ./packages/go-typer/package.nix { src = go-typer-src; };
        deej = pkgs.callPackage ./packages/deej/package.nix {};
      };
      defaultPackage.${system} = self.packages.${system}.hello;
    };
}
