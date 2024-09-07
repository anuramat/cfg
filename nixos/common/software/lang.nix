{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # ~~~~~~~~~~~~~~~~~~~~ compilers {{{1 ~~~~~~~~~~~~~~~~~~~~ #
    go
    nodejs_20
    yarn
    ruby
    perl
    llvm
    clang
    python3
    lua
    texliveFull
    cargo
    rustc
    unstable.stack
    unstable.cabal-install
    # ~~~~~~~~~~~~~~~~~~~~ debuggers {{{1 ~~~~~~~~~~~~~~~~~~~~ #
    delve # Go debugger
    gdb # C
    python311Packages.debugpy
    # ~~~~~~~~~~~~~~~~~~~ formatters {{{1 ~~~~~~~~~~~~~~~~~~~~ #
    alejandra # nix
    nixfmt-rfc-style # nix (OFFICIAL)
    shfmt # posix/bash/mksh
    stylua # Lua
    yamlfmt # YAML
    nodePackages.prettier # formatting
    black # Python
    gofumpt # strict(er) go
    cbfmt # code block formatter (markdown)
    # ~~~~~~~~~~~~~~~~~~~~~ servers {{{1 ~~~~~~~~~~~~~~~~~~~~~ #
    nodePackages_latest.bash-language-server
    nodePackages_latest.yaml-language-server
    lua-language-server
    texlab
    (haskell-language-server.override {supportedGhcVersions = ["948" "927"];})
    nixd
    ccls
    nil
    pyright
    gopls
    marksman
    clang-tools
    # ~~~~~~~~~~~~~~~~~~~~~ linters {{{1 ~~~~~~~~~~~~~~~~~~~~~ #
    luajitPackages.luacheck # lua
    golangci-lint # go
    deadnix # nix dead code
    statix # nix
    shellcheck # *sh
    checkmake # makefile
    # ~~~~~~~~~~~~~~~~~~~~~~ misc {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    jq # json processor
    yq # basic yaml, json, xml, csv, toml processor
    bats # Bash testing
    universal-ctags # maintained ctags
    bear # Compilation database generator for clangd
    luajitPackages.luarocks
    haskellPackages.hoogle
    sageWithDoc # computer algebra system
    # mathematica requires the .sh installer to be in the nix store
    # will probably need to get commented out on the first install
    # maybe make optional later somehow? through a separate flake probably
    mathematica
    # }}}
  ];
}
# vim: fdm=marker fdl=0
