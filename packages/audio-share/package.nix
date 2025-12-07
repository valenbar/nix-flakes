# Source: https://github.com/benshewan/dots/blob/ae69d74f789b3b10dbbbf49ff35d1b0e9795a2ce/packages/audio-share/default.nix#L6
{
  pkgs,
  stdenv,
  lib,
}:
stdenv.mkDerivation {
  pname = "audio-share";
  version = "0.3.4";
  src = pkgs.fetchFromGitHub {
    owner = "mkckr0";
    repo = "audio-share";
    rev = "342751fe675367483170b002ec6054e243966dc0";
    sha256 = "sha256-EuANnVwxeEzLhp8j/okQ2f1FSt4U61UK9kersgETBpQ=";
  };
  sourceRoot = "source/server-core";

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  buildInputs = with pkgs; [
    vcpkg
    asio
    protobuf
    zlib
    cxxopts
    spdlog
    pipewire
  ];

  postPatch = ''
    substituteInPlace src/network_manager.cpp \
      --replace "_ioc->post(" "asio::post(*_ioc, " 

    # If include is missing
    if ! grep -q "asio/post.hpp" src/network_manager.cpp; then
      sed -i '1i #include <asio/post.hpp>' src/network_manager.cpp
    fi

    substituteInPlace CMakeLists.txt \
      --replace-warn 'find_package(Protobuf CONFIG REQUIRED)' 'find_package(Protobuf REQUIRED)' \
      --replace-warn 'find_package(asio CONFIG REQUIRED)' "" \
      --replace-warn 'asio::asio' ""
  '';

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_PREFIX_PATH=${pkgs.protobuf}:${pkgs.cxxopts}:${pkgs.spdlog}"
    "-DASIO_INCLUDE_DIR=${pkgs.asio}/include"
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m 755 as-cmd $out/bin/audio-share
    runHook postInstall
  '';

  meta = with lib; {
    description = "Audio Share can share Windows/Linux computer's audio to Android phone over network, so your phone becomes the speaker of computer. (You needn't buy a new speaker😄.)";
    homepage = "https://github.com/mkckr0/audio-share";
    license = licenses.asl20;
    # maintainers = with maintainers; [];
    mainProgram = "audio-share";
  };
}
