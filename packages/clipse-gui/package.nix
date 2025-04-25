# https://github.com/d7omdev/clipse-gui#installation--running
# https://github.com/Daru-san/Snowpkgs/blob/be3712737ce0c9f0921251b25f7747c64e5ba53a/packages/clipse-gui/default.nix#L55
{
  lib,
  python3,
  fetchFromGitHub,
  wrapGAppsHook,
  gtk3,
  gobject-introspection,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "clipse-gui";
  version = "0.1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "d7omdev";
    repo = "clipse-gui";
    rev = "v${version}";
    hash = "sha256-7UnlGDPNycdTxpm/fXT6bFJU8U2UGqLgmspNukaFdWk=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  dependencies = with python3.pkgs; [
    nuitka
    ordered-set
    pycairo
    pygobject3
    zstandard
  ];

  nativeBuildInputs = [
    wrapGAppsHook
    gobject-introspection
  ];
  buildInputs = [
    gtk3
  ];

  pythonImportsCheck = [
    "clipse_gui"
  ];

  postInstall = ''
    mkdir -p $out/bin

    install -Dm775 $src/clipse-gui.py $out/bin/clipse-gui
  '';

  meta = {
    description = "A gui for the clipse clipboard";
    homepage = "https://github.com/d7omdev/clipse-gui";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "clipse-gui";
  };
}
