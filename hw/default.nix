{ config, pkgs, ... }:

{
  imports = [
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      timeout = 1;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "splash"
      "quiet"
    ];
  };

  time.timeZone = "Asia/Seoul";

  networking = {
    networkmanager.enable = true;
    useDHCP = false;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ko_KR.UTF-8/UTF-8"
    ];
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ hangul ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs = {
    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "tty";
      };
    };
    ssh = {
      startAgent = true;
      askPassword = "";
    };
  };

  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;
    dbus = {
      enable = true;
    };
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      # When using EXWM
      displayManager.startx.enable = true;
      #xkbOptions = "ctrl:swapcaps";
      # When using KDE5/Plasma
      #desktopManager.plasma5.enable = true;
      #displayManager.sddm.enable = true;
    };
    printing = {
      enable = true;
      webInterface = true;
    };
    avahi = {
      enable = true;
      nssmdns = true;
    };
    system-config-printer.enable = true;
  };

  sound.enable = true;

  hardware = {
    pulseaudio.enable = true;
  };

  users.users.jeon = {
    isNormalUser = true;
    description = "WooHyung Jeon";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      git
      wget
      arandr
      # vim
      # lvm2
      # dosfstools
      # xfsprogs
      # exfat
      # ntfs3g
      # unzip
      # pciutils
      # gnupg
      # udisks
      # cups
      # ghostscript
    ];
    variables.VISUAL = "emacs";
    variables.EDITOR = "emacs";
  };

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      # for Unicode
      font-awesome
      powerline-fonts

      # for Monospaced
      jetbrains-mono
      fira-code

      # for General
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      noto-fonts-emoji

      # for Serif
      libertine
      corefonts
    ];
  };

  nix = {
    package = pkgs.nixUnstable;
    settings.allowed-users = [ "@wheel" ];
    settings.trusted-users = [ "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };
  system.stateVersion = "22.11";
}
