{ config, pkgs, ... }:

{
  # ssh-agent as a user systemd socket/service, like the fedora setup
  # ($XDG_RUNTIME_DIR/ssh-agent.socket)
  services.ssh-agent.enable = true;

  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent.socket";
}
