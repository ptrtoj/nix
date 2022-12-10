{ config, pkgs, ... }:

{
  imports = [
    ./hc.nix
  ];

  networking = {
    hostName = "tp";
    interfaces = {
      enp2s0.useDHCP = true;
      wlp4s0.useDHCP = true;
    };
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    bluetooth.enable = true;
  };

  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };
  };
}
