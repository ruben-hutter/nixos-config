{ config, pkgs, ... }:

{
  # === CONTAINERS ===
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;  # Docker compatibility layer
    defaultNetwork.settings.dns_enabled = true;
  };

  virtualisation.containers = {
    enable = true;
    policy = {
      default = [ { type = "insecureAcceptAnything"; } ];
      transports = {
        docker-daemon = {
          "" = [ { type = "insecureAcceptAnything"; } ];
        };
      };
    };
  };

  # === VIRTUAL MACHINES ===
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;

  # === USER PERMISSIONS ===
  users.users.ruben.extraGroups = [
    "libvirtd"
    "podman"
  ];
}
