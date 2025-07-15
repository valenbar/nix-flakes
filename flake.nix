{
  description = "A collection my custom nix packages";

  outputs =
    {
      self,
      nixpkgs,
      go-typer-src,
      togo-src,
      clipse-gui-src,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system} = {
        hello = pkgs.hello;
        togo = pkgs.callPackage ./packages/togo/package.nix { src = togo-src; };
        go-typer = pkgs.callPackage ./packages/go-typer/package.nix { src = go-typer-src; };
        deej = pkgs.callPackage ./packages/deej/package.nix { };
        clipse-gui = pkgs.callPackage ./packages/clipse-gui/package.nix { src = clipse-gui-src; };
        toutui = pkgs.callPackage ./packages/toutui/package.nix { };
        systemd-manager-tui = pkgs.callPackage ./packages/systemd-manager-tui/package.nix { };
        audio-share = pkgs.callPackage ./packages/audio-share/package.nix { };
      };
      defaultPackage.${system} = self.packages.${system}.hello;
    };

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
    clipse-gui-src = {
      url = "github:d7omdev/clipse-gui";
      flake = false;
    };
  };
}
