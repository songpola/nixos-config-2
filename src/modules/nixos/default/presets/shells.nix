{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) mkHomeConfigModule getConfigPath;
in
lib.${namespace}.mkPresetModule config [ "shells" ] (mkHomeConfigModule {
  # Setup Nushell
  programs.nushell = {
    enable = true;
    configFile.source = getConfigPath "/nushell/config.nu";
  };

  # Use Nushell as the default shell
  programs.bash = {
    enable = true;
    initExtra = ''
      # Use nushell in place of bash
      if command -v nu >/dev/null 2>&1; then
        SHELL=$(command -v nu) exec nu
      fi
    '';
  };

  # Starship prompt
  programs.starship.enable = true;

  # Carapace completer
  programs.carapace.enable = true;

  # Zoxide
  programs.zoxide.enable = true;
})
