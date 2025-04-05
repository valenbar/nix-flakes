{
  buildGoModule,
  src ? null
}:
buildGoModule (finalAttrs: {
  pname = "go-typer";
  version = "0.0.1";
  inherit src;
  vendorHash = "sha256-NOM7wqzWvQtX2IyrlgsIIgL0kgGrUJn5YY7zfGcF4Vk=";

  ldflags = [
    "-s"
    "-w"
  ];
  meta = {
    mainProgram = "go-typer";
    homepage = "https://github.com/prime-run/go-typer";
  };
})
