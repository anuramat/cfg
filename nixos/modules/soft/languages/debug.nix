{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    delve # Go debugger
  ];
}
