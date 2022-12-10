{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "WooHyung Jeon";
    userEmail = "a@j.day";
    signing = {
      signByDefault = true;
      key = "797DD864B9FD144EBA80FAFC5CD4158C08556C9F";
    };
    aliases = {
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
    };
    delta = {
        enable = true;
        options = {
            line-numbers = true;
            side-by-side = false;
            file-modified-label = "modified:";
        };
    };
  };
}
