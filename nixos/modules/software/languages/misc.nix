{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    jq # json processor
    yq # basic yaml, json, xml, csv, toml processor
    bats # Bash testing
    universal-ctags # maintained ctags
    bear # Compilation database generator for clangd
    luajitPackages.luarocks
    haskellPackages.hoogle
  ];
}
