# https://github.com/d7omdev/clipse-gui#installation--running
{
  lib,
  python3,
  wrapGAppsHook3,
  gtk3,
  gobject-introspection,
  src ? null,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "clipse-gui";
  version = "0.4.0";
  pyproject = true;

  inherit src;

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
    wrapGAppsHook3
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
