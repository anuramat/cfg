lib:
with lib; let
  # builtins.readDir dir
  # > { "file.nix" = "regular"; some_dir = "directory"; }
  # getTree dir
  # > { "file.nix" = "regular"; some_dir = { ... } ; }
  # getFiles dir
  # > { "file.nix" = "regular"; }
  getFullTree = dir:
    mapAttrs (file: type:
      if type == "directory"
      then getFullTree "${dir}/${file}"
      else type) (builtins.readDir dir);
  getShallowTree = dir: lib.filterAttrs (file: type: type != "directory") (builtins.readDir dir);

  # list of strings of paths relative to the `dir`: [ "file.nix", "some_dir/file.nix", ... ]
  getPathStrings = tree: collect isString (mapAttrsRecursive (path: type: concatStringsSep "/" path) tree);

  # toPath $ filter $ files
  getNixPaths = tree:
    map (file: ./. + "/${file}")
    (filter
      (
        file:
          hasSuffix ".nix" file
          && ! hasSuffix "default.nix" file
      )
      (getPathStrings tree));
in {
  importLevel = path: getNixPaths (getShallowTree path);
  importTree = path: getNixPaths (getFullTree path);
}
