{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  buildPackages,
  installShellFiles,
  versionCheckHook,
  makeWrapper,
  enableCmount ? true,
  fuse,
  fuse3,
  macfuse-stubs,
  librclone,
  nix-update-script,
}:

buildGoModule rec {
  pname = "rclone";
  version = "1.72.1";

  outputs = [
    "out"
    "man"
  ];

  src = fetchFromGitHub {
    owner = "internxt";
    repo = "rclone";
    # tag = "v${version}";
    rev = "cc0201a2345bfe096d6ab50f556813095582f881";
    hash = "sha256-So3uIQpIeZsOKwsfwiAUeSd7GkhFDZyl5SuC81tpVKw=";
  };

  vendorHash = "sha256-amhKhTDKHDDvP7yqlkZUUMdQPznE+QxoS6RojdyrhIQ=";

  subPackages = [ "." ];

  nativeBuildInputs = [
    installShellFiles
    makeWrapper
  ];

  buildInputs = lib.optional enableCmount (
    if stdenv.hostPlatform.isDarwin then macfuse-stubs else fuse
  );

  tags = lib.optionals enableCmount [ "cmount" ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/rclone/rclone/fs.Version=v${version}"
  ];

  postConfigure = lib.optionalString (!stdenv.hostPlatform.isDarwin) ''
    substituteInPlace vendor/github.com/winfsp/cgofuse/fuse/host_cgo.go \
        --replace-fail '"libfuse.so.2"' '"${lib.getLib fuse}/lib/libfuse.so.2"'
  '';

  postInstall =
    let
      rcloneBin =
        if stdenv.buildPlatform.canExecute stdenv.hostPlatform then
          "$out"
        else
          lib.getBin buildPackages.rclone;
    in
    ''
      installManPage rclone.1
      for shell in bash zsh fish; do
        ${rcloneBin}/bin/rclone genautocomplete $shell rclone.$shell
        installShellCompletion rclone.$shell
      done

      # filesystem helpers
      ln -s $out/bin/rclone $out/bin/rclonefs
      ln -s $out/bin/rclone $out/bin/mount.rclone
    ''
    +
      lib.optionalString (enableCmount && !stdenv.hostPlatform.isDarwin)
        # use --suffix here to ensure we don't shadow /run/wrappers/bin/fusermount3,
        # as the setuid wrapper is required as non-root on NixOS.
        ''
          wrapProgram $out/bin/rclone \
            --suffix PATH : "${lib.makeBinPath [ fuse3 ]}"
        '';

  nativeInstallCheckInputs = [
    versionCheckHook
  ];
  doInstallCheck = true;
  versionCheckProgram = "${placeholder "out"}/bin/${meta.mainProgram}";
  versionCheckProgramArg = "version";

  passthru = {
    tests = {
      inherit librclone;
    };
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Command line program to sync files and directories to and from major cloud storage";
    homepage = "https://rclone.org";
    changelog = "https://github.com/rclone/rclone/blob/v${version}/docs/content/changelog.md";
    license = lib.licenses.mit;
    mainProgram = "rclone";
    maintainers = with lib.maintainers; [
      SuperSandro2000
    ];
  };
}
