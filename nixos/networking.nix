{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "portal";

    networkmanager.enable = true;

    firewall =
      { enable = true;
        allowPing = true;
        allowedTCPPorts = [ 80 443 ];
      };

      # nameservers = [ "127.0.0.1" ];
  };

  # FIXME: there seems to be some issues with stability of this
  # services.dnscrypt-proxy.enable = true;

  environment.systemPackages = [ pkgs.openconnect ];
}