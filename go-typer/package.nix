{
  lib,
  buildGoModule,
  fetchFromGitHub
}:
buildGoModule (finalAttrs: {
  pname = "go-typer";
  version = "0.0.1";
  src = fetchFromGitHub {
    owner = "prime-run";
    repo = "go-typer";
    rev = "fe3a24483f29d5e6e77cc62b7734c78286acc12b";
    sha256 = "0ajr827f4gkgciah9ilywqdzq6s00jx8v1mvvwkna8qacvgsxvbv";
  };
  vendorHash = "sha256-NOM7wqzWvQtX2IyrlgsIIgL0kgGrUJn5YY7zfGcF4Vk=";
  ldflags = [
    "-s"
    "-w"
  ];
  meta = with lib; {
    mainProgram = "go-typer";
    homepage = "https://github.com/prime-run/go-typer";
  };
})
