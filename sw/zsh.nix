{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    shellAliases = {
      up="nix flake update .";
      ug="sudo nixos-rebuild switch --flake ./#";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "nicoulaj";
      extraConfig = ''
        export GPG_TTY=$(tty)
      '';
    };
  };
}
