{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    delve # Go debugger
    gdb # C
  ];
}
