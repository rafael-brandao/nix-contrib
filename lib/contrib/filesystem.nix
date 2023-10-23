{ lib }:

let
  inherit (builtins)
    readDir
    ;
  inherit (lib)
    filter
    filterAttrs
    flipPipe
    head
    mapAttrsToList
    pathExists
    tail
    ;

  filterDirs = filterAttrs (name: type: type == "directory");
in

rec {

  /*
    Filter paths that exist from a list of paths

    Type: filterValidPaths :: [ path ] -> [ path ]
  */
  filterValidPaths = filter pathExists;


  /*
    Given a directory, return a list of all direct subdirectories
    within it.

    Type: listDirs :: path -> [ path ]
  */
  listDirs = dir:
    let
      asPath = mapAttrsToList (name: type: dir + "/${name}");
    in
    if pathExists dir then
      flipPipe [ readDir filterDirs asPath ] dir
    else
      [ ];


  /*
    Given a directory, return a flattened list of all directories within it recursively.

    Type: path -> [ path ]
  */
  listDirsRecursive = dir:
    let
      go = dirsToList: res:
        if dirsToList == [ ] then res
        else
          let
            subdirs = listDirs (head dirsToList);
          in
          go ((tail dirsToList) ++ subdirs) (res ++ subdirs);
    in
    go [ dir ] [ ];

}
