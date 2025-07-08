{
  fetchFromGitHub,
  rustPlatform,
  lib,
}:
rustPlatform.buildRustPackage rec {
  pname = "systemd-manager-tui";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "matheus-git";
    repo = pname;
    tag = "v${version}";
    hash = "sha256-Vky38cetk5eOSq+J0QjQJBlspa8Yf/0V2cnzPrGmqE4=";
  };

  useFetchCargoVendor = true;

  cargoHash = "sha256-GghQGGgSyZnH6OmFY/D0dR6gBwxgqDutW9wbRheUREA=";

  nativeBuildInputs = [
  ];

  buildInputs = [
  ];

  meta = {
    description = "A program for managing systemd services through a TUI (Terminal User Interfaces)";
    homepage = "https://github.com/matheus-git/systemd-manager-tui";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
  };
}
