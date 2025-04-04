{
  lib,
  buildGoModule,
  fetchFromGitHub
}:
buildGoModule (finalAttrs: {
  pname = "togo";
  version = "1.0.1";
  src = fetchFromGitHub {
    owner = "prime-run";
    repo = "togo";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-0wOovQV/2zxqTNNmVFLOfzAivLY1y9+04OnygUo8v1c=";
  };
  vendorHash = "sha256-7IPI02EXnEiy2OsysxL0xKZl/YASAo6xBXvUeNjYyfU=";
  ldflags = [
    "-s"
    "-w"
  ];
  meta = with lib; {
    mainProgram = "togo";
    homepage = "https://github.com/prime-run/togo";
  };
})
