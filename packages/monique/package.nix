{
  pkgs ? import <nixpkgs> { },
}:

pkgs.python314Packages.buildPythonApplication rec {
  pname = "monique";
  version = "0.5.0"; # or "unstable"

  src = pkgs.fetchFromGitHub {
    owner = "ToRvaLDz";
    repo = "monique";
    rev = version; # or commit hash
    sha256 = "sha256-ck5WYlTsuC6TSulK/597ZjMxBIA7vI/VNwUMrQ+e54g=";
  };

  pyproject = true;
  build-system = with pkgs.python314Packages; [ setuptools ];

  # Python deps
  propagatedBuildInputs = with pkgs.python314Packages; [
    setuptools
    pygobject3
  ];

  nativeBuildInputs = [
    pkgs.wrapGAppsHook3
    pkgs.gobject-introspection
  ];

  # Native / system deps (GTK etc.)
  buildInputs = with pkgs; [
    gtk4
    libadwaita
  ];

  # optional runtime deps
  # pyudev is optional feature
  # add if you want full functionality
  # python3Packages.pyudev

  meta = with pkgs.lib; {
    description = "Graphical monitor configurator for Wayland compositors";
    homepage = "https://github.com/ToRvaLDz/monique";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
