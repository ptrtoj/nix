{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hc.nix
    ];

  networking.hostName = "vm";
}

