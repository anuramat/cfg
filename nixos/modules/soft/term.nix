{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    foot # minimal terminal
    unstable.alacritty # gpu terminal
    unstable.alacritty-theme
    cool-retro-term # cute terminal
  ];
}
