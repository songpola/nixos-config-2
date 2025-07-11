{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkBaseModule config "server" {
  # Bootable EFI system
  ${namespace}.presets.bootable = true;

  # Remote access
  services.openssh.enable = true;
  users.users.${namespace}.openssh.authorizedKeys.keys = [ lib.${namespace}.sshPublicKey ];

  nix.settings = {
    # To prevent the `error: cannot ... because it lacks a signature by a trusted key`
    trusted-users = [ namespace ];
  };
}
