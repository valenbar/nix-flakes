{
  lib,
  buildGoModule,
  fetchFromGitHub
}:
buildGoModule rec {
  pname = "togo";
  version = "0.0.1";
  src = pkgs.fetchFromGitHub {
    owner = "prime-run";
    repo = "togo";
    rev = "43ff80b62ab3b1983ebea8bcacf7653d993b75ce";
    sha256 = "sha256-0wOovQV/2zxqTNNmVFLOfzAivLY1y9+04OnygUo8v1c=";
  };
  vendorHash = "sha256-7IPI02EXnEiy2OsysxL0xKZl/YASAo6xBXvUeNjYyfU=";
  ldflags = [
    "-s"
    "-w"
  ];
  meta = with pkgs.lib; {
    mainProgram = "togo";
  };
}
