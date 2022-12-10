{ config, pkgs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.jeon = {
      imports = [
        ./exwm.nix
        ./git.nix
        ./zsh.nix
      ];

      home = {
        stateVersion = "22.11";
        packages = with pkgs; [
          google-chrome
          tree
        ];

        file = {
          ".xinitrc".source = ./xinitrc;
        };
      };

      xdg = {
      };

      programs = {
        feh.enable = true;
        htop.enable = true;
      };

      services = {
        picom = {
          enable = true;
          experimentalBackends = true;
          activeOpacity = 0.9;
          inactiveOpacity = 0.75;
          opacityRules = [
            "99:class_g = 'google-chrome'"
          ];
        };
      };

      xsession = {
        enable = true;
      };
    };
  };
}
