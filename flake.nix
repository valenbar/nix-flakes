{
  description = "A collection my custom nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = rec {
      hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      togo = nixpkgs.legacyPackages.x86_64-linux.callPackage ./togo/package.nix { };
      go-typer = nixpkgs.legacyPackages.x86_64-linux.callPackage ./go-typer/package.nix { };
    };
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;
  };
}
