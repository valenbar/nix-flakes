{
  buildGoModule,
  src ? null
}:
buildGoModule (finalAttrs: {
  pname = "togo";
  version = "1.0.1";
  inherit src;

  vendorHash = "sha256-7IPI02EXnEiy2OsysxL0xKZl/YASAo6xBXvUeNjYyfU=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    mainProgram = "togo";
    homepage = "https://github.com/prime-run/togo";
  };
})
