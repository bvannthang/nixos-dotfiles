{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    alacritty = "alacritty";
    fish      = "fish";
    git       = "git";
    i3        = "i3";
    i3status  = "i3status";
    nvim      = "nvim";
  };
in

{
  home.username = "bvannthang";
  home.homeDirectory = "/home/bvannthang";
  programs.git.enable = true;
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
    })
    configs;

  home.packages = with pkgs; [
  ];
}
